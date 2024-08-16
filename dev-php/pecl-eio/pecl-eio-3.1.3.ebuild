# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN/pecl-}"
MY_PV="${PV/_rc/RC}"
MY_P="${MY_PN}-${MY_PV}"
PHP_EXT_NAME="eio"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
PHP_EXT_PECL_FILENAME="${MY_P}.tgz"
PHP_EXT_S="${WORKDIR}/${MY_P}"
DOCS=( README.md )

USE_PHP="php7-4 php8-0 php8-1 php8-2"

inherit php-ext-pecl-r3

KEYWORDS="*"

SRC_URI="https://github.com/rosmanov/pecl-eio/tarball/5df1db0f39aa4dca1ff74f4339cacf78ce4132c1 -> pecl-eio-3.1.3-5df1db0.tar.gz"

LICENSE="PHP-3.01"

DESCRIPTION="PHP wrapper for libeio library"
LICENSE="PHP-3"
SLOT="0"
IUSE="debug"

S="${PHP_EXT_S}"

post_src_unpack() {
    if [ ! -d "${S}" ] ; then
        mv ${WORKDIR}/rosmanov-* ${S} || die
    fi
}

src_configure() {
	local PHP_EXT_ECONF_ARGS=("--with-eio" "$(use_enable debug eio-debug)" )
	php-ext-source-r3_src_configure
}