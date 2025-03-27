# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Deno is a simple, modern and secure runtime for JavaScript and TypeScript"
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/6e08a9d2291cf45ae4031e163b8c1a03a0e85983 -> deno-2.2.5-6e08a9d.tar.gz
https://distfiles.macaronios.org/50/7b/c1/507bc1ac379153c841462ca82cca449cfab5619884a4f02a733b4fd77dc58ed93d7248cd2b7b529db8fcbf76106f504ab24224c1c808ca0b735a8deeb4301a16 -> deno-2.2.5-funtoo-crates-bundle-dc1bedf392f557a29d31bf5a3844802db9dd356c10857e4e2410a7aa81d03c99e8b54fde57fa0afab83de5ee65bcdb2558f34113bb6955314c17307602e54679.tar.gz"
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

S="${WORKDIR}/denoland-deno-6e08a9d"

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