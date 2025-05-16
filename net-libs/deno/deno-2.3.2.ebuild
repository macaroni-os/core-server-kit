# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Deno is a simple, modern and secure runtime for JavaScript and TypeScript"
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/7b74f385396bded16f99db64b97aa48e6f603f16 -> deno-2.3.2-7b74f38.tar.gz
https://distfiles.macaronios.org/34/6a/c7/346ac780bc2ad889a0a2fbb317d6cb1262e1302e23234a7024114ee251a59a672df465a93c67d7b54b7c9abcae8c2dd5a898b189f7375006ed88f3cb2aa5c9ff -> deno-2.3.2-funtoo-crates-bundle-7334d7403b068acf21f9a0d00449ec06d6dea79701ca3f2b457638f4abd4c02eff0404f826426b2aa7776389c6625108a6489d33730d7aea3633ecc2e7ffbd25.tar.gz"
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

S="${WORKDIR}/denoland-deno-7b74f38"

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