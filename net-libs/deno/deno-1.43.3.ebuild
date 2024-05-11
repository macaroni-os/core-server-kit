# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript."
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/d6ad253882a6c066e0c673ff64e6554a37bb3487 -> deno-1.43.3-d6ad253.tar.gz
https://direct.funtoo.org/11/00/03/110003d1c79a32266e17e4d5b97f4c7be99b3c451125170ee302fab9820a80831f69b65a5955d3b6e9bf7e0fed2fb1cbef51dfb142081ae9cd35b42f415bc6f0 -> deno-1.43.3-funtoo-crates-bundle-8655d2ecce8769f3d39a1201b9e3721d84b08028e7512e1be11b3c45d1cbf79bc0749d4bd14ada2849c511442f10915994a0d7d96a00bac6c52986a34053d3d3.tar.gz"

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