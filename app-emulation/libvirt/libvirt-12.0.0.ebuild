# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit bash-completion-r1 meson python-any-r1 user

DESCRIPTION="C toolkit to manipulate virtual machines"
HOMEPAGE="https://www.libvirt.org/"
SRC_URI="https://download.libvirt.org/libvirt-12.0.0.tar.xz -> libvirt-12.0.0.tar.xz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="*"
IUSE="apparmor audit +caps +dbus dtrace firewalld fuse glusterfs iscsi
iscsi-direct +libvirtd lvm libssh lxc +macvtap nfs nls numa openvz
parted pcap policykit +qemu rbd sasl +udev +vepa
virtualbox virt-network wireshark-plugins xen zfs
"
REQUIRED_USE="firewalld? ( virt-network )
libvirtd? ( || ( lxc openvz qemu virtualbox xen ) )
lxc? ( caps libvirtd )
openvz? ( libvirtd )
policykit? ( dbus )
qemu? ( libvirtd )
vepa? ( macvtap )
virt-network? ( libvirtd )
virtualbox? ( libvirtd )
xen? ( libvirtd )
"
BDEPEND="virtual/pkgconfig
	
"
RDEPEND="app-misc/scrub
	dev-libs/glib
	dev-libs/libgcrypt:0
	dev-libs/libnl:3
	dev-libs/libxml2
	net-analyzer/openbsd-netcat
	net-libs/gnutls:0=
	net-libs/libssh2
	net-libs/libtirpc
	net-libs/rpcsvc-proto
	net-misc/curl
	sys-apps/dmidecode
	sys-apps/util-linux
	sys-devel/gettext
	sys-libs/ncurses:0=
	sys-libs/readline:=
	apparmor? ( sys-libs/libapparmor )
	audit? ( sys-process/audit )
	caps? ( sys-libs/libcap-ng )
	dbus? ( sys-apps/dbus )
	dtrace? ( dev-util/systemtap )
	firewalld? ( net-firewall/firewalld )
	fuse? ( sys-fs/fuse:0= )
	glusterfs? ( sys-cluster/glusterfs )
	iscsi? ( sys-block/open-iscsi )
	iscsi-direct? ( net-libs/libiscsi )
	libssh? ( net-libs/libssh )
	lvm? ( sys-fs/lvm2[-device-mapper-only(-)] )
	nfs? ( net-fs/nfs-utils )
	numa? (
	  sys-process/numactl
	  sys-process/numad
	)
	parted? (
	  sys-block/parted[device-mapper]
	  sys-fs/lvm2[-device-mapper-only(-)]
	)
	pcap? ( net-libs/libpcap )
	policykit? ( sys-auth/polkit )
	qemu? (
	  app-emulation/qemu
	  dev-libs/json-c
	)
	rbd? ( sys-cluster/ceph )
	sasl? ( dev-libs/cyrus-sasl )
	virt-network? (
	  net-dns/dnsmasq[script]
	  net-firewall/ebtables
	  net-firewall/iptables[ipv6]
	  net-misc/radvd
	  sys-apps/iproute2[-minimal]
	)
	virtualbox? (
	  || (
	    app-emulation/virtualbox
	    app-emulation/virtualbox-bin
	  )
	)
	wireshark-plugins? ( net-analyzer/wireshark:= )
	xen? (
	  app-emulation/xen
	  app-emulation/xen-tools:=
	)
	udev? (
	  virtual/udev
	  x11-libs/libpciaccess
	)
	zfs? ( sys-fs/zfs )
	
"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	app-text/xhtml1
	dev-lang/perl
	dev-libs/libxslt
	dev-perl/XML-XPath
	dev-python/docutils
	
"
pkg_setup() {
	if use qemu; then
	  enewgroup qemu 77
	  enewuser qemu 77 -1 -1 "qemu,kvm"
	fi
	use policykit && enewgroup libvirt
}
src_prepare() {
	touch "${S}/.mailmap"
	default
	# Tweak the init script:
	cp "${FILESDIR}/libvirtd.init-r19" "${S}/libvirtd.init" || die
	sed -e "s/USE_FLAG_FIREWALLD/$(usex firewalld 'need firewalld' '')/" \
	  -i "${S}/libvirtd.init" || die "sed failed"
	#Replacing recurrent patches with sed scripts
	mv src/security/apparmor/usr.lib.libvirt.virt-aa-helper.in \
	  src/security/apparmor/usr.libexec.virt-aa-helper.in
	for x in $(grep -rl usr.lib.libvirt.virt-aa-helper.in); do
	  sed -e "s/usr.lib.libvirt.virt-aa-helper.in/usr.libexec.virt-aa-helper.in/g" -i $x
	done
	sed -e "s#/sysconfig/libvirt-guests#/sysconfig/libvirt-guests.conf#g" \
	  -e "s#/lock/subsys/libvirt-guests#/lock/libvirt-guests#g" \
	  -i tools/libvirt-guests.sh.in
}
src_configure() {
	local emesonargs=(
	  $(meson_feature apparmor)
	  $(meson_feature apparmor apparmor_profiles)
	  $(meson_feature audit)
	  $(meson_feature caps capng)
	  $(meson_feature dtrace)
	  $(meson_feature firewalld)
	  $(meson_feature fuse)
	  $(meson_feature glusterfs)
	  $(meson_feature glusterfs storage_gluster)
	  $(meson_feature iscsi storage_iscsi)
	  $(meson_feature iscsi-direct storage_iscsi_direct)
	  $(meson_feature libvirtd driver_libvirtd)
	  $(meson_feature libssh)
	  $(meson_feature lvm storage_lvm)
	  $(meson_feature lvm storage_mpath)
	  $(meson_feature lxc driver_lxc)
	  $(meson_feature nls)
	  $(meson_feature numa numactl)
	  $(meson_feature numa numad)
	  $(meson_feature openvz driver_openvz)
	  $(meson_feature parted storage_disk)
	  $(meson_feature pcap libpcap)
	  $(meson_feature policykit polkit)
	  $(meson_feature qemu driver_qemu)
	  $(meson_feature qemu json_c)
	  $(meson_feature rbd storage_rbd)
	  $(meson_feature sasl)
	  $(meson_feature udev)
	  $(meson_feature virt-network driver_network)
	  $(meson_feature virtualbox driver_vbox)
	  $(meson_feature wireshark-plugins wireshark_dissector)
	  $(meson_feature xen driver_libxl)
	  $(meson_feature zfs storage_zfs)
	  -Dselinux=disabled
	  -Dnetcf=disabled
	  -Dsanlock=disabled
	  -Ddriver_esx=enabled
	  -Dqemu_group=$(usex caps qemu root)
	  -Dqemu_user=$(usex caps qemu root)
	  -Ddriver_remote=enabled
	  -Dstorage_fs=enabled
	  -Ddriver_vmware=enabled
	  --localstatedir=/var
	  -Drunstatedir=/run
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	# Remove bogus, empty directories. They are either not used, or
	# libvirtd is able to create them on demand
	rm -rf "${D}"/etc/sysconfig
	rm -rf "${D}"/var
	rm -rf "${D}"/run
	use libvirtd || return 0
	# From here, only libvirtd-related instructions, be warned!
	newinitd "${S}/libvirtd.init" libvirtd
	newinitd "${FILESDIR}/libvirt-guests.init-r4" libvirt-guests
	newinitd "${FILESDIR}/virtlockd.init-r2" virtlockd
	newinitd "${FILESDIR}/virtlogd.init-r2" virtlogd
	newconfd "${FILESDIR}/libvirtd.confd-r5" libvirtd
	newconfd "${FILESDIR}/libvirt-guests.confd" libvirt-guests
}
pkg_preinst() {
	# we only ever want to generate this once
	if [[ -e "${ROOT}"/etc/libvirt/qemu/networks/default.xml ]]; then
	  rm -rf "${D}"/etc/libvirt/qemu/networks/default.xml
	fi
}
pkg_postinst() {
	if [[ -e "${ROOT}"/etc/libvirt/qemu/networks/default.xml ]]; then
	  touch "${ROOT}"/etc/libvirt/qemu/networks/default.xml
	fi
	use libvirtd || return 0
}


# vim: filetype=ebuild
