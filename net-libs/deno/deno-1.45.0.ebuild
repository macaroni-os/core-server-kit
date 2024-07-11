# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript."
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/04ff5c731d55f2402e7b08e378eaf6e5a5a4d961 -> deno-1.45.0-04ff5c7.tar.gz
https://direct.funtoo.org/fe/47/27/fe4727f962406e0b4a46ece95a4692d0383cab576261827a8d439a995afeaed64470c1d4da11b8a982adcd2548ab9601889748b449e64e262a5fddfe55a25d34 -> deno-1.45.0-funtoo-crates-bundle-0887cdc0004c0e5969974ae8feaab396368911535c4ef56f502f1916010c72a5198c626a36af5502b8499b8d7f60c375b6113a539de208393ecaf1d578794de8.tar.gz"

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