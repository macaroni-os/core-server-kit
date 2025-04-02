# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit php-pear-r2

DESCRIPTION="Easy parsing of URLs (PHP5 port of PEAR-Net_URL package)"
SRC_URI="https://github.com/pear/Net_URL2/tarball/c1f2b316ed9b05e881cdb494f7550ddf817c76c8 -> Net_URL2-2.2.3-c1f2b31.tar.gz"

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