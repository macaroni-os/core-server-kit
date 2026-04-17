# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson systemd

DESCRIPTION="FUSE filesystem for LXC"
HOMEPAGE="https://linuxcontainers.org/lxcfs"
SRC_URI="https://api.github.com/repos/lxc/lxcfs/tarball/v6.0.6 -> lxcfs-6.0.6-7ff173b.tar.gz"
LICENSE="AGPL-3 Apache-2.0 BSD BSD-2 LGPL-3 MIT MPL-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="systemd"
BDEPEND="sys-apps/help2man
	dev-python/jinja
	
"
RDEPEND="sys-fs/fuse:3=
	
"
DEPEND="${RDEPEND}
"

post_src_unpack() {
	mv lxc-lxcfs-* ${S}
}


pkg_setup() {
	export BUILD_DIR=${WORKDIR}/build
}
src_configure() {
	local emesonargs=(
	  --localstatedir "${EPREFIX}/var"
	  -Dfuse-version=3
	  -Dmocks=false
	  -Dtests=false
	  -Dinit-script=
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	if use systemd ; then
	  systemd_dounit "${FILESDIR}"/lxcfs.service
	else
	  newinitd "${FILESDIR}"/lxcfs.initd lxcfs
	fi
	newconfd "${FILESDIR}"/lxcfs.confd lxcfs
	find "${ED}" -name '*.la' -delete || die
	# we are using own init scripts, so do not need included
	rm -rf "${ED}"/etc/rc.d
}



# vim: filetype=ebuild
