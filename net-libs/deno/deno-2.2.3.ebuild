# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Deno is a simple, modern and secure runtime for JavaScript and TypeScript"
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/8203278401f4ffcb477a28b3ae9b915d88de7dd7 -> deno-2.2.3-8203278.tar.gz
https://distfiles.macaronios.org/21/ee/18/21ee189b9f74755b143927599fa3f86d5c567e341363ab7ec6ba9d825f793b2dc225054d0322390fc51345b2a3cb7827d4f01fbd7393913c931ae4da05e430d2 -> deno-2.2.3-funtoo-crates-bundle-6289a84f97bbb746aa231d14567b1df58856a55637d58594b33c313777b50ed80a18a378a5b39d4d754b89b167b57fee8190065f36b54d35c282db4ee42fd173.tar.gz"
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

S="${WORKDIR}/denoland-deno-8203278"

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