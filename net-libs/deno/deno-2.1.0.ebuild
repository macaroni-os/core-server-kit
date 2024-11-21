# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript."
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/3da4eca7c1ed97906654671669e0bb3b095bc637 -> deno-2.1.0-3da4eca.tar.gz
https://distfiles.macaronios.org/da/d1/2c/dad12cca4cb39baca74808190f854511bda6227f6824f86bfc0accf3afddc8c0d22bcad4c3f37314376bbd7a066c08896d14dd8975e2c624aaff640bc3cf8ac3 -> deno-2.1.0-funtoo-crates-bundle-d45789f363419908ed3a44171eb23c6530993fabebf9fe6af85ddf488571e962ed85d049faea70bafa3191bb57848a4ac4b99173aeebd97ef9c4f443a36e187d.tar.gz"

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