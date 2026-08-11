# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
QA_PREBUILT="/usr/lib/lxd/libdqlite.so.0.0.1
/usr/bin/fuidshift
/usr/bin/lxc
/usr/bin/lxd-agent
/usr/bin/lxd-benchmark
/usr/bin/lxd-convert
/usr/bin/lxd-user
/usr/sbin/lxd"

inherit autotools go-module bash-completion-r1 user systemd

DESCRIPTION="Powerful system container and virtual machine manager from Canonical"
HOMEPAGE="https://github.com/canonical/lxd https://canonical.com/lxd"
SRC_URI="https://github.com/canonical/lxd/releases/download/lxd-6.9/lxd-6.9.tar.gz -> lxd-6.9.tar.gz"
LICENSE="AGPL-3 Apache-2.0 BSD BSD-2 LGPL-3 MIT MPL-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="apparmor ipv6 systemd"
# Commons depends
CDEPEND="app-arch/xz-utils
	app-arch/lz4
	app-emulation/lxc[apparmor?]
	dev-lang/tcl
	dev-libs/dqlite
	dev-libs/libuv
	dev-libs/lzo
	dev-util/xdelta
	net-dns/dnsmasq[dhcp,ipv6?]
	
"
BDEPEND="dev-lang/go
	sys-kernel/linux-headers
	
"
RDEPEND="${CDEPEND}
	net-firewall/ebtables
	net-firewall/iptables[ipv6?]
	net-firewall/nftables
	sys-apps/iproute2[ipv6?]
	sys-fs/fuse:*
	sys-fs/lxcfs
	sys-fs/squashfs-tools[lzma]
	virtual/acl
	
"
DEPEND="${CDEPEND}
"
VDIR="${S}"/vendor
pkg_setup() {
	ebegin "Ensuring lxd and lxd-admin groups exist"
	# The group lxd is used for user socket with restrict access to a specific
	# project.
	enewgroup lxd
	# The control socket will be owned by (and writeable by) this group.
	enewgroup lxd-admin
	eend $?
}
src_prepare() {
	export GOPATH="${S}/_dist"
	go-module_src_prepare
	sed -i \
	  -e "s:\./configure:./configure --prefix=/usr --libdir=${EPREFIX}/usr/lib/lxd:g" \
	  -e "s:make:make ${MAKEOPTS}:g" \
	  Makefile || die
	# Fix hardcoded ovmf file path
	sed -i \
	  -e "s:/usr/share/OVMF:/usr/share/edk2-ovmf:g" \
	  -e "s:OVMF_VARS.ms.fd:OVMF_VARS.secboot.fd:g" \
	  doc/environment.md \
	  lxd/instance/drivers/edk2/edk2.go || die "Failed to fix hardcoded ovmf paths."
	# Fix hardcoded virtfs-proxy-helper file path
	sed -i \
	  -e "s:/usr/lib/qemu/virtfs-proxy-helper:/usr/libexec/virtfs-proxy-helper:g" \
	  lxd/device/device_utils_disk.go || die "Failed to fix virtfs-proxy-helper path."
}
src_configure() {
	:;
}
src_compile() {
	export GOPATH="${S}/_dist"
	export GOFLAGS="-buildmode=pie -trimpath -mod=vendor"
	export CGO_LDFLAGS_ALLOW="(-Wl,-wrap,pthread_create)|(-Wl,-z,now)"
	 CGO_ENABLED=0 go build -v -x -tags lxd-metadata -o bin/ ./lxd/lxd-metadata/... || die "Failed to build lxd-metadata"
	CGO_ENABLED=0 go build $GOFLAGS -v -x -tags "netgo" -o bin/ ./lxd-convert/... || die "Failed to build lxd-convert"
	 for k in fuidshift lxc lxd-benchmark lxd-user; do
	  CGO_ENABLED=1 go build -v -x -tags "libsqlite3" -o bin/ ./${k}/... || die "Failed to build ${k}"
	done
	CGO_ENABLED=1 go build -v -x -tags "libsqlite3" -o bin/ ./lxd/... || die "Failed to build lxd"
	 CGO_ENABLED=0 CGO_LDFLAGS="$CGO_LDFLAGS -static" go build -v -x -tags "agent,netgo" -o bin/ ./lxd-agent/... || die "Failed to build lxd-agent"
}
src_install() {
	cd ${S}/
	local bindir="bin"
	dosbin ${bindir}/lxd
	for l in fuidshift lxd-agent lxd-benchmark lxd-convert lxc lxd-user lxd-metadata; do
	  dobin ${bindir}/${l}
	done
	# Generate and install shell completion files.
	mkdir -p "${D}"/usr/share/{bash-completion/completions/,fish/vendor_completions.d/,zsh/site-functions/} || die
	dodir /usr/share/bash-completion/completions/
	dodir /usr/share/fish/vendor_completions.d/
	dodir /usr/share/zfs/site-functions/
	"${D}"/usr/bin/lxc completion bash > "${D}"/usr/share/bash-completion/completions/lxc || die
	"${D}"/usr/bin/lxc completion fish > "${D}"/usr/share/fish/vendor_completions.d/lxc.fish || die
	"${D}"/usr/bin/lxc completion zsh > "${D}"/usr/share/zsh/site-functions/_lxc || die
	if use systemd ; then
	  systemd_dounit "${FILESDIR}"/lxd.service
	  systemd_dounit "${FILESDIR}"/lxd-containers.service
	  systemd_dounit "${FILESDIR}"/lxd.socket
	 else
	  newinitd "${FILESDIR}"/5.x/lxd.initd lxd || die
	fi
	newconfd "${FILESDIR}"/5.x/lxd.confd lxd || die
	local dodoc_opts=-r
	dodoc -r AUTHORS doc/**
}
pkg_postinst() {
	if [[ -z ${ROOT} && -n "$( rc-service lxd status| grep started )"  ]]; then
	  einfo "Restarting lxd service."
	  if nofatal rc-service lxd restart ; then
	    eerror
	    eerror "LXD service failed to start after update."
	    eerror "Please check if your configuration for ${REPLACING_VERSIONS}"
	    eerror "is still valid for the new version."
	    eerror
	  else
	    ewarn
	    ewarn "LXD service was automatically restarted."
	    ewarn "If you are unable to 'lxc exec <containername>',"
	    ewarn "then you may need to restart all containers. "
	    ewarn "This can be done with /etc/init.d/lxd stop; /etc/init.d/lxd start."
	    ewarn
	  fi
	fi
	elog
	elog "Please run 'lxc-checkconfig' to see all optional kernel features."
	elog
	elog "Though not strictly required, some features are enabled at run-time"
	elog "when the relevant helper programs are detected:"
	elog "- sys-fs/btrfs-progs"
	elog "- sys-fs/lvm2"
	elog "- sys-fs/zfs"
	elog "- sys-process/criu"
	elog
	elog "Be sure to add your local user to the lxd group."
}


# vim: filetype=ebuild
