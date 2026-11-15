# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit autotools

DESCRIPTION="FUSE implementation for overlayfs"
HOMEPAGE="https://github.com/containers/fuse-overlayfs"
SRC_URI="https://api.github.com/repos/containers/fuse-overlayfs/tarball/v1.18 -> fuse-overlayfs-1.18-899cdaa.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"
BDEPEND="virtual/pkgconfig
"
RDEPEND="${DEPEND}
"
DEPEND="sys-fs/fuse:3=
"

post_src_unpack() {
	mv containers-fuse-overlayfs-* ${S}
}


src_prepare() {
	default
	eautoreconf
}



# vim: filetype=ebuild
