# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit flag-o-matic meson udev python-any-r1

DESCRIPTION="The reference implementation of the Linux FUSE (Filesystem in Userspace) interface"
HOMEPAGE="https://github.com/libfuse/libfuse"
SRC_URI="https://github.com/libfuse/libfuse/releases/download/fuse-3.18.1/fuse-3.18.1.tar.gz -> fuse-3.18.1.tar.gz"
LICENSE="NOASSERTION"
SLOT="3"
KEYWORDS="*"
DOCS=(
	AUTHORS
	ChangeLog.rst
	README.md
	doc/README.NFS
	doc/kernel.txt
)
IUSE="+suid"
BDEPEND="virtual/pkgconfig
	
"
RDEPEND="sys-fs/fuse-common
	
"
src_configure() {
	# bug #853058
	filter-lto
	local emesonargs=(
	  -Dexamples=false
	  -Dtests=false
	  -Duseroot=false
	  -Dinitscriptdir=
	  -Dudevrulesdir="${EPREFIX}$(get_udevdir)/rules.d"
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	# Installed via fuse-common
	rm -r "${ED}"{/etc,$(get_udevdir)} || die
	# useroot=false prevents the build system from doing this.
	use suid && fperms u+s /usr/bin/fusermount3
	# manually install man pages to respect compression
	rm -r "${ED}"/usr/share/man || die
	doman doc/{fusermount3.1,mount.fuse3.8}
}


# vim: filetype=ebuild
