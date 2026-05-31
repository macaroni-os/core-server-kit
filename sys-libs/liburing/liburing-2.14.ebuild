# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit autotools toolchain-funcs

DESCRIPTION="Library providing helpers for the Linux kernel io_uring support"
HOMEPAGE="https://github.com/axboe/liburing"
SRC_URI="https://api.github.com/repos/axboe/liburing/tarball/liburing-2.14 -> liburing-2.14-e3d35ea.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE="examples static-libs"
BDEPEND="sys-kernel/linux-headers
	
"

post_src_unpack() {
	mv axboe-liburing-* ${S}
}


src_prepare() {
	default
	if ! use examples; then
	  sed -e '/examples/d' Makefile -i || die
	fi
	sed -e '/test/d' Makefile -i || die
}
src_configure() {
	local myconf=(
	  --prefix="${EPREFIX}/usr"
	  --libdir="${EPREFIX}/usr/$(get_libdir)"
	  --libdevdir="${EPREFIX}/usr/$(get_libdir)"
	  --mandir="${EPREFIX}/usr/share/man"
	  --cc="$(tc-getCC)"
	  --cxx="$(tc-getCXX)"
	  --use-libc
	)
	# No autotools configure! "econf" will fail.
	TMPDIR="${T}" ./configure "${myconf[@]}" || die
}
src_compile() {
	emake V=1 AR="$(tc-getAR)" RANLIB="$(tc-getRANLIB)"
}
src_install() {
	default
	einstalldocs
	if ! use static-libs ; then
	  find "${ED}" -type f -name "*.a" -delete || die
	fi
}



# vim: filetype=ebuild
