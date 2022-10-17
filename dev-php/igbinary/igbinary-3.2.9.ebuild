# Distributed under the terms of the GNU General Public License v2

EAPI=7
PHP_EXT_NAME="${PN}"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS=( CREDITS NEWS README.md )
PHP_EXT_ECONF_ARGS=( --enable-${PN} )

USE_PHP="php7-4 php8-0 php8-1"

inherit php-ext-source-r3

KEYWORDS="*"

DESCRIPTION="A fast drop-in replacement for the standard PHP serialize"
HOMEPAGE="https://github.com/igbinary/igbinary"
SRC_URI="https://github.com/igbinary/igbinary/tarball/e02668da99e59f388e98738203bfef8d10ec3b55 -> igbinary-3.2.9-e02668d.tar.gz"

LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

post_src_unpack() {
        if [ ! -d "${S}" ]; then
                mv igbinary-igbinary* "${S}" || die
        fi
}