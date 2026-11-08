# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit go-module systemd

DESCRIPTION="cilium-agent, the eBPF-based networking, observability and security agent for Kubernetes nodes"
HOMEPAGE="https://cilium.io"
SRC_URI="https://api.github.com/repos/cilium/cilium/tarball/v1.20.4 -> cilium-1.20.4-beb276d.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="systemd"
RESTRICT="test"
BDEPEND=">=dev-lang/go-1.21
	
"
post_src_unpack() {
	# Generator-recovered api.github.com tarball: the unpack root is
	# cilium-cilium-<sha7>, not ${P}.
	local d
	for d in "${WORKDIR}"/cilium-cilium-*; do
		mv "${d}" "${S}" || die
		# Upstream stamps pkg/version.ciliumVersion with "$(cat VERSION)
		# $(git show --format=%h %aI)" but reads a GIT_VERSION file when
		# the tree has no .git (Makefile.defs). Stamp the sha7 from the
		# unpack root so `cilium-agent --version` carries the revision.
		# Upstream's own file holds "<sha7> <author-date>"; that date is
		# not derivable offline and is not invented here — the raw
		# version string stays exact and the structured parser in
		# pkg/version/version.go sees the same field count as an
		# upstream git-less build.
		echo "${d##*-}" > "${S}/GIT_VERSION" || die
	done
}

src_compile() {
	# Upstream's GO_BUILD passes -mod=vendor explicitly (the archive
	# ships a complete vendor/) and CGO_ENABLED=0; GOFLAGS="" keeps the
	# go-module eclass -mod=readonly export from fighting that flag.
	emake GOFLAGS="" -C daemon
}

src_install() {
	dobin daemon/cilium-agent
	if use systemd ; then
		systemd_dounit "${FILESDIR}"/cilium.service
	else
		newconfd "${FILESDIR}"/cilium.confd cilium
		newinitd "${FILESDIR}"/cilium.initd cilium
	fi
}


# vim: filetype=ebuild
