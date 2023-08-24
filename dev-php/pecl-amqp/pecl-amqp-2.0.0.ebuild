# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_PHP="php7-4 php8-0 php8-1 php8-2"

MY_P="${PN/pecl-/}-${PV/_rc/RC}"

inherit php-ext-pecl-r3

KEYWORDS="*"

SRC_URI="https://github.com/php-amqp/php-amqp/tarball/ed2a2e589b14d5a0b89cdadb1ef8c43b0f3b9d9e -> php-amqp-2.0.0-ed2a2e5.tar.gz"

DESCRIPTION="PHP Bindings for AMQP 0-9-1 compatible brokers"
LICENSE="PHP-3.01"
SLOT="0"
IUSE=""

# Tests require running rabbitmq-server on localhost which requires epmd
# which only accepts /var/run/epmd.pid as pidfile.
RESTRICT="test"

BDEPEND="virtual/pkgconfig"
RDEPEND=">=net-libs/rabbitmq-c-0.7.1:=[ssl(-)]"
DEPEND="${RDEPEND}"
PHP_EXT_ECONF_ARGS=()

post_src_unpack() {
    if [ ! -d "${S}" ] ; then
        mv ${WORKDIR}/php-amqp-* ${S} || die
    fi
}