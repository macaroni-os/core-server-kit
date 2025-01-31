# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript."
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/318646f7678111d24b139f4c589a4ef447c8cf1c -> deno-2.1.8-318646f.tar.gz
https://distfiles.macaronios.org/22/0d/f8/220df81f24492fe5586ed60367436ed722dd5d2722a104d1f749e6215699bb5c2acea169aa651f59a7e952cef7be5dcadc10ee045bfb1b74a56769ab6386a512 -> deno-2.1.8-funtoo-crates-bundle-7494e7e06713932b31828036a6838ce501b7e167e91bf8dfb8da97121baea2a3f975e82d8bdaed3baecfaa0ffbfce8727447807db5d7ba8f452c8ef075cfe312.tar.gz"

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