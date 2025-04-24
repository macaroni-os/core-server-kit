# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Deno is a simple, modern and secure runtime for JavaScript and TypeScript"
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/225fbd59bf9a1d50603adb99fe2748edf70b9de2 -> deno-2.2.11-225fbd5.tar.gz
https://distfiles.macaronios.org/b4/c0/19/b4c01914ea35b3b90fca04df7b86f9990cba67a0e562990910c93bbae04dddaa6a00dd6ea74f84e068e9de2a5d31b98cfa8dd2fb96b664051024a6edf07d9b5d -> deno-2.2.11-funtoo-crates-bundle-ad94114495eda31c971122ca78d45b46315c648c6a434145bd3ceff43a92642c52bb9d3bd0571fcd84c54323140ee68ab980ce18c4885690382b665022117ff5.tar.gz"
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

RESTRICT="network-sandbox"

S="${WORKDIR}/denoland-deno-225fbd5"

src_unpack() {
	cargo_src_unpack
}

src_compile() {
	# Don't try to fetch prebuilt V8, build it instead
	export V8_FROM_SOURCE=1
    cargo_src_compile
}

src_install() {
	# Install the binary directly, cargo install doesn't work on workspaces
	dobin target/release/deno

	dodoc -r docs
}