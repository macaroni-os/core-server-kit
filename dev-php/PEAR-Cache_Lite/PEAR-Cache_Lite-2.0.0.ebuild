# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit php-pear-r2

KEYWORDS="*"
DESCRIPTION="Fast and safe little cache system"
SRC_URI="https://github.com/pear/Cache_Lite/tarball/fc7c6703cfbddc55c80c5ae3926dcc80c1d993f9 -> Cache_Lite-2.0.0-fc7c670.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="test"

RDEPEND=">=dev-php/PEAR-PEAR-1.10.1"
DEPEND="test? ( ${RDEPEND} )"
DOCS=( README.md TODO docs/technical docs/examples )

post_src_unpack() {
    if [ ! -d "${S}" ] ; then
        mv ${WORKDIR}/pear-* ${S} || die
    fi
}

src_test() {
	peardev run-tests -r || die
}