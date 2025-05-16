# Distributed under the terms of the GNU General Public License v2

EAPI=7

PHP_EXT_NAME="radius"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

USE_PHP="php7-4 php8-0 php8-1 php8-2"
PHP_EXT_PECL_FILENAME="${PN/pecl-/}-${PV/_beta/b}.tgz"
PHP_EXT_S="${WORKDIR}/${PHP_EXT_PECL_FILENAME%.tgz}"
PHP_EXT_NEEDED_USE="pcntl(-),sockets(-)"

inherit php-ext-pecl-r3

KEYWORDS="*"

SRC_URI="https://github.com/LawnGnome/php-radius/tarball/2ade5eedd55049e521d25494e3c2891a352065c4 -> php-radius-1.3.1-2ade5ee.tar.gz"

DESCRIPTION="Provides support for RADIUS authentication (RFC 2865) and accounting (RFC 2866)"
LICENSE="BSD"
SLOT="0"
IUSE="examples"

S="${PHP_EXT_S}"

PATCHES=( "${FILESDIR}/1.4.0-php8.patch" )

post_src_unpack() {
    if [ ! -d "${S}" ] ; then
        mv ${WORKDIR}/LawnGnome-* ${S} || die
    fi
}