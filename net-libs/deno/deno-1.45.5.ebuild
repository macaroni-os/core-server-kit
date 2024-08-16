# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript."
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/52fd273834c0675f651577e23785d76f67423ab1 -> deno-1.45.5-52fd273.tar.gz
https://distfiles.macaronios.org/35/9f/3d/359f3d78743cd54d5b598b8859c61919a4a44baf7cff3137be042a8fd537debec159d5952b5b486765e321016cef1a98ff4d37b03a702446f26954d8a2cfd6fd -> deno-1.45.5-funtoo-crates-bundle-e8f2f7711351b372e360a790e28e8b16d7c0ab48678c4dc21a9fc7b9adaaa91530f8f114f2850263639bd86e1ab1e5bbe82727a97634e866d838324e1ea0fe2b.tar.gz"

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