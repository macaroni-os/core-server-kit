# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript."
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/04c0a4cbf7c00811d3ace3184c1cb8597a0e88f1 -> deno-1.42.2-04c0a4c.tar.gz
https://direct.funtoo.org/a6/08/59/a60859d383a3ae993b0cf364064deea2c8a1082d95daf25cd54049d3e04b79c2352c064d475f75ed2e738b8525e6a17fbc719868347842b253ceda54965d4437 -> deno-1.42.2-funtoo-crates-bundle-d8d2cbc61908a17c4985530f587bc494fdf433784876ad393301e560299a85066fac8aa6766c484df9cdc4315733ddb883be70060253789e9751255111da7b28.tar.gz"

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