# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit php-pear-r2

DESCRIPTION="Color conversion and mixing for PHP5"
SRC_URI="https://github.com/pear/Image_Color2/tarball/c6eaea9fe20cfa4eb6ea6d3485f61219962fdbaf -> Image_Color2-0.5.1-c6eaea9.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="*"
IUSE="test"
DEPEND="test? ( >=dev-php/phpunit-5 )"

post_src_unpack() {
    if [ ! -d "${S}" ] ; then
        mv ${WORKDIR}/pear-* ${S} || die
    fi
}

src_prepare() {
	# Modernize tests
	sed -i -e "/require_once 'PHPUnit\/Framework.php';/d" \
		-e "s/assertType('\(Image_[a-zA-Z2_]*\)',/assertInstanceOf(\1::class,/" \
		-e "s/assertType('array',/assertInternalType('array',/" \
		-e "s/assertType('string',/assertInternalType('string',/" \
		tests/*.php tests/Model/*.php || die
	default
}

src_test() {
	phpunit tests/AllTests.php || die
}