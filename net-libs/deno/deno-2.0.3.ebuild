# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript."
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/997bd47fc27ad920f3388c94a95829ff45394c84 -> deno-2.0.3-997bd47.tar.gz
https://distfiles.macaronios.org/10/f5/2c/10f52c7fc3aea2cc582ef1cfc1896ce6faff6ae849d106fd2891d84af28314815a6701f0e35e233b887cdf293323b1a655af41fb150daecd15e5e28d429c3b65 -> deno-2.0.3-funtoo-crates-bundle-baca7a0b2c8ddc21f20f4a04c986322fd7af0044938a4f848c58a70db76e839bd879bcf2346735e20aef33ce65446c625f68e169049390e6b5d258d0402f17c9.tar.gz"

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