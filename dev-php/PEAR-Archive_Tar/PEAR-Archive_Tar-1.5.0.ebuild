# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN/PEAR-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Tar file management class"
HOMEPAGE="http://pear.php.net/package/${MY_PN}"
SRC_URI="https://github.com/pear/Archive_Tar/tarball/b439c859564f5cbb0f64ad6002d0afe84a889602 -> Archive_Tar-1.5.0-b439c85.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="*"
IUSE=""

# bzip2 and zlib are needed for compressed tarballs, and there's one
# call to preg_match to test paths against a pattern of files and
# directories that will be ignored.
RDEPEND="dev-lang/php:*[bzip2,pcre(+),zlib]"
PDEPEND="dev-php/PEAR-PEAR"
DEPEND=""

S="${WORKDIR}/${MY_P}"

post_src_unpack() {
    if [ ! -d "${S}" ] ; then
        mv ${WORKDIR}/pear-* ${S} || die
    fi
}

src_install() {
	insinto /usr/share/php
	doins -r Archive

	dodoc docs/*
}