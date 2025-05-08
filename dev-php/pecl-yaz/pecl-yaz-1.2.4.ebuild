# Distributed under the terms of the GNU General Public License v2

EAPI=7

PHP_EXT_NAME="yaz"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS=( README )

USE_PHP=" php7-4 php8-0 php8-1 php8-2 "

inherit php-ext-pecl-r3

KEYWORDS="*"

SRC_URI="https://github.com/indexdata/phpyaz/tarball/3012ef17a4f84042a532aeeccd9f01e8e50b6850 -> phpyaz-1.2.4-3012ef1.tar.gz"

DESCRIPTION="This extension implements a Z39.50 client for PHP using the YAZ toolkit"
LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND=">=dev-libs/yaz-3.0.2:0="
RDEPEND="${DEPEND}"

# Needs network access
RESTRICT="test"

PHP_EXT_ECONF_ARGS="--with-yaz=/usr"

post_src_unpack() {
    if [ ! -d "${S}" ] ; then
        mv ${WORKDIR}/indexdata-* ${S} || die
    fi
}