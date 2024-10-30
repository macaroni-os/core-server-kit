# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript."
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/b7c282d2f80b12b0b2a435780fb0ea2b236ab224 -> deno-2.0.4-b7c282d.tar.gz
https://distfiles.macaronios.org/79/a5/0a/79a50a93d5740d41ae67196052c15fbc0458ed69dc7272c335142dbeb5dd738be50cb7f0a0e5bf9bce18b358d88363c0303263bf2d4c521ae9154331be3adf09 -> deno-2.0.4-funtoo-crates-bundle-def3506aa2280e97eb5437f3cfbf1b49f82fd1d3ced11a1cf4fe665d9133107587f0cf997f57b7f7338a4522e072428eeeadfcb199c4c5df595ddabeb35a810e.tar.gz"

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