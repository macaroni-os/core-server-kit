# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN/PEAR-/}"
MY_PV="${PV/_/}"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="PHP interface to the GNU Privacy Guard (GnuPG)"
HOMEPAGE="http://pear.php.net/package/${MY_PN}"
SRC_URI="https://github.com/pear/Crypt_GPG/tarball/29c0fbe96d0d4063ecd5c9a4644cb65a7fb7cc4e -> Crypt_GPG-1.6.7-29c0fbe.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="*"
IUSE="test"

RDEPEND="app-crypt/gnupg
	dev-lang/php:*[posix,unicode]
	dev-php/PEAR-Console_CommandLine
	dev-php/PEAR-Exception"
BDEPEND="test? ( ${RDEPEND} dev-php/phpunit )"

S="${WORKDIR}/${MY_P}"

post_src_unpack() {
    if [ ! -d "${S}" ] ; then
        mv ${WORKDIR}/pear-* ${S} || die
    fi
}

src_prepare() {
	default
	sed -i "s|@bin-dir@|${EPREFIX}/usr/bin|" Crypt/GPG/Engine.php || die
	sed -i "s|@package-name@|${MY_PN}|" Crypt/GPG/PinEntry.php || die
	sed -i "s|@data-dir@|${EPREFIX}/usr/share|" Crypt/GPG/PinEntry.php || die
}

src_install() {
	dodoc README.md
	dobin scripts/crypt-gpg-pinentry

	insinto "/usr/share/${MY_PN}"
	doins -r data

	insinto /usr/share/php
	doins -r Crypt
}

src_test() {
	phpunit tests/ || die "test suite failed"
}