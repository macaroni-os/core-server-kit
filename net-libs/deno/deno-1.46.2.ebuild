# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript."
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/1b62d42631013724432f1ba4a3b04f506450abba -> deno-1.46.2-1b62d42.tar.gz
https://distfiles.macaronios.org/33/4f/51/334f51d26cce99f275c785d403adad7f1ed73f4bb3f29db3038a4c1d9d58309a982f4a2f29e315205989e0aa804d4d343f744ad8e4812b487f8cf338b85e4d80 -> deno-1.46.2-funtoo-crates-bundle-9eb556977120c6ba2a4e1b55617f3a57eef4606812e377fcb392e463a75fbce4489d7c64756660e39c807fb7b810d36ebda53b78abc6909396b685a4a374c50b.tar.gz"

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