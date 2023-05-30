# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit php-pear-r2

DESCRIPTION="A package for syntax highlighting"
SRC_URI="https://github.com/pear/Text_Highlighter/tarball/2ccac2d9eaf55dc08bbbdb7136c93fb399d0f855 -> Text_Highlighter-0.8.1-2ccac2d.tar.gz"
LICENSE="PHP-3.01"
SLOT="0"
KEYWORDS="*"
IUSE=""

# There is a documented dependency on XML_Parser, but that's only needed
# for development -- if you want to *generate* the PHP class files. The
# ones in the release are already pre-generated. The dependency on the
# XML_Serializer, on the other hand, is not documented but is requird
# by the XML output renderer.
RDEPEND=">=dev-php/PEAR-PEAR-1.10.1
	dev-php/PEAR-XML_Serializer"

post_src_unpack() {
    if [ ! -d "${S}" ] ; then
        mv ${WORKDIR}/pear-* ${S} || die
    fi
}