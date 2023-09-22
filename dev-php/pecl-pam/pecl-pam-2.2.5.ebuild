# Distributed under the terms of the GNU General Public License v2

EAPI=7

PHP_EXT_NAME="pam"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
PHP_EXT_ECONF_ARGS=( --with-pam=/usr )
DOCS=( README )

USE_PHP="php7-4 php8-0 php8-1 php8-2"

inherit php-ext-pecl-r3 pam

KEYWORDS="*"

SRC_URI="https://github.com/amishmm/php-pam/tarball/bab7e8f764a7a93a495a32e1b35bff7058c01a86 -> php-pam-2.2.5-bab7e8f.tar.gz"

DESCRIPTION="This extension provides PAM (Pluggable Authentication Modules) integration"
LICENSE="PHP-3.01"
SLOT="0"
IUSE=""

DEPEND="sys-libs/pam"
RDEPEND="${DEPEND}"

post_src_unpack() {
    if [ ! -d "${S}" ] ; then
        mv ${WORKDIR}/amishmm-* ${S} || die
    fi
}

src_prepare() {
	#Fix DOS line endings
	sed -i 's/\r$//' -- pam.c || die
	php-ext-source-r3_src_prepare
}

src_install() {
	pamd_mimic_system php auth account password
	php-ext-pecl-r3_src_install
}