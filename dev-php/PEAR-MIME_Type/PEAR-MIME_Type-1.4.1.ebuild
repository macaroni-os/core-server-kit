# Distributed under the terms of the GNU General Public License v2

EAPI=6

HOMEPAGE="https://pear.php.net/package/MIME_Type"
SRC_URI="https://github.com/pear/MIME_Type/tarball/fcf331a1202dff64599342a6dee02bbe3ef145ac -> MIME_Type-1.4.1-fcf331a.tar.gz"
DESCRIPTION="Utility class for dealing with MIME types"
LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="*"
IUSE=""
RDEPEND=">=dev-lang/php-5.4:*
	>=dev-php/pear-1.9
	dev-php/PEAR-System_Command"
S="${WORKDIR}/${P#PEAR-}"

post_src_unpack() {
    if [ ! -d "${S}" ] ; then
        mv ${WORKDIR}/pear-* ${S} || die
    fi
}

src_install(){
	insinto /usr/share/php
	doins -r MIME
}