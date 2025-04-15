# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit php-pear-r2

DESCRIPTION="Punycode encoding and decoding"
SRC_URI="https://github.com/pear/Net_IDNA2/tarball/51734eaf8be2df58e8aad5835b9966459b2fb37c -> Net_IDNA2-0.2.0-51734ea.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND=">=dev-php/PEAR-PEAR-1.10.1"

post_src_unpack() {
    if [ ! -d "${S}" ] ; then
        mv ${WORKDIR}/pear-* ${S} || die
    fi
}