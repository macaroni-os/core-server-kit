# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7

DESCRIPTION="Fast and low-memory footprint OCI container runtime fully written in C"
HOMEPAGE="https://github.com/containers/crun"
SRC_URI="https://github.com/containers/crun/releases/download/1.30.1/crun-1.30.1.tar.gz -> crun-1.30.1.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
BDEPEND="sys-kernel/linux-headers
	virtual/pkgconfig
	
"
RDEPEND="${DEPEND}
"
DEPEND="dev-libs/json-c:=
	sys-libs/libcap
	sys-libs/libseccomp
	
"
src_configure() {
	econf --disable-systemd --enable-embedded-blake3=yes
}
src_install() {
	emake DESTDIR="${D}" install-exec
	doman crun.1
}


# vim: filetype=ebuild
