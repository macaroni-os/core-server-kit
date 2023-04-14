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

SRC_URI="https://github.com/php/pecl-encryption-mcrypt/tarball/afb7052e1fa604c383c57a4354443167522f3953 -> pecl-encryption-mcrypt-1.0.6-afb7052.tar.gz"

DEPEND="dev-libs/libltdl
	dev-libs/libmcrypt"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

post_src_unpack() {
    if [ ! -d "${S}" ] ; then
        mv ${WORKDIR}/php-* ${S} || die
    fi
}