# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PN="${PN/PEAR-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Pure-PHP arbitrary precision integer arithmetic library"
HOMEPAGE="http://pear.php.net/package/${MY_PN}
	http://phpseclib.sourceforge.net/documentation/math.html"
SRC_URI="https://github.com/pear/Math_BigInteger/tarball/33d4357543037a458fad3e8c837a01b93104e592 -> Math_BigInteger-1.0.3-33d4357.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE=""
DEPEND=""
RDEPEND="dev-lang/php:*"

S="${WORKDIR}/${MY_P}"

post_src_unpack() {
    if [ ! -d "${S}" ] ; then
        mv ${WORKDIR}/pear-* ${S} || die
    fi
}

src_install() {
	insinto /usr/share/php
	doins -r Math

	dodoc demo/{benchmark,demo}.php
}