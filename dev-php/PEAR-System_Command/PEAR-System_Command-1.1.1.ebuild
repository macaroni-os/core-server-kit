# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PN="${PN/PEAR-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="PHP command-line execution interface"
HOMEPAGE="http://pear.php.net/package/${MY_PN}"
SRC_URI="https://github.com/pear/System_Command/tarball/b0dfe33bbaff50c18bdc91f569d81ebfe195fed5 -> System_Command-1.1.1-b0dfe33.tar.gz"
LICENSE="PHP-3.01"
SLOT="0"
KEYWORDS="*"
IUSE="examples"

RDEPEND="dev-lang/php:*
	dev-php/PEAR-PEAR"

S="${WORKDIR}/${MY_P}"

post_src_unpack() {
    if [ ! -d "${S}" ] ; then
        mv ${WORKDIR}/pear-* ${S} || die
    fi
}

src_install() {
	use examples && dodoc -r docs/test.php

	insinto /usr/share/php
	doins -r System
}