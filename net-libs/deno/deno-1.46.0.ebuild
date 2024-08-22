# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript."
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/3314a0ceb8f874986d5da9f36f683740bd813750 -> deno-1.46.0-3314a0c.tar.gz
https://distfiles.macaronios.org/e5/79/ed/e579edb6c35323ac0518326a19bb9f26eaa410c85045df9a6d0f7f0c922374df2caa1e0f86056a6e7558cb9e5764f9d336f3019313ccb7ef44905fa2f46abae0 -> deno-1.46.0-funtoo-crates-bundle-ab5b9672c19ff90c34fd74bd67f3a9bacfa69101525adaca199d10f6bb4e8c09f53c352a1ffb22d5657701a0e06df2ca5264d6281075a1ea5edd3936fc548735.tar.gz"

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