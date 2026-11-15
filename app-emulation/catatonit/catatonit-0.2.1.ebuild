# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit autotools

DESCRIPTION="A container init that is so simple it is effectively brain-dead"
HOMEPAGE="https://github.com/openSUSE/catatonit"
SRC_URI="https://api.github.com/repos/openSUSE/catatonit/tarball/v0.2.1 -> catatonit-0.2.1-bb3b96b.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"

post_src_unpack() {
	mv openSUSE-catatonit-* ${S}
}


src_prepare() {
	default
	eautoreconf
}
src_install() {
	default
	dodir /usr/libexec/podman
	dosym ../../bin/catatonit /usr/libexec/podman/catatonit
}



# vim: filetype=ebuild
