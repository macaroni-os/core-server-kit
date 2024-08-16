# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit php-pear-r2

DESCRIPTION="XML parsing class based on PHP's SAX parser"
SRC_URI="https://github.com/pear/XML_Parser/tarball/0134baa2df2054afcca41e9307b98a21db84365d -> XML_Parser-1.3.8-0134baa.tar.gz"


LICENSE="BSD"
SLOT="0"
KEYWORDS="*"
IUSE=""

post_src_unpack() {
    if [ ! -d "${S}" ] ; then
        mv ${WORKDIR}/pear-* ${S} || die
    fi
}

src_test() {
	peardev run-tests -r || die
}