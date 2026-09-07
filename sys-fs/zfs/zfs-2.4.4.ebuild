# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit autotools bash-completion-r1 distutils-r1 flag-o-matic linux-info pam toolchain-funcs udev systemd usr-ldscript

DESCRIPTION="OpenZFS on Linux and FreeBSD"
HOMEPAGE="https://openzfs.github.io/openzfs-docs"
SRC_URI="https://api.github.com/repos/openzfs/zfs/tarball/zfs-2.4.4 -> zfs-2.4.4-71a9f95.tar.gz"
LICENSE="BSD-2 CDDL MIT"
SLOT="0"
KEYWORDS="*"
IUSE="custom-cflags debug minimal nls pam python +rootfs static-libs systemd"
REQUIRED_USE="!minimal? ( ${PYTHON_REQUIRED_USE} )
python? ( !minimal )
"
# Commons depends
CDEPEND="net-libs/libtirpc[static-libs?]
	sys-apps/util-linux[static-libs?]
	sys-libs/zlib[static-libs(+)?]
	virtual/awk
	virtual/libudev[static-libs(-)?]
	dev-libs/openssl:=[static-libs?]
	!minimal? ( ${PYTHON_DEPS} )
	pam? ( sys-libs/pam )
	python? (
	  virtual/python-cffi[${PYTHON_USEDEP}]
	)
	
"
RDEPEND="${CDEPEND}
	rootfs? (
	  app-arch/cpio
	  app-misc/pax-utils
	)
	
"
DEPEND="${CDEPEND}
"

post_src_unpack() {
	mv openzfs-zfs-* ${S}
}


pkg_setup() {
	linux-info_pkg_setup
	if  ! linux_config_exists; then
	  ewarn "Cannot check the linux kernel configuration."
	fi
}
src_prepare() {
	default
	 # Set revision number
	sed -i "s/\(Release:\)\(.*\)1/\1\2${PR}-macaronios/" META || die "Could not set MacaroniOS release"
	 if use python; then
	  pushd contrib/pyzfs >/dev/null || die
	  distutils-r1_src_prepare
	  popd >/dev/null || die
	fi
	 # prevent errors showing up on zfs-mount stop, #647688
	# openrc will unmount all filesystems anyway.
	sed -i "/^ZFS_UNMOUNT=/ s/yes/no/" "etc/default/zfs.in" || die
	eautoreconf
}
src_configure() {
	use custom-cflags || strip-flags
	use minimal || python_setup
	 local myconf=(
	  --bindir="/bin"
	  --enable-shared
	  --disable-systemd
	  --enable-sysvinit
	  --localstatedir="/var"
	  --sbindir="/sbin"
	  --with-config=user
	  --with-dracutdir="/usr/lib/dracut"
	  --with-linux="${KV_DIR}"
	  --with-linux-obj="${KV_OUT_DIR}"
	  --with-udevdir="$(get_udevdir)"
	  --with-pamconfigsdir="/unwanted_files"
	  --with-pammoduledir="$(getpam_mod_dir)"
	  --with-vendor=gentoo
	  $(use_enable debug)
	  $(use_enable nls)
	  $(use_enable pam)
	  $(use_enable python pyzfs)
	  $(use_enable static-libs static)
	  $(usex minimal --without-python --with-python="${EPYTHON}")
	)
	 if use systemd ; then
	  myconf+=(
	    --enable-systemd
	    --disable-sysvinit
	    --with-systemdunitdir="$(systemd_get_systemunitdir)"
	    --with-systemdpresetdir="$(systemd_get_systempresetdir)"
	  )
	else
	  myconf+=(
	    --disable-systemd
	    --enable-sysvinit
	  )
	fi
	 econf "${myconf[@]}"
}

src_compile() {
	default
	if use python; then
	  pushd contrib/pyzfs >/dev/null || die
	  distutils-r1_src_compile
	  popd >/dev/null || die
	fi
}

src_install() {
	default
	 gen_usr_ldscript -a nvpair uutil zfsbootenv zfs zfs_core zpool
	 use pam && { rm -rv "${ED}/unwanted_files" || die ; }
	 if ! use static-libs; then
	  find "${ED}/" -name '*.la' -delete || die
	fi
	 dobashcomp contrib/bash_completion.d/zfs
	bashcomp_alias zfs zpool
	 # strip executable bit from conf.d file
	fperms 0644 /etc/conf.d/zfs
	 if use python; then
	  pushd contrib/pyzfs >/dev/null || die
	  distutils-r1_src_install
	  popd >/dev/null || die
	fi
	 # enforce best available python implementation
	use minimal || python_fix_shebang "${ED}/bin"
}

pkg_postinst() {
	if ! use systemd ; then
	  if [[ -e "${EROOT}/etc/runlevels/boot/zfs" ]]; then
	    einfo 'The zfs boot script has been split into the zfs-import,'
	    einfo 'zfs-mount and zfs-share scripts.'
	    einfo
	    einfo 'You had the zfs script in your boot runlevel. For your'
	    einfo 'convenience, it has been automatically removed and the three'
	    einfo 'scripts that replace it have been configured to start.'
	    einfo 'The zfs-import and zfs-mount scripts have been added to the boot'
	    einfo 'runlevel while the zfs-share script is in the default runlevel.'
	     rm "${EROOT}/etc/runlevels/boot/zfs"
	    ln -snf "${EROOT}/etc/init.d/zfs-import" \
	      "${EROOT}/etc/runlevels/boot/zfs-import"
	    ln -snf "${EROOT}/etc/init.d/zfs-mount" \
	      "${EROOT}/etc/runlevels/boot/zfs-mount"
	    ln -snf "${EROOT}/etc/init.d/zfs-share" \
	      "${EROOT}/etc/runlevels/default/zfs-share"
	  else
	    [[ -e "${EROOT}/etc/runlevels/boot/zfs-import" ]] || \
	      einfo "You should add zfs-import to the boot runlevel."
	    [[ -e "${EROOT}/etc/runlevels/boot/zfs-mount" ]]|| \
	      einfo "You should add zfs-mount to the boot runlevel."
	    [[ -e "${EROOT}/etc/runlevels/default/zfs-share" ]] || \
	      einfo "You should add zfs-share to the default runlevel."
	  fi
	   if [[ -e "${EROOT}/etc/runlevels/default/zed" ]]; then
	    einfo 'The downstream OpenRC zed script has replaced by the upstream'
	    einfo 'OpenRC zfs-zed script.'
	    einfo
	    einfo 'You had the zed script in your default runlevel. For your'
	    einfo 'convenience, it has been automatically removed and the zfs-zed'
	    einfo 'script that replaced it has been configured to start.'
	     rm "${EROOT}/etc/runlevels/boot/zed"
	    ln -snf "${EROOT}/etc/init.d/zfs-zed" \
	      "${EROOT}/etc/runlevels/default/zfs-zed"
	  else
	    [[ -e "${EROOT}/etc/runlevels/default/zfs-zed" ]] || \
	      einfo "You should add zfs-zed to the default runlevel."
	  fi
	   if [[ -e "${EROOT}/etc/runlevels/shutdown/zfs-shutdown" ]]; then
	    einfo "The zfs-shutdown script is obsolete. Removing it from runlevel."
	    rm "${EROOT}/etc/runlevels/shutdown/zfs-shutdown"
	  fi
	fi
}



# vim: filetype=ebuild
