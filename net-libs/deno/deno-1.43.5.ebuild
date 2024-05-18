# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript."
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/a13c4531fd2c08617767cc8a0788b9e20ac27d45 -> deno-1.43.5-a13c453.tar.gz
https://direct.funtoo.org/d2/53/f3/d253f39dd6da074240dd2c85c64f76f1ba433933ca4bb00f39bf0704378443e24df52ced627a22a4d5d06e47beb150c3b9400e543727d3106f0efefb6a743eaf -> deno-1.43.5-funtoo-crates-bundle-982f368f3105b31818d478087037fdd4e707acd4fa8ada065e38d4e5c0b98f935d9cb5a832d0ae8241d9e90a33faf3a88a10eeb178655a50fd3e18771df3dae0.tar.gz"

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