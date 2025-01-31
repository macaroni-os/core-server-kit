# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PN="${PN/PEAR-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Provides an object oriented interface for the W3 CSS Validator"
HOMEPAGE="http://pear.php.net/package/${MY_PN}"
SRC_URI="https://github.com/pear/Services_W3C_CSSValidator/tarball/7bdd699db01db74ad91ec857c268be13b4d639fa -> Services_W3C_CSSValidator-0.2.3-7bdd699.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="*"
IUSE="examples"

RDEPEND="dev-lang/php:*
	dev-php/PEAR-HTTP_Request2"

S="${WORKDIR}/${MY_P}"

post_src_unpack() {
    if [ ! -d "${S}" ] ; then
        mv ${WORKDIR}/pear-* ${S} || die
    fi
}

src_install() {
	use examples && dodoc -r docs/examples

	insinto /usr/share/php
	doins -r Services
}