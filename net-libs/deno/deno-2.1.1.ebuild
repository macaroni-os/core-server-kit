# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript."
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/5d71b461530f7c374c08701cef5678a5a4ac5484 -> deno-2.1.1-5d71b46.tar.gz
https://distfiles.macaronios.org/c2/83/48/c2834893211ce2de616686a853e22d7daffc750ce9383926b1cd92fbddde311170ace880197d63b11fd56d43318787ef9198e17d54e4fe84303b52a04d3eb954 -> deno-2.1.1-funtoo-crates-bundle-edec6e52fcb18488b8a97331b2193de0dcba5b381ffec9c2e3a659526486b6f2c99975c11d668e564b2cd08906a660db6e827f9eb16202444bca6bfaac647192.tar.gz"

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