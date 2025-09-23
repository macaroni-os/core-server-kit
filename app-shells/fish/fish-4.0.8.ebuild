# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit cmake cargo readme.gentoo-r1 xdg

DESCRIPTION="Friendly Interactive SHell"
HOMEPAGE="http://fishshell.com/"
SRC_URI="
https://api.github.com/repos/fish-shell/fish-shell/tarball/4.0.8 -> fish-4.0.8-b1ec703.tar.gz
mirror://macaroni/fish-4.0.8-mark-rust-bundle-b1ec703.tar.xz -> fish-4.0.8-mark-rust-bundle-b1ec703.tar.xz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
PATCHES=(
	"${FILESDIR}/fish-4.0.2-use-cargo-eclass-for-build.patch"
)
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
	export FISH_BUILD_VERSION="4.0.8-b1ec703"
	local mycmakeargs=(
	  -DCMAKE_INSTALL_BINDIR="${EPREFIX}/bin"
	  -DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}/etc"
	  -DCMAKE_INSTALL_LIBDIR="${EPREFIX}/lib"
	  -DBUILD_SHARED_LIBS=True
	  -DCMAKE_BUILD_TYPE=RelWithDebInfo
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
