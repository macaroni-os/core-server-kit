# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit bash-completion-r1 go-module

DESCRIPTION="Define and run multi-container applications with Docker"
HOMEPAGE="https://docs.docker.com/compose/"
SRC_URI="
https://api.github.com/repos/docker/compose/tarball/v5.5.0 -> docker-compose-5.5.0-870908c.tar.gz
mirror://macaroni/docker-compose-5.5.0-mark-go-bundle-870908c.tar.xz -> docker-compose-5.5.0-mark-go-bundle-870908c.tar.xz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
RDEPEND="app-emulation/docker-cli
	
"

post_src_unpack() {
	mv docker-compose-* ${S}
}


src_prepare() {
	default
	# do not strip
	sed -i -e 's/-s -w//' Makefile || die
}
src_compile() {
	emake VERSION=v${PV}
}
src_install() {
	exeinto /usr/libexec/docker/cli-plugins
	doexe bin/build/docker-compose
	dodoc README.md
}



# vim: filetype=ebuild
