# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript."
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/08f0613b390b289d07c6ea165bed0518809b34e8 -> deno-1.42.1-08f0613.tar.gz
https://direct.funtoo.org/3e/02/a7/3e02a7d077fb378061df907bfe974e4f06d00862f602baaadc84e257d6cedd7ac93acf4d47504a83b45b617d670a3a5b17c6858224f718c99ef1447e3d21496f -> deno-1.42.1-funtoo-crates-bundle-78c4ad5835925aa05a5fffcd02035e69403711f7d24009a7d2ded2180a839d5f15ce753543107e1a3379062a7d9b41df7d5efc7da928c4560d68a6f5595ca32c.tar.gz"

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

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/denoland-deno-* ${S} || die
}

src_compile() {
	# Don't try to fetch prebuilt V8, build it instead
	export V8_FROM_SOURCE=1

	# Resolves to /usr/lib64/llvm/<version>
	export CLANG_BASE_PATH="$(readlink -f -- "$(dirname -- $(clang --print-prog-name=clang))/..")"

	cargo_src_compile
}

src_install() {
	# Install the binary directly, cargo install doesn't work on workspaces
	dobin target/release/deno

	dodoc -r docs
}