
EAPI=6

inherit toolchain-funcs flag-o-matic

DESCRIPTION=""
HOMEPAGE="http://www.zlib.net/pigz/"
SRC_URI="https://github.com/madler/pigz/tarball/fe4894f57739e3039a2ffc2a2a360d35e19bacbe -> pigz-2.8-fe4894f.tar.gz"
LICENSE="ZLIB"

SLOT="0"
KEYWORDS="*"
IUSE="static symlink test"

S="${WORKDIR}/madler-pigz-fe4894f"

LIB_DEPEND="sys-libs/zlib[static-libs(+)]"
RDEPEND="!static? ( ${LIB_DEPEND//\[static-libs(+)]} )"
DEPEND="${RDEPEND}
	static? ( ${LIB_DEPEND} )
	test? ( app-arch/ncompress )"

src_compile() {
	use static && append-ldflags -static
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install() {
	dobin ${PN}
	dosym ${PN} /usr/bin/un${PN}
	dodoc README
	doman ${PN}.1

	if use symlink; then
		dosym ${PN} /usr/bin/gzip
		dosym un${PN} /usr/bin/gunzip
	fi
}