# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Deno is a simple, modern and secure runtime for JavaScript and TypeScript"
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/adc34a6b3b8f6ff593810c0655d0d1a4b7ea3729 -> deno-2.2.10-adc34a6.tar.gz
https://distfiles.macaronios.org/c8/fb/14/c8fb1405421b15e878533c90d7499bd28e5ce7fd147a2826d7d33f78d27dd0cc94c768206ebc6780c5e9b45261fe647883df736c64c54121b5093b7d51dc23f4 -> deno-2.2.10-funtoo-crates-bundle-7595e21489528bc2a1da0c797397223eff384ac451f52d4ee612e4e69fd489e51153a601d58ff5b95dc7b91039e5df303b062dd32da74479e5195213aca1a5c8.tar.gz"
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

S="${WORKDIR}/denoland-deno-adc34a6"

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