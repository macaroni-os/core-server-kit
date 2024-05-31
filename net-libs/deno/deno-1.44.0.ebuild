# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript."
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/f3ffffc682604349b96dbe4ad33daa5dd1a09f63 -> deno-1.44.0-f3ffffc.tar.gz
https://direct.funtoo.org/72/61/15/726115a5d4d7d3fd808a4c32e6b70fc2f1166542399745c1a80c9822bac936ec72518b8734b905221e8d14956d9ffaf59f0e7dce91c53864443202eadcd7fc3d -> deno-1.44.0-funtoo-crates-bundle-b713e36adf271ef459692afb694fe63550df7c554b4255339778c8b1b522335683afaa0f72cacb8e5489c733931b22ae6a6449556f48f69c321e6e50a1e5a954.tar.gz"

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