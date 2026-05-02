# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit cargo

DESCRIPTION="The minimal, blazing-fast, and infinitely customizable prompt for any shell!"
HOMEPAGE="https://starship.rs"
SRC_URI="
https://api.github.com/repos/starship/starship/tarball/v1.25.1 -> starship-1.25.1-8758daa.tar.gz
mirror://macaroni/starship-1.25.1-mark-rust-bundle-8758daa.tar.xz -> starship-1.25.1-mark-rust-bundle-8758daa.tar.xz"
LICENSE="ISC"
SLOT="0"
KEYWORDS="*"
DOCS=(
	docs/README.md
)
BDEPEND="virtual/rust
"
RDEPEND="dev-libs/openssl
	sys-libs/zlib
	
"
DEPEND="${RDEPEND}
"
src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/starship-starship-* ${S} || die
}
src_install() {
	dobin target/release/starship
	default
}
pkg_postinst() {
	echo
	elog "Thanks for installing starship."
	elog "For better experience, it's suggested to install some Powerline font."
	elog "You can get some from https://github.com/powerline/fonts"
	echo
}


# vim: filetype=ebuild
