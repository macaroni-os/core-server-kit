# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit go-module systemd

DESCRIPTION="A tool for managing OCI containers and pods with Docker-compatible CLI"
HOMEPAGE="https://podman.io/"
SRC_URI="https://api.github.com/repos/podman-container-tools/podman/tarball/v6.2.0 -> podman-6.2.0-055de04.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="apparmor btrfs cron systemd"
# Commons depends
CDEPEND="app-crypt/gpgme:=
	apparmor? ( sys-libs/libapparmor )
	btrfs? ( sys-fs/btrfs-progs )
	dev-db/sqlite:3
	dev-libs/libassuan:=
	dev-libs/libgpg-error:=
	sys-apps/shadow:=
	sys-libs/libseccomp
	
"
BDEPEND="virtual/pkgconfig
"
RDEPEND="${CDEPEND}
	app-emulation/aardvark-dns
	app-emulation/catatonit
	app-emulation/conmon
	app-emulation/containers-shortnames
	app-emulation/crun
	app-emulation/fuse-overlayfs
	app-emulation/netavark
	app-emulation/passt
	cron? ( virtual/cron )
	systemd? ( sys-apps/systemd )
	
"
DEPEND="${CDEPEND}
"

post_src_unpack() {
	mv podman-container-tools-podman-* ${S}
}


src_prepare() {
	go-module_src_prepare
	 local file
	for file in apparmor_tag btrfs_installed_tag sqlite_tag systemd_tag; do
	  [[ -f hack/${file}.sh ]] || die "Missing hack/${file}.sh"
	done
	 cat > hack/apparmor_tag.sh <<-EOF || die
	#!/usr/bin/env bash
	$(usex apparmor "echo apparmor" echo)
	EOF
	 cat > hack/btrfs_installed_tag.sh <<-EOF || die
	#!/usr/bin/env bash
	$(usex btrfs echo 'echo exclude_graphdriver_btrfs')
	EOF
	 cat > hack/sqlite_tag.sh <<-EOF || die
	#!/usr/bin/env bash
	echo libsqlite3
	EOF
	 cat > hack/systemd_tag.sh <<-EOF || die
	#!/usr/bin/env bash
	$(usex systemd "echo systemd" echo)
	EOF
}
src_compile() {
	export PREFIX="/usr" ETCDIR="/etc" BUILD_ORIGIN="Macaroni"
	# Prevent git operations that are not possible from the release tarball.
	export COMMIT_NO="" GIT_COMMIT="" EPOCH_TEST_COMMIT=""
	export GOFLAGS="-v -x -mod=vendor"
	emake BUILDFLAGS="-v -work -x" EXTRA_BUILDTAGS="$(usev systemd)" SELINUXOPT= all
}
src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" ETCDIR="/etc" SELINUXOPT= \
	  install.bin install.remote install.man install.completions
	 newconfd "${FILESDIR}"/podman.confd podman
	if use systemd ; then
	  systemd_dounit "${FILESDIR}"/podman.service "${FILESDIR}"/podman.socket
	else
	  newinitd "${FILESDIR}"/podman.initd podman
	  newconfd "${FILESDIR}"/podman-restart.confd podman-restart
	  newinitd "${FILESDIR}"/podman-restart.initd podman-restart
	  newconfd "${FILESDIR}"/podman-clean-transient.confd podman-clean-transient
	  newinitd "${FILESDIR}"/podman-clean-transient.initd podman-clean-transient
	fi
	 if use cron ; then
	  exeinto /etc/cron.daily
	  newexe "${FILESDIR}"/podman-auto-update.cron podman-auto-update
	fi
	 insinto /etc/logrotate.d
	newins "${FILESDIR}"/podman.logrotate podman
	 # /etc/containers configuration shared with the helper binaries.
	# The OCI runtime defaults to runc, the runtime shipped by the kit.
	insinto /usr/share/containers
	doins "${FILESDIR}"/registries.conf "${FILESDIR}"/policy.json
	newins vendor/go.podman.io/common/pkg/config/containers.conf containers.conf
	newins vendor/go.podman.io/storage/storage.conf storage.conf
	newins vendor/go.podman.io/common/pkg/seccomp/seccomp.json seccomp.json
	newins vendor/go.podman.io/common/pkg/subscriptions/mounts.conf mounts.conf
	 keepdir /etc/containers/certs.d
	keepdir /etc/containers/oci/hooks.d
	keepdir /etc/containers/networks
	keepdir /etc/containers/systemd
	keepdir /etc/containers/registries.conf.d
	keepdir /etc/containers/registries.d
	keepdir /var/lib/containers/sigstore
	keepdir /usr/share/containers/systemd
	 dodoc README.md
}
pkg_postinst() {
	elog "Podman uses crun as the default OCI runtime."
	elog "Edit /usr/share/containers/containers.conf to change it."
	elog
	elog "Rootless containers require subuid(5)/subgid(5) mappings for the user."
}



# vim: filetype=ebuild
