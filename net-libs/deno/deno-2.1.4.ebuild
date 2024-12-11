# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript."
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/b32ed7516cfdaaff76203ca530796d6a1235568d -> deno-2.1.4-b32ed75.tar.gz
https://distfiles.macaronios.org/b0/b9/47/b0b9470c35cf00bfcff0932598e4e3b1400d34a829fdefb38fe7e76c799408dad837fd1b5b8a87f38e5eaf8f8a74754f34a20ae1a70dd12fd1e1c24420c5bafc -> deno-2.1.4-funtoo-crates-bundle-28298c27a315794e549d6588ef76d384e80247971c1b086c1d00216386fd92d06c1203c8c1633ae90d3198f0df73e67eeb79dbcfb0314e096015da539ebc9a31.tar.gz"

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