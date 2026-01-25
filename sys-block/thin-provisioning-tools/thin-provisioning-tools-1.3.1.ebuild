# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
QA_FLAGS_IGNORED="usr/sbin/pdata_tools"
inherit cargo

DESCRIPTION=""
HOMEPAGE="https://github.com/jthornber/thin-provisioning-tools"
SRC_URI="
https://api.github.com/repos/jthornber/thin-provisioning-tools/tarball/refs/tags/v1.3.1 -> thin-provisioning-tools-1.3.1-8b663fb.tar.gz
mirror://macaroni/thin-provisioning-tools-1.3.1-mark-rust-bundle-8b663fb.tar.xz -> thin-provisioning-tools-1.3.1-mark-rust-bundle-8b663fb.tar.xz"
LICENSE="GPL-3.0"
SLOT="0"
KEYWORDS="*"
DOCS=(
	CHANGES
	COPYING
	README.md
	doc/TODO.md
	doc/thinp-version-2/notes.md
)
IUSE="debug io-uring"
BDEPEND="virtual/pkgconfig
	virtual/rust
	app-text/asciidoc
	sys-devel/clang
	sys-fs/lvm2
	
"
DEPEND="sys-fs/lvm2
	
"
src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/jthornber-thin-provisioning-tools-* ${S} || die
	# Patch rio library to ignore unused qualifications.
	# Needed for io-uring use flag.
	sed -i -e '/unused_qualifications/d' \
	  ${WORKDIR}/mark-rust-bundle-${PN}/*rio-*/src/lib.rs
	# Fix compilation with rust <1.87 (see https://github.com/sipemu/anofox-statistics-rs/issues/4)
	sed -i -e 's|io_block_size.is_multiple_of(BLOCK_SIZE)|io_block_size % BLOCK_SIZE == 0|g' \
	  ${S}/src/io_engine/sync.rs || die
}
src_configure() {
	local llvm_slot=$(clang --version | grep version | awk '{ print $4 }' | cut -d'.' -f 1)
	export BINDGEN_EXTRA_CLANG_ARGS="${BINDGEN_EXTRA_CLANG_ARGS} -I/usr/lib/clang/${llvm_slot}/include"
	local myfeatures=( $(usex io-uring io_uring '') )
	cargo_src_configure
}
src_install() {
	cargo_target_dir="${CARGO_TARGET_DIR:-target}/$(usex debug debug release)"
	emake \
	  DESTDIR="${D}" \
	  DATADIR="${ED}/usr/share" \
	  PDATA_TOOLS="${cargo_target_dir}/pdata_tools" \
	  install
	einstalldocs
}


# vim: filetype=ebuild
