# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit fcaps go-module user

DESCRIPTION="Fast and extensible multi-platform HTTP/1-2-3 web server with automatic HTTPS"
HOMEPAGE="https://caddyserver.com"
SRC_URI="
https://api.github.com/repos/caddyserver/caddy/tarball/v2.11.3 -> caddy-2.11.3-cc58caa.tar.gz
mirror://macaroni/caddy-2.11.3-mark-go-bundle-cc58caa.tar.xz -> caddy-2.11.3-mark-go-bundle-cc58caa.tar.xz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
BDEPEND="dev-lang/go
"

post_src_unpack() {
	mv caddyserver-caddy-* ${S}
}


CADDY_USER="${PN}"
CADDY_HOME="/var/www/${CADDY_USER}"
pkg_setup() {
	enewgroup ${CADDY_USER}
	enewuser ${CADDY_USER} -1 -1 "${CADDY_HOME}" ${CADDY_USER}
}
# Upstream reference to set custom compile time Caddy versions:
# https://github.com/caddyserver/caddy/pull/5072/files
src_compile() {
	go build -ldflags '-X github.com/caddyserver/caddy/v2.CustomVersion=v2.11.3-cc58caa-macaroni' \
	-mod=mod ./cmd/caddy || die "compile failed"
}
src_install() {
	dobin ${PN}
	dodoc README.md
	insinto /etc/"${PN}"
	doins "${FILESDIR}"/Caddyfile
	newconfd "${FILESDIR}/${PN}".confd ${PN}
	newinitd "${FILESDIR}/${PN}".initd ${PN}
	keepdir /var/log/"${PN}"
	keepdir /var/www/"${PN}"
	fowners "${CADDY_USER}:${CADDY_USER}" /var/log/"${PN}"
	fowners "${CADDY_USER}:${CADDY_USER}" /var/www/"${PN}"
	fperms 0750 /var/log/"${PN}"
	fperms 0750 /var/www/"${PN}"
}
pkg_postinst() {
	fcaps cap_net_bind_service=eip /usr/bin/caddy
}



# vim: filetype=ebuild
