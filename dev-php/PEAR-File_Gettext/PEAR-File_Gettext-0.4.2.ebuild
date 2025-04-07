# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit php-pear-r2

DESCRIPTION="GNU Gettext file parser"
SRC_URI="https://github.com/pear/File_Gettext/tarball/fb63d46307339f4df5ffb7e5344478f4b1b73ff4 -> File_Gettext-0.4.2-fb63d46.tar.gz"

LICENSE="PHP-3"
SLOT="0"
KEYWORDS="*"
IUSE=""
PATCHES=( "${FILESDIR/File_Gettext-0.4.2-construct.patch}" )

post_src_unpack() {
    if [ ! -d "${S}" ] ; then
        mv ${WORKDIR}/pear-* ${S} || die
    fi
}