# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit toolchain-funcs

DESCRIPTION="An OCI container runtime monitor"
HOMEPAGE="https://github.com/containers/conmon"
SRC_URI="https://api.github.com/repos/containers/conmon/tarball/v2.2.1 -> conmon-2.2.1-c8cc2c4.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
RDEPEND="${DEPEND}
"
DEPEND="dev-libs/glib:=
	sys-libs/libseccomp
	
"

post_src_unpack() {
	mv containers-conmon-* ${S}
}


src_compile() {
	tc-export CC PKG_CONFIG
	emake DISABLE_SYSTEMD=1 bin/conmon
}
src_install() {
	dobin bin/conmon
	dodir /usr/libexec/podman
	dosym ../../bin/conmon /usr/libexec/podman/conmon
}



# vim: filetype=ebuild
