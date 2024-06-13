# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript."
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/9ca1320746072001feab9f6a26e9c1518609bd7b -> deno-1.44.2-9ca1320.tar.gz
https://direct.funtoo.org/5c/f9/45/5cf94534b2119e7c7cd3b431bc8dbc4135a814b8450e2e19c67189bdb74fa7150fc1b9382bd83701bc517f5794d80a09e141db54370c62f303ddadfaedfd0e12 -> deno-1.44.2-funtoo-crates-bundle-571b0c5a8e901f7408e79a3dc75e7b218fbc8dd3dc0f0154a3acb6949da3c5a9cd759e686ad809b7117ef4a76ea8ea9ca57d5942dc3a5ace687a68d66ff18900.tar.gz"

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