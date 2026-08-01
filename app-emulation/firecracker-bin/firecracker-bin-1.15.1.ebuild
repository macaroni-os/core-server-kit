# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
QA_PREBUILT="/usr/bin/firecracker
/usr/bin/jailer"

inherit user

DESCRIPTION="Secure and fast microVMs for serverless computing."
HOMEPAGE="http://firecracker-microvm.io"
SRC_URI="
amd64? ( https://github.com/firecracker-microvm/firecracker/releases/download/v1.15.1/firecracker-v1.15.1-x86_64.tgz -> firecracker-bin-1.15.1-f82c0bd-x86_64.tgz )
arm64? ( https://github.com/firecracker-microvm/firecracker/releases/download/v1.15.1/firecracker-v1.15.1-aarch64.tgz -> firecracker-bin-1.15.1-f82c0bd-aarch64.tgz )"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="amd64 arm64"
RESTRICT="strip"
S="${WORKDIR}"
pkg_setup() {
	enewgroup kvm
}
src_compile() { :; }
src_install() {
	if use amd64; then
	  my_arch=x86_64
	elif use arm64; then
	  my_arch=aarch64
	fi
	newbin "${WORKDIR}/release-v1.15.1-${my_arch}/firecracker-v${PV}-${my_arch}" firecracker
	newbin "${WORKDIR}/release-v1.15.1-${my_arch}/jailer-v${PV}-${my_arch}" jailer
}
pkg_postinst() {
	elog
	elog "In production, Firecracker is designed to be run securely,"
	elog "inside an execution jail, carefully set up by the jailer binary."
	elog "Jailer is already included in this package."
	elog
	elog "It is recommended to use Firecracker as a non-root user."
	elog "You will need to add yourself to the 'kvm' group:"
	elog "  usermod -aG kvm youruser"
	elog
	elog "Getting Started with Firecracker: https://github.com/firecracker-microvm/firecracker/blob/master/docs/getting-started.md"
	elog "Production Host Setup Recommendations: https://github.com/firecracker-microvm/firecracker/blob/master/docs/prod-host-setup.md"
	elog "README: https://github.com/firecracker-microvm/firecracker/blob/master/README.md"
	elog "The Firecracker Jailer: https://github.com/firecracker-microvm/firecracker/blob/master/docs/jailer.md"
}


# vim: filetype=ebuild
