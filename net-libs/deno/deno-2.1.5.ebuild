# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript."
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/d15a95e28b0ec015c2f2a88cca3882ba96d5da98 -> deno-2.1.5-d15a95e.tar.gz
https://distfiles.macaronios.org/6e/88/54/6e88546569c0a07184da58503e805cf3d2bea4f65f6a927adba4c09774783aea0c154fba174dd7ef173054124e71788a3e6fe290646c0233a71c9d774f98dd31 -> deno-2.1.5-funtoo-crates-bundle-8948899cd5f998437e87659ef8c4120230e8edfcebfaba4db282313406e5c129d4dacbea799e5e9b93f9f5562119d30618f90374d0284c535e1b9c3265de0e21.tar.gz"

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