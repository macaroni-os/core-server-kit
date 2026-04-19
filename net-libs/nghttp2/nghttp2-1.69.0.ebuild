# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7

DESCRIPTION="HTTP/2 C Library"
HOMEPAGE="https://nghttp2.org/"
SRC_URI="https://github.com/nghttp2/nghttp2/releases/download/v1.69.0/nghttp2-1.69.0.tar.xz -> nghttp2-1.69.0.tar.xz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE="debug hpack-tools jemalloc static-libs +threads utils xml"
RDEPEND="hpack-tools? ( >=dev-libs/jansson-2.5 )
	jemalloc? ( dev-libs/jemalloc )
	utils? (
	  >=dev-libs/libev-4.15
	  >=sys-libs/zlib-1.2.3
	  net-dns/c-ares:=
	)
	xml? ( >=dev-libs/libxml2-2.7.7:2 )
	
"
DEPEND="${RDEPEND}
	dev-libs/openssl
	virtual/pkgconfig
	
"
src_configure() {
	local myeconfargs=(
	  --disable-examples
	  --disable-failmalloc
	  --disable-werror
	  $(use_enable debug)
	  $(use_enable hpack-tools)
	  $(use_enable static-libs static)
	  $(use_enable threads)
	  $(use_enable utils app)
	  $(use_with jemalloc)
	  $(use_with xml libxml2)
	)
	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}

src_install() {
	default
	if ! use static-libs ; then
	  find "${ED}"/usr -name '*.la' -delete || die
	fi
}


# vim: filetype=ebuild
