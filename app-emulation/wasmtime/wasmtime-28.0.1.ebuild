# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A lightweight WebAssembly runtime that is fast, secure, and standards-compliant"
HOMEPAGE="https://github.com/bytecodealliance/wasmtime https://docs.wasmtime.dev"
SRC_URI="https://github.com/bytecodealliance/wasmtime/releases/download/v28.0.1/wasmtime-v28.0.1-src.tar.gz -> wasmtime-v28.0.1-src.tar.gz
https://distfiles.macaronios.org/92/b4/1e/92b41ea19dbc5cf974e0b0e05aa76fc38350820e5eb67a9dbbe7514c147554f4d8a27682209dc6a7acc174ec69e02db3419d5e9ab6076114c3e4d51b26e49295 -> wasmtime-28.0.1-funtoo-crates-bundle-dcf6025727128f1ee5cd519c3f054e8ab35e01f39a64163395cb08fcf50365366125150180ff13df76a7d5664478b09df0439ffa8f9b5e8782a5f7c2b5abe47d.tar.gz"

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