# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript."
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/85de4280a1f9fae572a7331db6344cee123ddab7 -> deno-1.45.2-85de428.tar.gz
https://direct.funtoo.org/a3/6e/aa/a36eaa1cfa6d0188957cb7e573010389794ae121b4412ebc0ed1463edd904f4fb1d5a3f11f1b02a87db109df658624bfbdabc2945187d70c6e9d6d53a3dc2c74 -> deno-1.45.2-funtoo-crates-bundle-dd666b0bbf4707cfd46c216691dde84ac9461042368a616d598f96219ab431b1e7c728b41f2ca1ea92c962378aacab538386880a5d4bc8f8a6157e05955d6152.tar.gz"

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