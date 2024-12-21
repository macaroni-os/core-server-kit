# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A lightweight WebAssembly runtime that is fast, secure, and standards-compliant"
HOMEPAGE="https://github.com/bytecodealliance/wasmtime https://docs.wasmtime.dev"
SRC_URI="https://github.com/bytecodealliance/wasmtime/releases/download/v28.0.0/wasmtime-v28.0.0-src.tar.gz -> wasmtime-v28.0.0-src.tar.gz
https://distfiles.macaronios.org/06/e9/89/06e9893c733cc40c0634ff73d1216e4855d272596cc20ecb3c0d4196bec6b0dcbd734e3e13383e7495870d2632e58614eaca908af8cd5a12d9384ece3a994ee2 -> wasmtime-28.0.0-funtoo-crates-bundle-dcf6025727128f1ee5cd519c3f054e8ab35e01f39a64163395cb08fcf50365366125150180ff13df76a7d5664478b09df0439ffa8f9b5e8782a5f7c2b5abe47d.tar.gz"

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