# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit meson python-any-r1 systemd tmpfiles

DESCRIPTION=""
SRC_URI="https://dbus.freedesktop.org/releases/dbus/dbus-1.16.2.tar.xz -> dbus-1.16.2.tar.xz"
LICENSE="|| ( AFL-2.1 GPL-2+ ) Apache-2.0 BSD GPL-2+ LGPL-2.1+ MIT tcltk"
SLOT="0"
KEYWORDS="*"
PATCHES=(
	"${FILESDIR}/dbus-1.16.0-enable-elogind.patch"
)
IUSE="debug doc elogind static-libs systemd valgrind user-session X"
REQUIRED_USE="?? ( elogind systemd )"
# Commons depends
CDEPEND="dev-libs/expat
	elogind? ( sys-auth/elogind:= )
	systemd? ( sys-apps/systemd:= )
	X? (
	  x11-libs/libX11
	  x11-libs/libXt
	)
	
"
BDEPEND="${PYTHON_DEPS}
	app-text/xmlto
	app-text/docbook-xml-dtd:4.4
	sys-devel/autoconf-archive
	virtual/pkgconfig
	
"
RDEPEND="${CDEPEND}
	systemd? ( virtual/tmpfiles )
	
"
DEPEND="${CDEPEND}
	valgrind? ( dev-util/valgrind )
	X? ( x11-base/xorg-proto )
	
"
pkg_setup() {
	enewgroup messagebus
	enewuser messagebus -1 -1 -1 messagebus
	python-any-r1_pkg_setup
}
src_configure() {
	local rundir=/run
	local emesonargs=(
	  --localstatedir="/var"
	  -Druntime_dir="${rundir}"
	  -Ddefault_library=$(usex static-libs both shared)
	  -Dapparmor=disabled
	  -Dasserts=false
	  -Dchecks=false
	  $(meson_use debug stats)
	  $(meson_use debug verbose_mode)
	  -Ddbus_user=messagebus
	  -Dkqueue=disabled
	  $(meson_feature kernel_linux inotify)
	  $(meson_feature doc doxygen_docs)
	  $(meson_feature doc xml_docs) # Controls man pages
	   -Dinstalled_tests=false
	  -Dmessage_bus=true
	  -Dmodular_tests=disabled
	  -Dqt_help=disabled
	  -Dtools=true
	  $(meson_feature elogind)
	  $(meson_feature systemd)
	  $(meson_use user-session user_session)
	  $(meson_feature X x11_autolaunch)
	  $(meson_feature valgrind)
	   # libaudit is *only* used in DBus wrt SELinux support, so disable it if
	  # not on an SELinux profile.
	  -Dselinux=disabled
	  -Dlibaudit=disabled
	   -Dsession_socket_dir=/tmp
	  -Dsystem_pid_file="${rundir}"/dbus.pid
	  -Dsystem_socket="${rundir}"/dbus/system_bus_socket
	  -Dsystemd_system_unitdir="$(systemd_get_systemunitdir)"
	  -Dsystemd_user_unitdir="$(systemd_get_userunitdir)"
	)
	 meson_src_configure
}
src_install() {
	meson_src_install
	 newinitd "${FILESDIR}"/dbus.initd dbus
	exeinto /etc/user/init.d
	newexe "${FILESDIR}/dbus.user.initd" dbus
	 if use X; then
	  # dbus X session script (bug #77504)
	  # turns out to only work for GDM (and startx). has been merged into
	  # other desktop (kdm and such scripts)
	  exeinto /etc/X11/xinit/xinitrc.d
	  newexe "${FILESDIR}"/80-dbus 80-dbus
	fi
	 find "${ED}" -name '*.la' -delete || die
	 # Needs to exist for dbus sessions to launch
	keepdir /usr/share/dbus-1/services
	keepdir /etc/dbus-1/{session,system}.d
	# machine-id symlink from pkg_postinst()
	keepdir /var/lib/dbus
	# Let the init script create the /var/run/dbus directory
	rm -rf "${ED}"/{,var/}run
	 # bug #761763
	rm -rf "${ED}"/usr/lib/sysusers.d
	 dodoc AUTHORS NEWS README doc/TODO
	 mv "${ED}"/usr/share/doc/dbus/* "${ED}"/usr/share/doc/${PF}/ || die
	rm -rf "${ED}"/usr/share/doc/dbus || die
	}
	pkg_postinst() {
	  if use systemd; then
	    tmpfiles_process dbus.conf
	  fi
	   dbus-uuidgen --ensure="${EROOT}"/etc/machine-id
	  ln -sf "${EPREFIX}"/etc/machine-id "${EROOT}"/var/lib/dbus/machine-id
	}


# vim: filetype=ebuild
