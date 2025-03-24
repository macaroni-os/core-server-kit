# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit php-pear-r2

DESCRIPTION="Provides an easy way to perform HTTP requests"
SRC_URI="https://github.com/pear/HTTP_Request2/tarball/f010a16ccddd1ee7d2ee085e8006ee712c00f706 -> HTTP_Request2-2.6.0-f010a16.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="*"
IUSE="+curl +fileinfo +ssl test +zlib"

RDEPEND="dev-lang/php:*[curl?,fileinfo?,ssl?,zlib?]
>=dev-php/PEAR-Net_URL2-2.2.0"
DEPEND="test? ( ${RDEPEND} dev-php/phpunit )"

post_src_unpack() {
    if [ ! -d "${S}" ] ; then
        mv ${WORKDIR}/pear-* ${S} || die
    fi
}

src_prepare() {
	sed -i "s~@data_dir@~${EPREFIX}/usr/share/php/data~" HTTP/Request2/CookieJar.php || die
	default
}

src_test() {
	phpunit tests || die
}

src_install() {
	php-pear-r2_src_install
	insinto "/usr/share/php/data/${PHP_PEAR_PKG_NAME}"
	doins data/*
}