# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit go-module

DESCRIPTION="OCI-based implementation of Kubernetes Container Runtime Interface"
HOMEPAGE="https://cri-o.io/"
SRC_URI="https://api.github.com/repos/cri-o/cri-o/tarball/v1.37.3 -> cri-o-1.37.3-e2f2af6.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="btrfs selinux systemd"
BDEPEND="dev-lang/go
	virtual/pkgconfig
	
"
RDEPEND="app-emulation/runc
	net-firewall/conntrack-tools
	net-firewall/iptables
	net-misc/cni-plugins
	net-misc/socat
	sys-apps/iproute2
	sys-libs/libseccomp:=
	btrfs? ( sys-fs/btrfs-progs )
	selinux? ( sys-libs/libselinux:= )
	
"
DEPEND="${RDEPEND}
"

post_src_unpack() {
	mv cri-o-cri-o-* ${S}
}


post_src_prepare() {
	# deterministic build tags: never let the build host decide
	echo '#!/bin/sh' > hack/openpgp_tag.sh || die
	echo 'echo containers_image_openpgp' >> hack/openpgp_tag.sh || die
	echo '#!/bin/sh' > hack/apparmor_tag.sh || die
	echo 'true' >> hack/apparmor_tag.sh || die
	echo '#!/bin/sh' > hack/libsubid_tag.sh || die
	echo 'true' >> hack/libsubid_tag.sh || die
	use btrfs || {
	  echo -e "#!/bin/sh\necho exclude_graphdriver_btrfs" > \
	    hack/btrfs_installed_tag.sh || die
	  echo -e "#!/bin/sh\ntrue" > hack/btrfs_tag.sh || die
	}
	use selinux || {
	  echo -e "#!/bin/sh\ntrue" > hack/selinux_tag.sh || die
	}
}

src_compile() {
	mkdir -p bin || die
	export GOFLAGS="-v -x -mod=vendor"
	emake binaries
}

src_install() {
	export GOFLAGS="-v -x -mod=vendor"
	emake DESTDIR="${D}" PREFIX="${D}/usr" \
	  install.bin-nobuild install.config
	 keepdir /etc/crio
	mv "${D}/etc/crio/crio.conf"{,.example} || die
	 insinto /etc/logrotate.d
	newins "${FILESDIR}/cri-o.logrotated" crio
	 if use systemd ; then
	  emake DESTDIR="${D}" PREFIX="${D}/usr" install.systemd
	else
	  newinitd "${FILESDIR}/crio.initd" crio
	fi
	 # Suppress crio log error messages triggered if these don't exist
	keepdir /etc/containers/oci/hooks.d
	keepdir /usr/share/containers/oci/hooks.d
	 # Suppress the crio "Missing CNI default network" log message
	keepdir /etc/cni/net.d
	insinto /etc/cni/net.d
	doins contrib/cni/99-loopback.conflist
}



# vim: filetype=ebuild
