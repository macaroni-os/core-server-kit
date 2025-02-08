# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Just a command runner"
HOMEPAGE="https://github.com/casey/just"
SRC_URI="https://github.com/casey/just/tarball/e303f2b8f2b120ab39013b654b6ae6422d9af6d2 -> just-1.39.0-e303f2b.tar.gz
https://distfiles.macaronios.org/09/9e/2f/099e2f64a148a963f6ae337ad926284b1d7205fea9515ccbb623be642901f75647c1a807d68423b803a7e5d40e5a69d97ce680993f3b43a9c14716b1fa00cb5e -> just-1.39.0-funtoo-crates-bundle-6d051d09df36662631d0f4b49811799f015a50168141d57f3b0b05babce9f154cf68b06b377401ac2e4032c8754abbfdec3b4a975676c205d15781f43275693c.tar.gz"

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