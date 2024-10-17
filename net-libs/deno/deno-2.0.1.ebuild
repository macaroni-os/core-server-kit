# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript."
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/99c2aa573057e337f3474d43a7aab8c5e6b4caa2 -> deno-2.0.1-99c2aa5.tar.gz
https://distfiles.macaronios.org/57/04/a1/5704a1ac01e8d9f8ec05a37b8dc83c99881678283cefca453f4e4e187648d560276f40c80ceb9ffbbbe84896a92862fa5fd4dd05eb9069cd8f5351fed7b4c4c8 -> deno-2.0.1-funtoo-crates-bundle-bb227dc96cf34309d7889a47a24594adb70faf8940d249dba5202c54038939de4dd3057b804ee7ee4a733772e87baa1771950bee1886431313c1d4987362a5b3.tar.gz"

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