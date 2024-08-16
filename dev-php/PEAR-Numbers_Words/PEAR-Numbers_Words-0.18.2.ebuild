# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit php-pear-r2

DESCRIPTION="Provides methods for spelling numerals in words"
HOMEPAGE="http://pear.php.net/package/Numbers_Words"
LICENSE="PHP-3.01"
SLOT="0"
KEYWORDS="*"
SRC_URI="https://github.com/pear/Numbers_Words/tarball/e4d1d8e20def443b69fbf3028d1029950d101c9d -> Numbers_Words-0.18.2-e4d1d8e.tar.gz"
IUSE="test"

RDEPEND="dev-php/PEAR-Math_BigInteger"
DEPEND="test? ( ${RDEPEND} dev-php/phpunit )"

DOCS=( ChangeLog README )

post_src_unpack() {
    if [ ! -d "${S}" ] ; then
        mv ${WORKDIR}/pear-* ${S} || die
    fi
}

src_test() {
	phpunit tests || die 'test suite failed'
}