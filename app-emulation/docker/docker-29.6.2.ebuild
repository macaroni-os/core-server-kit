# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit go-module systemd udev user

DESCRIPTION="The Moby Project - a collaborative project for the container ecosystem to assemble container-based systems"
HOMEPAGE="https://mobyproject.org/"
SRC_URI="https://api.github.com/repos/moby/moby/tarball/docker-v29.6.2 -> docker-29.6.2-3d80467.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="apparmor btrfs +container-init
+overlay2 seccomp systemd
"
# Commons depends
CDEPEND="dev-db/sqlite:3
	apparmor? ( sys-libs/libapparmor )
	btrfs? ( sys-fs/btrfs-progs )
	seccomp? ( sys-libs/libseccomp )
	net-firewall/nftables:=
	
"
BDEPEND="dev-go/go-md2man
	virtual/pkgconfig
	
"
RDEPEND="${CDEPEND}
	sys-process/procps
	dev-vcs/git
	app-arch/xz-utils
	app-emulation/containerd[apparmor?,btrfs?,seccomp?]
	app-emulation/runc[apparmor?,seccomp?]
	container-init? ( sys-process/tini[static] )
	
"
DEPEND="${CDEPEND}
"

post_src_unpack() {
	mv moby-moby-* ${S}
}


pkg_setup() {
	enewgroup docker 48
}
src_compile() {
	export DOCKER_GITCOMMIT="3d80467"
	export GOPATH="${WORKDIR}/${P}"
	export VERSION="29.6.2-macaroni"
	export EXCLUDE_AUTO_BUILDTAG_JOURNALD=$(usex systemd '' 'y')
	 # setup CFLAGS and LDFLAGS for separate build target
	# see https://github.com/tianon/docker-overlay/pull/10
	export CGO_CFLAGS="-I${ESYSROOT}/usr/include"
	export CGO_LDFLAGS="-L${ESYSROOT}/usr/$(get_libdir)"
	 # let's set up some optional features :)
	export DOCKER_BUILDTAGS=''
	for gd in btrfs overlay2; do
	  if ! use $gd; then
	    DOCKER_BUILDTAGS+=" exclude_graphdriver_${gd//-/}"
	  fi
	done
	 for tag in apparmor seccomp; do
	  if use $tag; then
	    DOCKER_BUILDTAGS+=" $tag"
	  fi
	done
	 export GOFLAGS="-v -x -mod=vendor"
	# build binaries
	./hack/make.sh dynbinary || die 'dynbinary failed'
	# build man page
	cd man || die
	emake || die
}
src_install() {
	dosym containerd /usr/bin/docker-containerd
	dosym containerd-shim-runc-v2 /usr/bin/docker-containerd-shim
	dosym runc /usr/bin/docker-runc
	use container-init && dosym tini /usr/bin/docker-init
	dobin bundles/dynbinary-daemon/dockerd
	dobin bundles/dynbinary-daemon/docker-proxy
	for f in dockerd-rootless-setuptool.sh dockerd-rootless.sh; do
	  dosym ../share/docker/contrib/${f} /usr/bin/${f}
	done
	newconfd "${FILESDIR}"/docker.confd docker
	if use systemd ; then
	  systemd_dounit contrib/init/systemd/docker.{service,socket}
	else
	  newinitd "${FILESDIR}"/docker.initd docker
	fi
	 dodoc AUTHORS CONTRIBUTING.md NOTICE README.md
	dodoc -r docs/*
	doman man/man8/dockerd.8
	 # note: intentionally not using "doins" so that we preserve +x bits
	dodir /usr/share/${PN}/contrib
	cp -R contrib/* "${ED}/usr/share/${PN}/contrib"
}
pkg_postinst() {
	udev_reload
	elog
	elog "To use Docker, the Docker daemon must be running as root. To automatically"
	elog "start the Docker daemon at boot:"
	if systemd_is_booted || has_version sys-apps/systemd; then
	  elog "  systemctl enable docker.service"
	else
	  elog "  rc-update add docker default"
	fi
	elog
	elog "To use Docker as a non-root user, add yourself to the 'docker' group:"
	elog '  usermod -aG docker <youruser>'
	elog
	if has_version sys-fs/zfs; then
	  elog " ZFS storage driver is available"
	  elog " Check https://docs.docker.com/storage/storagedriver/zfs-driver for more info"
	  elog
	fi
	elog
	elog "For rootless mode support you need sys-apps/shadow, sys-apps/rootlesskit"
	elog "and a network stack for like app-emulation/slirp4netns"
}
pkg_postrm() {
	udev_reload
}



# vim: filetype=ebuild
