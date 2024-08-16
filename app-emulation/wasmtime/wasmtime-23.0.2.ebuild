# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A fast and secure runtime for WebAssembly"
HOMEPAGE="https://github.com/bytecodealliance/wasmtime https://docs.wasmtime.dev"
SRC_URI="https://github.com/bytecodealliance/wasmtime/releases/download/v23.0.2/wasmtime-v23.0.2-src.tar.gz -> wasmtime-v23.0.2-src.tar.gz
https://distfiles.macaronios.org/be/c4/17/bec417daac33471715a728104fe33b3998270ffb3d13204ea0b78e8639afd0653917bedd04850563b9c63f22fcd47905fcbcc75a670e895b60b778244a62f699 -> wasmtime-23.0.2-funtoo-crates-bundle-c9406f4aa282fbc64a72ce22b0b2ff66c1f006ee4bd5956f95ecdb9cfe52a5678cd2323a2c3ce29e8b41cd6e87dde658d8e90870ac8ced940562dd6c80537f4e.tar.gz"

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