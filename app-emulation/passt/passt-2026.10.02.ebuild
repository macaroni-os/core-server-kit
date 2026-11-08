# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7

DESCRIPTION="User-mode networking daemons for VMs and namespaces"
HOMEPAGE="https://passt.top/"
SRC_URI="https://passt.top/passt/snapshot/passt-2026_10_02.cba3570.tar.xz -> passt-2026_10_02.cba3570.tar.xz"
LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="*"
post_src_unpack() {
	mv ${WORKDIR}/passt-* ${S} || die
}
src_prepare() {
	default
	sed -i -e '/demo/d' Makefile || die
}
src_compile() {
	export VERSION="2026.10.02"
	export prefix="/usr" docdir="/usr/share/doc/passt-2026.10.02"
	emake
}
src_install() {
	emake DESTDIR="${D}" prefix="/usr" docdir="/usr/share/doc/passt-2026.10.02" install
}


# vim: filetype=ebuild
