# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript."
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/a62c7e036ab6851c0293f407ead635a7331445b7 -> deno-2.0.0-a62c7e0.tar.gz
https://distfiles.macaronios.org/c1/27/9d/c1279d5eade06eb46ec568e34df1f6fd45700370e85a11b1eb518c4101243f727779316d0272d6e6af937e4cd3accbd40ba44a77ac3fbcbc2f727c9fa9d9b153 -> deno-2.0.0-funtoo-crates-bundle-977610e25099f27b74161f3b0be73093fb7b005efe0c4286bb7cbd1cf0032bbcd46893516d73e48d5e2e6319ef28f5f342457b6aab5fd74856b87ad602c3970c.tar.gz"

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