# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript."
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/e02a32be2797f7c107d19da8bf2aff5bbcd97bad -> deno-1.44.1-e02a32b.tar.gz
https://direct.funtoo.org/af/17/9d/af179d2386e22450376a588fd8af16134c6e8295b41ea4303991843654905e6709d210e821d3e84ff14ab8e0bddb004cdbd318b58152cd0d42509f0abc34bdff -> deno-1.44.1-funtoo-crates-bundle-4fa9e0c2fb44566442c5bfeacadbcb8605714a790a57b963ac6d7681e33978670540c9b82022034d6dbd572e2707e8244089e96ed99e014156f9bef2388b0ee4.tar.gz"

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