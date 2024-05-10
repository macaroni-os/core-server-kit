# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript."
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/acd75bbd75fdf46c213d7b21093e09349318da5d -> deno-1.43.2-acd75bb.tar.gz
https://direct.funtoo.org/a5/a5/d0/a5a5d0398562667efe843808e31cdf30ee8dbecd363845bc1c0f40551cc3d85ecd3f1a65e13b73442679c87dce4f7799ffecfbfffbaef3d8b6c86b56d1bfa5fd -> deno-1.43.2-funtoo-crates-bundle-cf62a97c36755307e990b9bbd0bc434e31e2f491d20d6a9de27debd8cb3473c6d5b6a334023b0e7fa1e9b0c856936d1a5563f195ef2323439af71a14537d2e43.tar.gz"

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