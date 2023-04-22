# Distributed under the terms of the GNU General Public License v2

EAPI=7

PHP_EXT_NAME="raphf"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
PHP_EXT_ECONF_ARGS=""
PHP_INI_NAME="30-${PHP_EXT_NAME}"

USE_PHP=" php7-4 php8-0 php8-1 php8-2 "

inherit php-ext-pecl-r3

KEYWORDS="*"

SRC_URI="https://github.com/m6w6/ext-raphf/tarball/f52e2bcd62aa733f00454bb61933b83443d3e7cb -> ext-raphf-2.0.1-f52e2bc.tar.gz"

DESCRIPTION="A reusable, persistent handle and resource factory API"
LICENSE="BSD-2"
SLOT="7"
IUSE=""

post_src_unpack() {
    if [ ! -d "${S}" ] ; then
        mv ${WORKDIR}/m6w6-* ${S} || die
    fi
}