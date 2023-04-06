# Distributed under the terms of the GNU General Public License v2

EAPI=7

PHP_EXT_NAME="mcrypt"
USE_PHP="php7-4 php8-0 php8-1 php8-2"
MY_P="${PN/pecl-/}-${PV/_rc/RC}"
PHP_EXT_ECONF_ARGS=()
PHP_EXT_PECL_FILENAME="${MY_P}.tgz"
PHP_EXT_S="${WORKDIR}/${MY_P}"

inherit php-ext-pecl-r3

DESCRIPTION="Bindings for the libmcrypt library"
LICENSE="PHP-3.01"
SLOT="0"
KEYWORDS="*"

SRC_URI="https://github.com/php/pecl-encryption-mcrypt/tarball/ae251198567a546fe63e11480e1bf6f31f21e79c -> pecl-encryption-mcrypt-2.0.7-ae25119.tar.gz"

DEPEND="dev-libs/libltdl
	dev-libs/libmcrypt"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

post_src_unpack() {
    if [ ! -d "${S}" ] ; then
        mv ${WORKDIR}/php-* ${S} || die
    fi
}