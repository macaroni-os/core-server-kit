# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A fast and secure runtime for WebAssembly"
HOMEPAGE="https://github.com/bytecodealliance/wasmtime https://docs.wasmtime.dev"
SRC_URI="https://github.com/bytecodealliance/wasmtime/releases/download/v26.0.1/wasmtime-v26.0.1-src.tar.gz -> wasmtime-v26.0.1-src.tar.gz
https://distfiles.macaronios.org/b0/7f/e1/b07fe1b549a27eb6a781375ec4e3c0d8ee41e419b820557cad55ad3e82a76e35ecb19989b6a6bb62a3d545870da27b9da8c26e4f73a39d3484cb6da57799d43e -> wasmtime-26.0.1-funtoo-crates-bundle-979ef3cf8162e487db9c6306a82cb4f9c4244f5dc57c8ca9af26a9eb96ea24b1690036cfc333d11c88a1eaa0939c4cf488688baa7bafdb729a321fa1703f9084.tar.gz"

LICENSE="Apache-2.0 Boost-1.0 BSD BSD-2 CC0-1.0 ISC LGPL-3+ MIT Apache-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="*"

DOCS=( ADOPTERS.md README.md RELEASES.md )

QA_FLAGS_IGNORED="/usr/bin/wasmtime"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/wasmtime-* ${S} || die
}

src_install() {
	cargo_src_install
	einstalldocs
}