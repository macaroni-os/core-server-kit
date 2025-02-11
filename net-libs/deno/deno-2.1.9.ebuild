# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript."
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/46e2f9a47ee5293547efd089438db29690a05f85 -> deno-2.1.9-46e2f9a.tar.gz
https://distfiles.macaronios.org/64/9d/81/649d817fb5b9b262d7db9de9d576e445134871b79f260eec682c0bc2fb4a83cef6417527d8f63a535d177a6a8ecdd49409510f9e834523fc7e711555682662aa -> deno-2.1.9-funtoo-crates-bundle-37a44d81ffeddb4d991afc8b408144e7c969f6a468b77c746cac1f7ae0792de8f7b460f51ff7ec900f1417544f9a68a09a1e95263a64fb85200b0739235fd423.tar.gz"

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