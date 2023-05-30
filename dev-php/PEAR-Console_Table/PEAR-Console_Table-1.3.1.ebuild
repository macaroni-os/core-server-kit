# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit php-pear-r2

DESCRIPTION="Class that makes it easy to build console style tables"
SRC_URI="https://github.com/pear/Console_Table/tarball/1930c11897ca61fd24b95f2f785e99e0f36dcdea -> Console_Table-1.3.1-1930c11.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="*"
IUSE=""

post_src_unpack() {
    if [ ! -d "${S}" ] ; then
        mv ${WORKDIR}/pear-* ${S} || die
    fi
}

src_install() {
	insinto /usr/share/php/Console
	doins Table.php
	php-pear-r2_install_packagexml
}