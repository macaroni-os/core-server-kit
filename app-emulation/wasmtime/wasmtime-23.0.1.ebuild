# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A fast and secure runtime for WebAssembly"
HOMEPAGE="https://github.com/bytecodealliance/wasmtime https://docs.wasmtime.dev"
SRC_URI="https://github.com/bytecodealliance/wasmtime/releases/download/v23.0.1/wasmtime-v23.0.1-src.tar.gz -> wasmtime-v23.0.1-src.tar.gz
https://distfiles.macaronios.org/fb/cd/40/fbcd40bdd5a9162465fee5034888477bfa055e616ccf65c98ae7abca7b57af89476f4ba9870090bf67c451c7be02e4b6a62776cfd8b118fbbb861e78051c01a3 -> wasmtime-23.0.1-funtoo-crates-bundle-c9406f4aa282fbc64a72ce22b0b2ff66c1f006ee4bd5956f95ecdb9cfe52a5678cd2323a2c3ce29e8b41cd6e87dde658d8e90870ac8ced940562dd6c80537f4e.tar.gz"

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