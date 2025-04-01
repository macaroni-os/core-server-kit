# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PN="${PN/-/_}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="The PEAR Exception base class"
HOMEPAGE="http://pear.php.net/package/${MY_PN}"
SRC_URI="https://github.com/pear/PEAR_Exception/tarball/b14fbe2ddb0b9f94f5b24cf08783d599f776fff0 -> PEAR_Exception-1.0.2-b14fbe2.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="*"
IUSE="test"
RDEPEND="dev-lang/php:*
	!<=dev-php/PEAR-PEAR-1.10.3-r1"
DEPEND="test? ( ${RDEPEND} dev-php/phpunit )"
S="${WORKDIR}/${MY_P}"

post_src_unpack() {
    if [ ! -d "${S}" ] ; then
        mv ${WORKDIR}/pear-* ${S} || die
    fi
}

src_install() {
	insinto /usr/share/php
	doins -r PEAR
}

src_test() {
	phpunit tests || die "test suite failed"
}