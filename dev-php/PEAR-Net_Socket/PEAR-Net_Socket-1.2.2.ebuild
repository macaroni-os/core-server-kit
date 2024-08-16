# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit php-pear-r2

DESCRIPTION="PHP class interface to TCP sockets"
SRC_URI="https://github.com/pear/Net_Socket/tarball/bbe6a12bb4f7059dba161f6ddd43f369c0ec8d09 -> Net_Socket-1.2.2-bbe6a12.tar.gz"
LICENSE="BSD-2"
SLOT="0"
KEYWORDS="*"
IUSE=""
DEPEND=""
RDEPEND=">=dev-php/PEAR-PEAR-1.10.1"

post_src_unpack() {
    if [ ! -d "${S}" ] ; then
        mv ${WORKDIR}/pear-* ${S} || die
    fi
}