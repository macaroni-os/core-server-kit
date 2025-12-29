# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
CMAKE_BUILD_TYPE=RelWithDebInfo
inherit cmake cargo readme.gentoo-r1 xdg

DESCRIPTION="Friendly Interactive SHell"
HOMEPAGE="http://fishshell.com/"
SRC_URI="
https://api.github.com/repos/fish-shell/fish-shell/tarball/4.3.1 -> fish-4.3.1-a2c5b2a.tar.gz
mirror://macaroni/fish-4.3.1-mark-rust-bundle-a2c5b2a.tar.xz -> fish-4.3.1-mark-rust-bundle-a2c5b2a.tar.xz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
IUSE="nls"
RDEPEND="sys-libs/ncurses
	
"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	
"
src_unpack() {
	cargo_src_unpack
}
post_src_unpack() {
	if [ -e ${S} ] ; then
	  rm -rf ${S}
	fi
	mv fish-shell-fish-shell-* ${S}
}
src_prepare() {
	cmake_src_prepare
}
src_configure() {
	export FISH_BUILD_VERSION="4.3.1-a2c5b2a"
	local mycmakeargs=(
	  -DCMAKE_INSTALL_BINDIR="${EPREFIX}/bin"
	  -DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}/etc"
	  -DCMAKE_INSTALL_LIBDIR="${EPREFIX}/lib"
	  -DBUILD_SHARED_LIBS=True
	  -DINSTALL_DOCS=OFF
	  -DWITH_GETTEXT="$(usex nls)"
	)
	cmake_src_configure
}
src_compile() {
	local -x PREFIX="${EPREFIX}/usr"
	local -x DOCDIR="${EPREFIX}/usr/share/doc/${PF}"
	local -x CMAKE_WITH_GETTEXT="$(usex nls 1 0)"
	local -x SYSCONFDIR="${EPREFIX}/etc"
	local -x FISH_BUILD_DOCS
	FISH_BUILD_DOCS=0
	cargo_src_compile
}
src_install() {
	cmake_src_install
	keepdir /usr/share/fish/vendor_{completions,conf,functions}.d
	insinto /usr/share/doc/fish
	doins "${FILESDIR}"/README.mark
}
pkg_postinst() {
	xdg_pkg_postinst
}


# vim: filetype=ebuild
