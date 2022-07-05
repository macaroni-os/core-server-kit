# Distributed under the terms of the GNU General Public License v2

EAPI=7

PHP_EXT_NAME="xdiff"
PHP_EXT_PECL_PKG="xdiff"
DOCS=( README.API )

USE_PHP="php7-4 php8-0"
PHP_EXT_PECL_FILENAME="${PN/pecl-/}-2.0.1.tgz"

inherit php-ext-pecl-r3

SRC_URI="https://github.com/php/pecl-text-xdiff/tarball/21857dbe38d052ff0313e7a97086afa8a2398a12 -> pecl-text-xdiff-2.1.1-21857db.tar.gz"

KEYWORDS="*"

DESCRIPTION="PHP extension for generating diff files"
LICENSE="PHP-3.01"
SLOT="7"

DEPEND="dev-libs/libxdiff"
RDEPEND="${DEPEND}"
PHP_EXT_ECONF_ARGS=()

S="${WORKDIR}/${PHP_EXT_PECL_FILENAME/.tgz/}"
PHP_EXT_S="${S}"

post_src_unpack() {
	if [ ! -d "${S}" ] ; then
		mv ${WORKDIR}/php-* ${S} || die
	fi
}