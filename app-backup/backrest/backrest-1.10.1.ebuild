# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
EGO_SKIP_TIDY=1
inherit go-module systemd user

DESCRIPTION="Backrest is a web UI and orchestrator for restic backup."
HOMEPAGE="https://github.com/garethgeorge/backrest"
SRC_URI="
https://api.github.com/repos/garethgeorge/backrest/tarball/v1.10.1 -> backrest-1.10.1-b9181dc.tar.gz
mirror://macaroni/backrest-1.10.1-mark-go-bundle-b9181dc.tar.xz -> backrest-1.10.1-mark-go-bundle-b9181dc.tar.xz"
LICENSE="GPL-3.0"
SLOT="0"
KEYWORDS="*"
IUSE="systemd"
RESTRICT="network-sandbox"
BDEPEND="dev-lang/go
"
RDEPEND="app-backup/restic
	
"
DEPEND="${RDEPEND}
	net-libs/nodejs
	
"

post_src_unpack() {
	mv garethgeorge-backrest-* ${S}
}


pkg_setup() {
	ebegin "Ensuring backrest group and user exist"
	enewgroup backrest
	enewuser backrest -1 -1 /var/lib/backrest backrest
	eend $?
}

src_compile() {
	pushd webui 2>&1 >/dev/null
	npm install . || die
	popd 2>&1 >/dev/null
	GOOS=linux BACKREST_BUILD_VERSION=1.10.1 \
	  go generate ./...
	CGO_ENABLED=0 \
	  go build \
	  -asmflags "-trimpath=${S}" \
	  -gcflags "-trimpath=${S}" \
	  -o backrest ./cmd/backrest
}

src_install() {
	dobin backrest
	diropts -m0750 -o backrest -g backrest
	dodir /var/lib/backrest/
	fowners backrest:backrest /var/lib/backrest
	keepdir /var/lib/backrest
	if use systemd ; then
	  systemd_newunit "${FILESDIR}"/backrest.service backrest.service || die
	else
	  newinitd "${FILESDIR}"/backrest.initd backrest
	fi
	newconfd "${FILESDIR}"/backrest.confd backrest
}



# vim: filetype=ebuild
