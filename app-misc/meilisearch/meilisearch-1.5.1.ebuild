# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo user

DESCRIPTION="A lightning-fast search engine that fits effortlessly into your apps, websites, and workflow"
HOMEPAGE="https://www.meilisearch.com/"
SRC_URI="
	https://github.com/meilisearch/meilisearch/tarball/afa8f273a8e958ac5fba8bc6253d5b97473fcbfb -> meilisearch-1.5.1-afa8f27.tar.gz
	https://direct.funtoo.org/bc/11/8a/bc118aead679f2dba7be1a5a8ae1e7285996b0a62fcd8fa817a9416f837b4dba87a035a155497c1ebf902b260ff49c843d0c49b6906479b7f5d221085af6e05d -> meilisearch-1.5.1-funtoo-crates-bundle-c5efbe339df9842cfe1eb24cf1d699871d2f84bab41b4f2709a74e31a961fc2222e183ed552462f847ee6987142f1f9ce629a5d3396a91af8fe7399d4528034e.tar.gz
	https://dotsrc.dl.osdn.net/osdn/unidic/58338/unidic-mecab-2.1.2_src.zip -> unidic-mecab-2.1.2_src.zip
	mini-dashboard? ( https://github.com/meilisearch/mini-dashboard/releases/download/v0.2.11/build.zip -> meilisearch-mini-dashboard-83cd44ed1e5f97ecb581dc9f958a63f4ccc982d9.zip )
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

S="${WORKDIR}/meilisearch-meilisearch-afa8f27"

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
		sed -i "s|https://github.com/meilisearch/mini-dashboard/releases/download/v0.2.11/build.zip|${DISTDIR}/meilisearch-mini-dashboard-83cd44ed1e5f97ecb581dc9f958a63f4ccc982d9.zip|g" "${S}"/meilisearch/Cargo.toml

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
	export VERGEN_GIT_SHA="afa8f273a8e958ac5fba8bc6253d5b97473fcbfb"
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