# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Deno is a simple, modern and secure runtime for JavaScript and TypeScript"
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/8773b5f5b074e1e374a403d05943b6a7bbbdebad -> deno-2.3.1-8773b5f.tar.gz
https://distfiles.macaronios.org/68/b8/51/68b851170266cb2cbe455afd51d7433b4aaa9f08309d3aa28101d8b70cf430471a56013a3056ea396db921ba79325c6ccbf934acde9735a007adde79b9e9f6fb -> deno-2.3.1-funtoo-crates-bundle-8cc0ba2239f56dc33b030c204ccb451dd42d4dc0bdf223e053f15a49632b43940987e03087084d679d069941d0e1d6456b278e861a42fc583bf165ad804c346d.tar.gz"
LICENSE="MIT"

SLOT="0"
KEYWORDS="*"

BDEPEND="
	sys-devel/llvm:*
	sys-devel/clang:*
	sys-devel/lld:*
	dev-util/gn
	virtual/rust
"

RESTRICT="network-sandbox"

S="${WORKDIR}/denoland-deno-8773b5f"

src_unpack() {
	cargo_src_unpack
}

src_compile() {
	# Don't try to fetch prebuilt V8, build it instead
	export V8_FROM_SOURCE=1
    cargo_src_compile
}

src_install() {
	# Install the binary directly, cargo install doesn't work on workspaces
	dobin target/release/deno

	dodoc -r docs
}