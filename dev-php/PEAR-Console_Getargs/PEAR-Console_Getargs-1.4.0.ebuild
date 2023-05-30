# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit php-pear-r2

DESCRIPTION="A command-line arguments parser"
SRC_URI="https://github.com/pear/Console_Getargs/tarball/1936ad540cbf1ea25c210939574a9fe5dc2c595e -> Console_Getargs-1.4.0-1936ad5.tar.gz"


LICENSE="PHP-3"
SLOT="0"
KEYWORDS="*"
IUSE="test"

DEPEND="test? ( dev-php/phpunit )"

post_src_unpack() {
    if [ ! -d "${S}" ] ; then
        mv ${WORKDIR}/pear-* ${S} || die
    fi
}

src_test() {
	phpunit tests/ || die
}