# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A fast and secure runtime for WebAssembly"
HOMEPAGE="https://github.com/bytecodealliance/wasmtime https://docs.wasmtime.dev"
SRC_URI="https://github.com/bytecodealliance/wasmtime/releases/download/v25.0.1/wasmtime-v25.0.1-src.tar.gz -> wasmtime-v25.0.1-src.tar.gz
https://distfiles.macaronios.org/ea/63/82/ea63827e9d1c0e2bd980bd46361f1c7c34213b2b4efd9ac84a22a57da8f28b2eedaba51aa99211f57fb433c060e992cf781ead3f7f0df49a124cd742d5f2771e -> wasmtime-25.0.1-funtoo-crates-bundle-eed1ba41907e09ebf84c56d34e282b45d32a1f20af045f9573df9c05198a34e4f83b356bbf56e462130336a6c58078d03ea6081b21d5b703da83b711702cc72d.tar.gz"

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