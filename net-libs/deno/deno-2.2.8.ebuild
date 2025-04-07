# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Deno is a simple, modern and secure runtime for JavaScript and TypeScript"
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/32b9cc91d8c343bdec2ddcf3cedb27b5efc2f5e4 -> deno-2.2.8-32b9cc9.tar.gz
https://distfiles.macaronios.org/30/72/82/30728250842e55efd32d8523c3522c23f6169cf0a3f9997df951acd91ef42e40052f6b9a4a62e8d426b7061785799dc59b36b2e54b011f3d02986f5fded72e4e -> deno-2.2.8-funtoo-crates-bundle-315afcf6c9287d18882e91fc6f684f420857d8483412bbb7381c006facf22d569ee9c0a0ea8209ee8868b239d613d395ab1cdd02b3717fd5394d44091f8719ff.tar.gz"
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

S="${WORKDIR}/denoland-deno-32b9cc9"

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