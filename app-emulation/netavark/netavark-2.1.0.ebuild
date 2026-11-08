# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
QA_FLAGS_IGNORED="usr/libexec/podman/netavark"
QA_PRESTRIPPED="usr/libexec/podman/netavark"
inherit cargo

DESCRIPTION="A container network stack"
HOMEPAGE="https://github.com/containers/netavark"
SRC_URI="
https://api.github.com/repos/containers/netavark/tarball/v2.1.0 -> netavark-2.1.0-8e91ad1.tar.gz
mirror://macaroni/netavark-2.1.0-mark-rust-bundle-8e91ad1.tar.xz -> netavark-2.1.0-mark-rust-bundle-8e91ad1.tar.xz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
BDEPEND="dev-libs/protobuf
	virtual/rust
	
"
RDEPEND=">=app-emulation/aardvark-dns-2.0.0
	net-firewall/nftables[json]
	
"
DEPEND="${RDEPEND}
"
src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/containers-netavark-* ${S} || die
}
src_install() {
	local target_dir="${CARGO_TARGET_DIR:-target}/$(usex debug debug release)"
	exeinto /usr/libexec/podman
	newexe "${target_dir}/netavark" netavark
}


# vim: filetype=ebuild
