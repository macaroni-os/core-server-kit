# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Just a command runner"
HOMEPAGE="https://github.com/casey/just"
SRC_URI="https://github.com/casey/just/tarball/aa7780e183401361c25fd48cc111769dca1812bb -> just-1.40.0-aa7780e.tar.gz
https://distfiles.macaronios.org/30/93/e5/3093e5e0fe7ef7fea578a37db7b339617163b0b1d2df08123e1aa37b068207b4f01e676fe959b1ba299e4de7ffe92590b1f6bd78030ec859654fe95361e719e4 -> just-1.40.0-funtoo-crates-bundle-c58962ec64efba8d5ad1110aba86ac9e70d59d2065b9e1fef7ae0b488ae6b0cd410c697b73b8ca410336881ea0ecf7994429c09d1ae887df0b17b989f9ae41b4.tar.gz"

LICENSE="Apache-2.0 Boost-1.0 BSD BSD-2 CC0-1.0 ISC LGPL-3+ MIT Apache-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="*"

DEPEND=""
RDEPEND=""
BDEPEND="virtual/rust"

QA_FLAGS_IGNORED="/usr/bin/just"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/casey-just-* ${S} || die
}

src_install() {
	cargo_src_install

	mkdir ${S}/man
	${S}/target/release/just --man > ${S}/man/just.1
	doman man/just.1

	dodoc README.md
	einstalldocs
}