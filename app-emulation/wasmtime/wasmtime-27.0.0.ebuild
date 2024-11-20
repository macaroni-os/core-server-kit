# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A fast and secure runtime for WebAssembly"
HOMEPAGE="https://github.com/bytecodealliance/wasmtime https://docs.wasmtime.dev"
SRC_URI="https://github.com/bytecodealliance/wasmtime/releases/download/v27.0.0/wasmtime-v27.0.0-src.tar.gz -> wasmtime-v27.0.0-src.tar.gz
https://distfiles.macaronios.org/fc/d4/96/fcd496af5134a7d78e928e7b7e03b77e1f0ff74ee181f29e43dc033581a9c491a110870103dc8fc84071253df4da9722b80dfe8ba6136842c92aaf158e712012 -> wasmtime-27.0.0-funtoo-crates-bundle-aa728a44a3a071809bbc739d46ad0d8dc0c61914424ede8f83635e78ca90ebd3d45afa3c10e3485199461a3eeecc8fdc028cee9f8c6da10999720fdf4652753b.tar.gz"

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