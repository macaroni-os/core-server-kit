# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
QA_FLAGS_IGNORED="usr/libexec/podman/aardvark-dns"
QA_PRESTRIPPED="usr/libexec/podman/aardvark-dns"
inherit cargo

DESCRIPTION="A container-focused DNS server"
HOMEPAGE="https://github.com/containers/aardvark-dns"
SRC_URI="
https://api.github.com/repos/containers/aardvark-dns/tarball/v2.1.0 -> aardvark-dns-2.1.0-cd74176.tar.gz
mirror://macaroni/aardvark-dns-2.1.0-mark-rust-bundle-cd74176.tar.xz -> aardvark-dns-2.1.0-mark-rust-bundle-cd74176.tar.xz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
BDEPEND="virtual/rust
	
"
src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/containers-aardvark-dns-* ${S} || die
}
src_install() {
	local target_dir="${CARGO_TARGET_DIR:-target}/$(usex debug debug release)"
	exeinto /usr/libexec/podman
	newexe "${target_dir}/aardvark-dns" aardvark-dns
}


# vim: filetype=ebuild
