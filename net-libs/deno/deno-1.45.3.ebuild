# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript."
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/87ce64e57486fc006e82806c9ed8c49f11c2cb73 -> deno-1.45.3-87ce64e.tar.gz
https://direct.funtoo.org/fb/a9/28/fba928b2ba54e8770c14a6f3f3ca7e182db2fef71ae4cdd812179a6ba626a28c15385f69c125cb7cd16eb2e973cff4525fceea015c8c09d79549d4eab1a89bf0 -> deno-1.45.3-funtoo-crates-bundle-c636dd4560f203174cdea184d68ec9c51425dfaf2897595cfc0ea3dc2cfa71b7a0a2684b6114bea89bf0704852bbea500a5113b179dbad4bdc6d9771c915e0a7.tar.gz"

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