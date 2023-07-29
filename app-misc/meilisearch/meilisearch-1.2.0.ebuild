# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo user

DESCRIPTION="A lightning-fast search engine that fits effortlessly into your apps, websites, and workflow"
HOMEPAGE="https://www.meilisearch.com/"
SRC_URI="
	https://github.com/meilisearch/meilisearch/tarball/d963b5f85ae9aea42615924de4e41e96a1e5358e -> meilisearch-1.2.0-d963b5f.tar.gz
	https://direct.funtoo.org/12/b9/1b/12b91be9c841eb2a42d3fd58443d8235d609c067c7280ae6d71bbb9ab51df57fdc1ce85caf1625368454f367a3517d041b8b197faf4a5c4b26ce2047655ea9a6 -> meilisearch-1.2.0-funtoo-crates-bundle-f3a0c69e410b1d02ed30144270edf38ce13361aad79514b9b569420f5d77f19693e3704e35d4104e09c930867f301002466b7970e6c8e86bec98f173de87f467.tar.gz
	mini-dashboard? ( https://github.com/meilisearch/mini-dashboard/releases/download/v0.2.7/build.zip -> meilisearch-mini-dashboard-28b45bf772c84f9a6e16bc1689b393bfce8da7d6.zip )
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

S="${WORKDIR}/meilisearch-meilisearch-d963b5f"

MEILI_DATA_DIR="/var/lib/${PN}"

pkg_setup() {
	enewgroup "${PN}"
	enewuser "${PN}" -1 -1 "${MEILI_DATA_DIR}" "${PN}"
}

src_prepare() {
	default

	if use mini-dashboard; then
		# Inject path to downloaded mini-dashboard build
		sed -i "s|https://github.com/meilisearch/mini-dashboard/releases/download/v0.2.7/build.zip|${DISTDIR}/meilisearch-mini-dashboard-28b45bf772c84f9a6e16bc1689b393bfce8da7d6.zip|g" "${S}"/meilisearch/Cargo.toml

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
	export VERGEN_GIT_SHA="d963b5f85ae9aea42615924de4e41e96a1e5358e"
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