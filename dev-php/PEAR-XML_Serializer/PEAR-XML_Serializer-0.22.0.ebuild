# Distributed under the terms of the GNU General Public License v2

EAPI="6"
inherit php-pear-r2

DESCRIPTION="Swiss-army knife for reading and writing XML files"
SRC_URI="https://github.com/pear/XML_Serializer/tarball/f171521481144ba7fe1dd26fab5d56626248b173 -> XML_Serializer-0.22.0-f171521.tar.gz"


LICENSE="BSD"
SLOT="0"
KEYWORDS="*"
IUSE="examples test"

RDEPEND="dev-lang/php:*[xml]
	>=dev-php/PEAR-XML_Parser-1.2.7
	>=dev-php/PEAR-XML_Util-1.1.1-r1
	"
DEPEND="test? ( ${RDEPEND} )"

post_src_unpack() {
    if [ ! -d "${S}" ] ; then
        mv ${WORKDIR}/pear-* ${S} || die
    fi
}

src_install() {
	php-pear-r2_src_install
	if use examples ; then
		insinto /usr/share/php/docs/${PN/PEAR-//}
		doins -r examples
	fi
}

src_test() {
	peardev run-tests -r || die
}