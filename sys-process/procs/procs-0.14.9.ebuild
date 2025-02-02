# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern replacement for ps written in Rust"
HOMEPAGE="https://github.com/dalance/procs"
SRC_URI="https://github.com/dalance/procs/tarball/2a0ba5c900b90a510a7fd1f21f8efe4b827c4b22 -> procs-0.14.9-2a0ba5c.tar.gz
https://distfiles.macaronios.org/52/b7/57/52b7576ffa485ee447b55b88683792f592654f081cd60a01b85ea5cea3073519adfd64f4469989f72e56f2a2ca9543e1d5104426bcfb3431209efed6c6e51dbc -> procs-0.14.9-funtoo-crates-bundle-e11585914c4ac140700fb8c0feaf33a23a9206a265eb20db6fd6a24e5272dd1c605a5ccc1d370cb993d566ed2b3d4e0bb46ecc31dc40facf5e0a66aaefaba02f.tar.gz"

LICENSE="Apache-2.0 BSD BSD-2 CC0-1.0 MIT ZLIB"
SLOT="0"
KEYWORDS="*"

BDEPEND="virtual/rust"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/dalance-procs-* ${S} || die
}

src_install() {
	# Avoid calling doman from eclass. It fails.
	rm -rf ${S}/man
	cargo_src_install
	dodoc README.md
}