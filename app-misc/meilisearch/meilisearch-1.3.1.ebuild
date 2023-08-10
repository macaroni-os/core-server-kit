# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo user

DESCRIPTION="A lightning-fast search engine that fits effortlessly into your apps, websites, and workflow"
HOMEPAGE="https://www.meilisearch.com/"
SRC_URI="
	https://github.com/meilisearch/meilisearch/tarball/ef3d098b4ddd4e41b3e8aa36856edb284a8a2a39 -> meilisearch-1.3.1-ef3d098.tar.gz
	https://direct.funtoo.org/a6/2f/8a/a62f8a211c0f1b4f1b650841ee138024e1d9644388b4d483594e2058814e0833f9bc4a4c0a72b24d358cdbe8826bdc626c83d4a348dc92d72d72645ff915f212 -> meilisearch-1.3.1-funtoo-crates-bundle-20a78e9600e9c49368d8bf2082be2efd6bd82243529d3f3a068626d749b6c56e12e37f900b08937b1d6f587b0304f2ca442d1aa53163f3d58aef21d0918604d6.tar.gz
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

S="${WORKDIR}/meilisearch-meilisearch-ef3d098"

MEILI_DATA_DIR="/var/lib/${PN}"

pkg_setup() {
	enewgroup "${PN}"
	enewuser "${PN}" -1 -1 "${MEILI_DATA_DIR}" "${PN}"
}

src_prepare() {
	default

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
	export VERGEN_GIT_SHA="ef3d098b4ddd4e41b3e8aa36856edb284a8a2a39"
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