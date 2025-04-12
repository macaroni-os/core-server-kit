# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Deno is a simple, modern and secure runtime for JavaScript and TypeScript"
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/25defa74d539d1d6fd27ddabd5260705677c43e8 -> deno-2.2.9-25defa7.tar.gz
https://distfiles.macaronios.org/2f/dd/0b/2fdd0bdb1156603fabb1df1cdd5bae1e43fc6b2a8cf056be3afb12149db2934d01b6248214b61d3f89ca9ef4c93401476025b4b6bf3e948313fc8b7d78ef500b -> deno-2.2.9-funtoo-crates-bundle-fa12c78208d1d8b476c3f9b751ce8b883bcc79007058912f62c9793be7d73040db9146b5fc1420e9826dfc241aafd32d2551eb65500bd5fc66afe3727893d4c3.tar.gz"
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

S="${WORKDIR}/denoland-deno-25defa7"

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