# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PN="${PN/PEAR-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Creating passwords with PHP"
HOMEPAGE="http://pear.php.net/package/${MY_PN}"
SRC_URI="https://github.com/pear/Text_Password/tarball/946b3c0c3d50baed08bed9535c0457342f08297e -> Text_Password-1.2.2-946b3c0.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE="test"

RDEPEND="dev-lang/php:*"
DEPEND="test? (	${RDEPEND} dev-php/phpunit )"

S="${WORKDIR}/${MY_P}"

post_src_unpack() {
    if [ ! -d "${S}" ] ; then
        mv ${WORKDIR}/pear-* ${S} || die
    fi
}

src_install() {
	insinto /usr/share/php
	doins -r Text
}

src_test() {
	phpunit tests/ || die 'test suite failed'
}