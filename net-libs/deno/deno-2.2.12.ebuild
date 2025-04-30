# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Deno is a simple, modern and secure runtime for JavaScript and TypeScript"
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/81da8139af85a0cb7efa9050ae6b5461b3614077 -> deno-2.2.12-81da813.tar.gz
https://distfiles.macaronios.org/b9/8a/89/b98a89342cb39d031d7fa980a6ce6cde5577ec300e73e76ac6e84e0634c08d6c4bcfb5b0442f138ef438e6bc825b49c134d7ba93c0c5016b159f2d29804a46ab -> deno-2.2.12-funtoo-crates-bundle-241c2f2d9a0f9dff09eb1d572b2414d3f6ee57989917127f3b124ff6a4f90d242ecf5ccd86b030fc0eb029043fad8d540b52ff6454a6ac63c889bb353456cf89.tar.gz"
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

S="${WORKDIR}/denoland-deno-81da813"

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