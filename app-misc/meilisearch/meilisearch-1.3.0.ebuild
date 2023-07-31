# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo user

DESCRIPTION="A lightning-fast search engine that fits effortlessly into your apps, websites, and workflow"
HOMEPAGE="https://www.meilisearch.com/"
SRC_URI="
	https://github.com/meilisearch/meilisearch/tarball/5b0157c6c6e719bb4982a915d49b0b103a0302b4 -> meilisearch-1.3.0-5b0157c.tar.gz
	https://direct.funtoo.org/c0/76/37/c076371e78d643114ce2f4a8a503555e5ed64c868be77f98e67624aa59fe9e60ff382165fbc6019b7698ac791aa4a54c69efe398591a955ac6207c371b1531b7 -> meilisearch-1.3.0-funtoo-crates-bundle-20a78e9600e9c49368d8bf2082be2efd6bd82243529d3f3a068626d749b6c56e12e37f900b08937b1d6f587b0304f2ca442d1aa53163f3d58aef21d0918604d6.tar.gz
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

S="${WORKDIR}/meilisearch-meilisearch-5b0157c"

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
	export VERGEN_GIT_SHA="5b0157c6c6e719bb4982a915d49b0b103a0302b4"
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