# Distributed under the terms of the GNU General Public License v2

EAPI=7

PHP_EXT_NAME="oauth"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

USE_PHP="php7-4 php8-0 php8-1 php8-2"

inherit php-ext-pecl-r3

KEYWORDS="*"

SRC_URI="https://github.com/php/pecl-web_services-oauth/tarball/5ae2065fa6a2af8796f584632ae6c5c8d4070ac8 -> pecl-web_services-oauth-2.0.9-5ae2065.tar.gz"

DESCRIPTION="OAuth is an authorization protocol built on top of HTTP"
LICENSE="BSD"
SLOT="7"
IUSE="+curl examples"

DEPEND="
	dev-libs/libpcre:3=
	curl? ( net-misc/curl:0= )
	php_targets_php7-4? ( dev-lang/php:7.4[hash(-)] )
	php_targets_php8-0? ( dev-lang/php:8.0[hash(-)] )
	php_targets_php8-1? ( dev-lang/php:8.1[hash(-)] )
	php_targets_php8-2? ( dev-lang/php:8.2[hash(-)] )
"
RDEPEND="${DEPEND}"

post_src_unpack() {
    if [ ! -d "${S}" ] ; then
        mv ${WORKDIR}/php-* ${S} || die
    fi
}

src_configure() {
	local PHP_EXT_ECONF_ARGS=(
		--enable-oauth
		$(use_with curl)
	)
	php-ext-source-r3_src_configure
}