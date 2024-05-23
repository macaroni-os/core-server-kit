# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript."
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/7df3d5aeec14f24e5fdec1e1e6f5739f1fbeebbe -> deno-1.43.6-7df3d5a.tar.gz
https://direct.funtoo.org/b9/27/b0/b927b079c8f7b92838f805ef9b1905598432d964dc0e17f024bb46101f3afcaeb4c045c61f6e34337d427044583f8d0bd95126caa3cbf2076c6c512a5c3eb16f -> deno-1.43.6-funtoo-crates-bundle-68c88221c2eec15f0e5aa44d5cb7ae96b6d2091b43f808bea6dd121b0af411c7e05b5343399d2264c04e1f222a7ea5afa5d6b0f457b1a361efc6c099a3efdf3f.tar.gz"

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