# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="The minimal, blazing-fast, and infinitely customizable prompt for any shell"
HOMEPAGE="https://github.com/starship/starship"
SRC_URI="https://github.com/starship/starship/tarball/661c8a2c1cc43b1c0ba1f034ee1dd17442cce815 -> starship-1.23.0-661c8a2.tar.gz
https://distfiles.macaronios.org/07/6d/18/076d18137674193cea06d7c8a79a911ffb73ec2d45e311b429aa8d2673334217b70be150d9d4411785dd1ef842e432059ee366881a0140a78d5a6c8dd61fb643 -> starship-1.23.0-funtoo-crates-bundle-39c9ed0ee4e4c669b67badcd8ba8417dbdd307f51a99f10fcd02b9fd1785cf8f3db082643b48c2778cb1e52268e723136ba05b626ac65c7a793911b773925c80.tar.gz"
LICENSE="ISC"
SLOT="0"
KEYWORDS="*"
IUSE="libressl"

DEPEND="
	libressl? ( dev-libs/libressl:0= )
	!libressl? ( dev-libs/openssl:0= )
	sys-libs/zlib:=
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/rust"

DOCS="docs/README.md"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/starship-starship-* ${S} || die
}

src_install() {
	dobin target/release/${PN}
	default
}

pkg_postinst() {
	echo
	elog "Thanks for installing starship."
	elog "For better experience, it's suggested to install some Powerline font."
	elog "You can get some from https://github.com/powerline/fonts"
	echo
}