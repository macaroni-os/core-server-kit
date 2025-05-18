# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Heavily optimized DEFLATE/zlib/gzip (de)compression"
HOMEPAGE="https://github.com/libdeflate/ebiggers"
SRC_URI="https://github.com/ebiggers/libdeflate/tarball/f2bcd47d45394d437ce12a6d222b2fc6abe2e147 -> libdeflate-1.24-f2bcd47.tar.gz"

KEYWORDS="*"


LICENSE="MIT"
SLOT="0"
IUSE="static-libs test"
RESTRICT="!test? ( test )"

post_src_unpack() {
	cd ${WORKDIR} && mv ebiggers-libdeflate-* libdeflate-1.24
}

src-configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=$(usex !static-libs)
		-DBUILD_TESTING=OFF
	)

	cmake_src_configure
}
