# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PN="${PN#PEAR-}"
DESCRIPTION="PHP and JavaScript AJAX library"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="*"
IUSE=""
HOMEPAGE="https://pear.php.net/package/${MY_PN}/"
SRC_URI="https://github.com/pear/HTML_AJAX/tarball/a3ef6c049a48ebb560207b3394f2e3c99290c80c -> HTML_AJAX-0.5.8-a3ef6c0.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

post_src_unpack() {
    if [ ! -d "${S}" ] ; then
        mv ${WORKDIR}/pear-* ${S} || die
    fi
}

src_install() {
	insinto /usr/share/php
	doins -r HTML
	insinto "/usr/share/php/data/${MY_PN}"
	doins -r js
}