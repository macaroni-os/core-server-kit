# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit php-pear-r2

DESCRIPTION="Easy parsing of URLs (PHP5 port of PEAR-Net_URL package)"
SRC_URI="https://github.com/pear/Net_URL2/tarball/07fd055820dbf466ee3990abe96d0e40a8791f9d -> Net_URL2-2.2.2-07fd055.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="*"
IUSE=""

DOCS=( docs/6470.php docs/example.php )

post_src_unpack() {
    if [ ! -d "${S}" ] ; then
        mv ${WORKDIR}/pear-* ${S} || die
    fi
}