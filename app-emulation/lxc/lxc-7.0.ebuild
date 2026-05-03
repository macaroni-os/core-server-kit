# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit bash-completion-r1 meson systemd

DESCRIPTION="A userspace interface for the Linux kernel containment features"
HOMEPAGE="https://linuxcontainers.org/lxc"
SRC_URI="https://api.github.com/repos/lxc/lxc/tarball/v7.0.0 -> lxc-7.0-e4415af.tar.gz"
LICENSE="GPL-2 LGPL-2.1 LGPL-3"
SLOT="0"
KEYWORDS="*"
DOCS=(
	AUTHORS
	CONTRIBUTING.md
	MAINTAINERS
	README.md
	doc/FAQ.txt
)
IUSE="apparmor +caps examples io-uring man pam seccomp +ssl
systemd +tools +static tools-multicall lto
"
BDEPEND="virtual/pkgconfig
	dev-lang/python
	man? ( app-text/docbook2K )
	
"
RDEPEND="sys-libs/libcap
	apparmor? ( sys-libs/libapparmor )
	caps? (
	  static? (
	    sys-libs/libcap[static-libs]
	  )
	  !static? (
	    sys-libs/libcap
	  )
	)
	io-uring? ( sys-libs/liburing:= )
	pam? ( sys-libs/pam )
	seccomp? ( sys-libs/libseccomp )
	ssl? ( dev-libs/openssl:= )
	systemd? ( sys-apps/systemd:= )
	sys-apps/dbus
	
"
DEPEND="${RDEPEND}
	sys-kernel/linux-headers
	apparmor? ( sys-apps/apparmor )
	
"

post_src_unpack() {
	mv lxc-lxc-* ${S}
}


src_configure() {
	local emesonargs=(
	  --localstatedir "${EPREFIX}/var"
	  -Dcoverity-build=false
	  -Doss-fuzz=false
	  -Dcommands=true
	  -Dmemfd-rexec=true
	  -Dthread-safety=true
	  -Dselinux=false
	  $(meson_use apparmor)
	  $(meson_use caps capabilities)
	  $(meson_use examples)
	  $(meson_use io-uring io-uring-event-loop)
	  $(meson_use man)
	  $(meson_use pam pam-cgroup)
	  $(meson_use seccomp)
	  $(meson_use ssl openssl)
	  # NOTE: At the moment when b_lto is true
	  #       the linking phase of lxc-monitor fails
	  #       because the __hidden functions are not visible.
	  #       See https://github.com/lxc/lxc/issues/4427
	  $(meson_use lto b_lto)
	  $(meson_use tools)
	  $(meson_use tools-multicall)
	  -Ddata-path=/var/lib/lxc
	  -Ddoc-path=/usr/share/doc/${PF}
	  -Dlog-path=/var/log/lxc
	  -Drootfs-mount-path=/var/lib/lxc/rootfs
	  -Druntime-path=/run
	)
	if use systemd; then
	  emesonargs+=( -Dinit-script="systemd" )
	else
	  emesonargs+=( -Dinit-script="sysvinit" )
	fi
	if ! use static ; then
	  # b_sanitize option is a specific meson
	  # option to select the Code sanitizer to use.
	  # Change this option seems break linking of a lot of
	  # binaries.
	  # I avoid to change the value and just replace the
	  # check under meson.build file about lxc-init.static
	  # binary.
	  sed -e "s|'none'|'false'|g" src/lxc/cmd/meson.build -i
	fi
	use tools && emesonargs+=( -Dcapabilities=true )
	if use tools-multicall ; then
	  # Rename main binary to avoid conflicts with lxd
	  sed -i -e "s|'lxc'|'lxcmulti'|g" src/lxc/tools/meson.build
	fi
	meson_src_configure
}
src_install() {
	meson_src_install
	# The main bash-completion file will collide with lxd, need to relocate and update symlinks.
	mkdir -p "${ED}"/$(get_bashcompdir) || die "Failed to create bashcompdir."
	# Quiet portage issue
	mv "${ED}"/$(get_bashcompdir)/_lxc "${ED}"/$(get_bashcompdir)/lxc-start
	if use tools; then
	  bashcomp_alias lxc-start lxc-{attach,autostart,cgroup,checkpoint,config,console,copy,create,destroy,device,execute,freeze,info,ls,monitor,snapshot,stop,top,unfreeze,unshare,usernsexec,wait}
	else
	  if use tools-multicall ; then
	    bashcomp_alias lxc-start lxc-{attach,autostart,cgroup,checkpoint,config,console,copy,create,destroy,device,execute,freeze,info,ls,monitor,snapshot,stop,top,unfreeze,unshare,usernsexec,wait}
	  else
	    bashcomp_alias lxc-start lxc-usernsexec
	  fi
	fi
	keepdir /var/lib/cache/lxc /var/lib/lib/lxc
	find "${ED}" -name '*.la' -delete -o -name '*.a' -delete || die
	# Replace upstream sysvinit/systemd files.
	if use systemd; then
	  rm -r "${D}$(systemd_get_systemunitdir)" || die "Failed to remove systemd lib dir"
	else
	  rm "${ED}"/etc/init.d/lxc-{containers,net} || die "Failed to remove sysvinit scripts"
	fi
	if use systemd ; then
	  systemd_newunit "${FILESDIR}"/lxc-monitord.service lxc-monitord.service
	  systemd_newunit "${FILESDIR}"/lxc-net.service lxc-net.service
	  systemd_newunit "${FILESDIR}"/lxc.service lxc.service
	  systemd_newunit "${FILESDIR}"/lxc_at.service "lxc@.service"
	   if ! use apparmor ; then
	    sed -i '/lxc-apparmor-load/d' "${D}$(systemd_get_systemunitdir)/lxc.service" || die "Failed to remove apparmor references from lxc.service systemd unit."
	  fi
	else
	  newinitd "${FILESDIR}/${PN}.initd" ${PN}
	fi
}
pkg_postinst() {
	elog
	elog "Run 'lxc-checkconfig' to see optional kernel features."
	elog
}



# vim: filetype=ebuild
