# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit php-pear-r2

DESCRIPTION="Advanced text manipulations in images"
SRC_URI="https://github.com/pear/Image_Text/tarball/74d95e4cffa0f14b3f56dd573554b4a40820ef53 -> Image_Text-0.7.0-74d95e4.tar.gz"
LICENSE="PHP-3"
SLOT="0"

KEYWORDS="*"
IUSE="test"

RDEPEND="dev-lang/php:*[gd,truetype]"
DEPEND="test? ( ${RDEPEND} dev-php/phpunit )"

post_src_unpack() {
    if [ ! -d "${S}" ] ; then
        mv ${WORKDIR}/pear-* ${S} || die
    fi
}

src_test() {
	phpunit tests || die
}