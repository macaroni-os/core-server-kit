# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo user

DESCRIPTION="A lightning-fast search engine that fits effortlessly into your apps, websites, and workflow"
HOMEPAGE="https://www.meilisearch.com/"
SRC_URI="
	https://github.com/meilisearch/meilisearch/tarball/7d699532676b6ad3a692130fe721c88565cf7bc3 -> meilisearch-1.8.3-7d69953.tar.gz
	https://direct.funtoo.org/0a/61/ee/0a61eed428159e7ea0f55118bef635aea9de5b61c79d4e8b26f8273924eb4320ab1e1a152eb5c7029dbd0811b2d01eedc4143f139f4e4fc147386ab053a42ca9 -> meilisearch-1.8.3-funtoo-crates-bundle-d37f3e40c4ee9ea9fb7a87c9f47149e75e92b9648cf0f138b4559b1ff0bdbee3ee101be9c7e12b47b60ad84f573f3a54bf2438e6099b617aace16c26162bf045.tar.gz
	https://dotsrc.dl.osdn.net/osdn/unidic/58338/unidic-mecab-2.1.2_src.zip -> unidic-mecab-2.1.2_src.zip
	mini-dashboard? ( https://github.com/meilisearch/mini-dashboard/releases/download/v0.2.13/build.zip -> meilisearch-mini-dashboard-e20cc9b390003c6c844f4b8bcc5c5013191a77ff.zip )
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE="+mini-dashboard"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/rust
"

S="${WORKDIR}/meilisearch-meilisearch-7d69953"

MEILI_DATA_DIR="/var/lib/${PN}"

pkg_setup() {
	enewgroup "${PN}"
	enewuser "${PN}" -1 -1 "${MEILI_DATA_DIR}" "${PN}"
}

src_prepare() {
	default

	# Patch lindera-unidic to use the unidic-mecab src downloaded by the ebuild
	local lindera_unidic_build=$(find "${WORKDIR}"/cargo_home/gentoo/lindera-unidic-* -iname build.rs)

	# Replace the input/unpacked folder with our version
	sed -i 's|\(let input_dir =.*\)\("unidic-mecab.*"\)\(.*\)|\1"unidic-mecab-2.1.2_src"\3|' "${lindera_unidic_build}"

	# Replace the path to the source with the one downloaded by the ebuild
	sed -i "s|\(let source_path_for_build =\).*$|\1 Path::new("'"'"${DISTDIR}/unidic-mecab-2.1.2_src.zip"'"'");|" "${lindera_unidic_build}"

	if use mini-dashboard; then
		# Inject path to downloaded mini-dashboard build
		sed -i "s|https://github.com/meilisearch/mini-dashboard/releases/download/v0.2.13/build.zip|${DISTDIR}/meilisearch-mini-dashboard-e20cc9b390003c6c844f4b8bcc5c5013191a77ff.zip|g" "${S}"/meilisearch/Cargo.toml

		# Replace HTTP fetch with direct file read
		sed -i -r 's|(let dashboard_assets_bytes =)(.*)$|\1 std::fs::read(url)?;|' "${S}"/meilisearch/build.rs
	fi
}

src_configure() {
	CARGO_FEATURES=(
		"analytics"
		"meilisearch-types/all-tokenizations"
		"$(usex mini-dashboard mini-dashboard '')"
	)

	default
}

src_compile() {
	export VERGEN_GIT_SHA="7d699532676b6ad3a692130fe721c88565cf7bc3"
	export VERGEN_GIT_SEMVER_LIGHTWEIGHT="${PV}"

	cargo build --release -p meilisearch \
		--no-default-features ${CARGO_FEATURES:+--features "${CARGO_FEATURES[*]}"} || die "compile failed"
}

src_install() {
	cargo_src_install --path meilisearch --frozen \
		--no-default-features ${CARGO_FEATURES:+--features "${CARGO_FEATURES[*]}"}

	mkdir -p "${ED}"/"${MEILI_DATA_DIR}"
	pushd "${ED}"/"${MEILI_DATA_DIR}"

	for dir in data dumps snapshots; do
		mkdir "${dir}"

		pushd "${dir}" >/dev/null
		touch .keep
		popd >/dev/null
	done

	fowners -R "${PN}":"${PN}" /var/lib/meilisearch
	fperms -R 750 /var/lib/meilisearch

	insinto /etc
	doins "${FILESDIR}"/"${PN}".toml
	fowners "${PN}":"${PN}" /etc/"${PN}".toml

	newinitd "${FILESDIR}"/"${PN}".initd "${PN}"
}