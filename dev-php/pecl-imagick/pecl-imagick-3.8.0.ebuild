# Distributed under the terms of the GNU General Public License v2

EAPI=7

PHP_EXT_NAME="imagick"

USE_PHP="php7-4 php8-0 php8-1 php8-2"

inherit php-ext-pecl-r3

KEYWORDS="*"

SRC_URI="https://github.com/Imagick/imagick/tarball/555bf68b592a8d9d0a0a2f37d1256a8b6cf2d39e -> imagick-3.8.0-555bf68.tar.gz"

DESCRIPTION="PHP wrapper for the ImageMagick library"
HOMEPAGE="https://pecl.php.net/package/imagick https://github.com/Imagick/imagick"
LICENSE="PHP-3.01"
SLOT="0"
IUSE="examples test"
RESTRICT="!test? ( test )"

# imagemagick[-openmp] is needed wrt bug 547922 and upstream
# https://github.com/Imagick/imagick#openmp
RDEPEND=">=media-gfx/imagemagick-6.2.4:=[-openmp]"
DEPEND="${RDEPEND}
	test? ( >=media-gfx/imagemagick-6.2.4:=[hdri,jpeg,png,svg,truetype,xml] )"

PHP_EXT_ECONF_ARGS="--with-imagick=${EPREFIX}/usr"

post_src_unpack() {
    if [ ! -d "${S}" ] ; then
        mv ${WORKDIR}/Imagick-* ${S} || die
    fi
}

src_install() {
	php-ext-pecl-r3_src_install

	php-ext-source-r3_addtoinifiles "imagick.skip_version_check" "1"
}