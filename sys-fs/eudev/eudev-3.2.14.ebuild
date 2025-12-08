# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit autotools toolchain-funcs user

DESCRIPTION="Repository for eudev development"
HOMEPAGE="https://github.com/eudev-project/eudev"
SRC_URI="https://github.com/eudev-project/eudev/releases/download/v3.2.14/eudev-3.2.14.tar.gz -> eudev-3.2.14.tar.gz"
LICENSE="GPL-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="+hwdb +kmod introspection +rule-generator static-libs"
# Commons depends
CDEPEND="sys-apps/util-linux
	introspection? ( dev-libs/gobject-introspection:= )
	kmod? ( sys-apps/kmod )
	!sys-apps/gentoo-systemd-integration
	!sys-apps/systemd
	
"
RDEPEND="${CDEPEND}
	!sys-fs/udev
	!sys-apps/systemd
	!sys-fs/udev-init-scripts
	
"
DEPEND="${CDEPEND}
	dev-util/gperf
	virtual/os-headers
	virtual/pkgconfig
	sys-devel/make
	sys-kernel/linux-headers
	dev-util/intltool
	
"
PDEPEND="hwdb? ( sys-apps/hwids[udev] )
	
"
src_prepare() {
	# change rules back to group uucp instead of dialout for now
	sed -e 's/GROUP="dialout"/GROUP="uucp"/' -i rules/*.rules \
	|| die "failed to change group dialout to uucp"
	# FL-9484: enable net-generator for VMware virtual interfaces:
	sed -i -e '/^# ignore VMWare/,+1d' rule_generator/75-persistent-net-generator.rules || die "fail"
	eapply_user
	eautoreconf
}
src_configure() {
	tc-export CC #463846
	export cc_cv_CFLAGS__flto=no #502950
	 # Keep sorted by ./configure --help and only pass --disable flags
	# when *required* to avoid external deps or unnecessary compile
	local econf_args
	econf_args=(
	  ac_cv_search_cap_init=
	  ac_cv_header_sys_capability_h=yes
	  DBUS_CFLAGS=' '
	  DBUS_LIBS=' '
	  --with-rootprefix=
	  --with-rootrundir=/run
	  --exec-prefix="${EPREFIX}"
	  --bindir="${EPREFIX}"/bin
	  --includedir="${EPREFIX}"/usr/include
	  --libdir="${EPREFIX}"/usr/$(get_libdir)
	  --with-rootlibexecdir="${EPREFIX}"/lib/udev
	  --enable-split-usr
	  --enable-manpages
	  --disable-hwdb
	  --disable-selinux
	  --with-rootlibdir="${EPREFIX}"/$(get_libdir)
	  $(use_enable introspection)
	  $(use_enable kmod)
	  $(use_enable static-libs static)
	  $(use_enable rule-generator)
	)
	ECONF_SOURCE="${S}" econf "${econf_args[@]}"
}
src_install() {
	  find "${D}" -name '*.la' -delete || die
	  insinto /lib/udev/rules.d
	  for x in udev udev-trigger udev-settle; do
	      doinitd "${FILESDIR}"/$x
	  done
	  doins "${FILESDIR}"/40-macaroni.rules
	  use rule-generator && doinitd "${FILESDIR}"/udev-postmount
	  default
}
add_initd_to_runlevel() {
	  if [[ ! -x "${EROOT}"/etc/init.d/${1} ]]; then
	      die "${EROOT}/etc/init.d/${1} not found."
	  fi
	  if [[ ! -d "${EROOT}"/etc/runlevels/${2} ]]; then
	      die "Runlevel ${2} not found."
	  fi
	  if [[ ! -L "${EROOT}/etc/runlevels/${2}/${1}" ]]; then
	      ln -snf /etc/init.d/${1} "${EROOT}"/etc/runlevels/${2}/${1} || die "Couldn't add ${1} to runlevel ${2}"
	      ewarn "Adding ${1} to the ${2} runlevel"
	  fi
}
pkg_postinst() {
	# TODO: replace this with entities.
	enewgroup input
	enewgroup kvm 78
	enewgroup render
	mkdir -p "${EROOT}"run
	# "losetup -f" is confused if there is an empty /dev/loop/, Bug #338766
	# So try to remove it here (will only work if empty).
	rmdir "${EROOT}"dev/loop 2>/dev/null
	if [[ -d ${EROOT}dev/loop ]]; then
	    ewarn "Please make sure your remove /dev/loop,"
	    ewarn "else losetup may be confused when looking for unused devices."
	fi
	# REPLACING_VERSIONS should only ever have zero or 1 values but in case it doesn't,
	# process it as a list.  We only care about the zero case (new install) or the case where
	# the same version is being re-emerged.  If there is a second version, allow it to abort.
	local rv rvres=doitnew
	for rv in ${REPLACING_VERSIONS} ; do
	    if [[ ${rvres} == doit* ]]; then
	        if [[ ${rv%-r*} == ${PV} ]]; then
	            rvres=doit
	        else
	            rvres=${rv}
	        fi
	    fi
	done
	if use hwdb && has_version 'sys-apps/hwids[udev]'; then
	    udevadm hwdb --update --root="${ROOT%/}"
	    # https://cgit.freedesktop.org/systemd/systemd/commit/?id=1fab57c209035f7e66198343074e9cee06718bda
	    # reload database after it has be rebuilt, but only if we are not upgrading
	    if [[ ${rvres} == doit* ]] && [[ ${ROOT%/} == "" ]]; then
	        udevadm control --reload
	    fi
	fi
	if [[ ${rvres} != doitnew ]]; then
	    ewarn
	    ewarn "You need to restart eudev as soon as possible to make the"
	    ewarn "upgrade go into effect:"
	    ewarn "\t/etc/init.d/udev --nodeps restart"
	fi
	for f in udev udev-trigger; do
	    add_initd_to_runlevel $f sysinit
	done
	if use rule-generator; then
	    add_initd_to_runlevel udev-postmount default
	fi
}


# vim: filetype=ebuild
