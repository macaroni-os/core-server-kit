# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript."
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/ab2ab0f7fc4e7bda16544ef96a5e6ba114e799b5 -> deno-1.44.3-ab2ab0f.tar.gz
https://direct.funtoo.org/72/57/1b/72571b8eb7d81c51a7ff0d84f6bfe4738387331a543177a0eee53784c48d1cfc63b0bc18b12f84b8e50e43e7f44ff44ff018f4d9003c12b87e50aa595c4db662 -> deno-1.44.3-funtoo-crates-bundle-b4910b772ce959702af65ae83838acb5cbb5271aa36d151f9354002f2e98aff8745d52997597830ee9f70e5daa78c12fb8ad0d546138c28714f994597401a95e.tar.gz"

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