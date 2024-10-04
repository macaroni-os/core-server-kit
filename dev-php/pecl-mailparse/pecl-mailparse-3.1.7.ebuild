# Distributed under the terms of the GNU General Public License v2

EAPI=7

WANT_AUTOMAKE="none"
PHP_EXT_NAME="mailparse"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
PHP_EXT_ECONF_ARGS=""

USE_PHP="php7-4 php8-0 php8-1 php8-2"

PHP_EXT_NEEDED_USE="unicode"
DOCS=( README.md )

inherit php-ext-pecl-r3

KEYWORDS="*"

SRC_URI="https://github.com/php/pecl-mail-mailparse/tarball/4511a6f238ff73cabd0f025650ba22583afa49dc -> pecl-mail-mailparse-3.1.7-4511a6f.tar.gz"

DESCRIPTION="PHP extension for parsing and working with RFC822 and MIME compliant messages"
LICENSE="PHP-3.01"
SLOT="7"
IUSE=""

post_src_unpack() {
    if [ ! -d "${S}" ] ; then
        mv ${WORKDIR}/php-* ${S} || die
    fi
}