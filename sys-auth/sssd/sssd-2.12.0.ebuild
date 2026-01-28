# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
PLOCALES="ca de es fr ja ko pt_BR ru sv tr"
PLOCALES_BIN="${PLOCALES} bg cs eu fi hu id it ka nb nl pl pt tg zh_TW zh_CN"
PLOCALE_BACKUP="sv"
CONFIG_CHECK="~KEYS"
inherit autotools flag-o-matic linux-info optfeature plocale python-single-r1 pam systemd tmpfiles toolchain-funcs udev user

DESCRIPTION="A daemon to manage identity, authentication and authorization for centrally-managed systems."
HOMEPAGE="https://sssd.io"
SRC_URI="https://github.com/SSSD/sssd/releases/download/2.12.0/sssd-2.12.0.tar.gz -> sssd-2.12.0.tar.gz"
LICENSE="GPL-3.0"
SLOT="0"
KEYWORDS="*"
IUSE="cifs doc +man +netlink nfsv4 nls passkey python samba subid sudo systemd systemtap"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"
BDEPEND="sys-libs/libcap
	virtual/pkgconfig
	${PYTHON_DEPS}
	doc? ( app-text/doxygen )
	man? (
	  app-text/docbook-xml-dtd:4.5
	  dev-libs/libxslt
	  nls? ( app-text/po4a )
	  )
	nls? ( sys-devel/gettext )
	
"
RDEPEND="${DEPEND}
"
DEPEND="app-crypt/mit-krb5
	app-crypt/p11-kit
	dev-libs/ding-libs
	dev-libs/cyrus-sasl[kerberos]
	dev-libs/jansson:=
	dev-libs/libpcre2:=
	dev-libs/libunistring:=
	dev-libs/popt
	dev-libs/openssl:=
	net-dns/bind-tools[gssapi]
	net-dns/c-ares:=
	cifs? ( net-fs/cifs-utils[acl] )
	net-nds/openldap:=[sasl,experimental]
	sys-apps/dbus
	sys-apps/keyutils
	sys-apps/shadow
	sys-libs/ldb:=
	>=sys-libs/libcap-2.77
	sys-libs/pam
	sys-libs/talloc
	sys-libs/tdb
	sys-libs/tevent
	virtual/libintl
	netlink? ( dev-libs/libnl:3 )
	nfsv4? ( net-fs/nfs-utils )
	passkey? (
	  dev-libs/libfido2
	  sys-apps/pcsc-lite[policykit]
	)
	python? (
	  ${PYTHON_DEPS}
	  systemd? (
	    $(python_gen_cond_dep '
	      dev-python/python-systemd[${PYTHON_USEDEP}]
	    ')
	  )
	)
	samba? ( net-fs/samba[winbind] )
	systemd? (
	  sys-apps/systemd:=
	  sys-apps/util-linux
	)
	systemtap? ( dev-debug/systemtap )
	
"

post_src_unpack() {
	mv SSSD-sssd-* ${S}
}


pkg_setup() {
	linux-info_pkg_setup
	python-single-r1_pkg_setup
	enewgroup sssd 547
	enewuser sssd 547 /var/lib/sss /sbin/nologin sssd
}
src_prepare() {
	default
	plocale_get_locales > src/man/po/LINGUAS || die
	sed -i \
		-e "/_langs]/ s/ .*//" \
		src/man/po/po4a.cfg \
		|| die
	enable_locale() {
		local locale=${1}
		sed -i \
			-e "/_langs]/ s/$/ ${locale}/" \
			src/man/po/po4a.cfg \
			|| die
	}
	plocale_for_each_locale enable_locale
	PLOCALES="${PLOCALES_BIN}"
	plocale_get_locales > po/LINGUAS || die
	sed -i \
		-e 's:/var/run:/run:' \
		src/examples/logrotate \
		|| die
	# disable flaky test, see https://github.com/SSSD/sssd/issues/5631
	sed -i \
		-e '/^\s*pam-srv-tests[ \\]*$/d' \
		Makefile.am \
		|| die
	# requires valgrind headers installed, see
	# https://github.com/SSSD/sssd/pull/7845
	sed -i \
		-e '/^\s*test_iobuf[ \\]*$/d' \
		Makefile.am \
		|| die
	eautoreconf
}

src_configure() {
	local native_dbus_cflags=$($(tc-getPKG_CONFIG) --cflags dbus-1 || die)
	local myconf=()
	 myconf+=(
		--libexecdir="${EPREFIX}"/usr/libexec
		--localstatedir="${EPREFIX}"/var
		--runstatedir="${EPREFIX}"/run
		--sbindir="${EPREFIX}"/usr/sbin
		--with-pid-path="${EPREFIX}"/run/sssd
		--with-plugin-path="${EPREFIX}"/usr/$(get_libdir)/sssd
		--enable-pammoddir="${EPREFIX}"/$(getpam_mod_dir)
		--with-ldb-lib-dir="${EPREFIX}"/usr/$(get_libdir)/samba/ldb
		--with-db-path="${EPREFIX}"/var/lib/sss/db
		--with-gpo-cache-path="${EPREFIX}"/var/lib/sss/gpo_cache
		--with-pubconf-path="${EPREFIX}"/var/lib/sss/pubconf
		--with-pipe-path="${EPREFIX}"/var/lib/sss/pipes
		--with-mcache-path="${EPREFIX}"/var/lib/sss/mc
		--with-secrets-db-path="${EPREFIX}"/var/lib/sss/secrets
		--with-log-path="${EPREFIX}"/var/log/sssd
		--with-tmpfilesdir=/usr/lib/tmpfiles.d
		--with-udevrulesdir="$(get_udevdir)/rules.d"
		--with-kcm
		--enable-kcm-renewal
		--with-os=gentoo
		--disable-rpath
		--disable-static
		# Valgrind is only used for tests
		--disable-valgrind
		$(use_with samba)
		--with-smb-idmap-interface-version=6
		$(use_enable cifs cifs-idmap-plugin)
		--without-selinux
		--enable-krb5-locator-plugin
		$(use_enable samba pac-responder)
		$(use_with nfsv4 nfsv4-idmapd-plugin)
		$(use_enable nls)
		$(use_with netlink libnl)
		$(use_with man manpages)
		$(use_with sudo)
		--with-autofs
		--with-ssh
		--without-oidc-child
		$(use_with passkey)
		$(use_with subid)
		$(use_enable systemtap)
		--without-python2-bindings
		$(use_with python python3-bindings)
		# Annoyingly configure requires that you pick systemd XOR sysv
		--with-initscript=$(usex systemd systemd sysv)
		--with-sssd-user=sssd
		KRB5_CONFIG="${ESYSROOT}"/usr/bin/krb5-config
		CPPFLAGS="${CPPFLAGS} -I${ESYSROOT}/usr/include/samba-4.0"
	)
	 use systemd && myconf+=(
		--with-systemdunitdir=$(systemd_get_systemunitdir)
	)
	 econf "${myconf[@]}"
	echo $S
}

src_compile() {
	default
	use doc && emake docs
}

src_install() {
	emake -j1 DESTDIR="${D}" install
	if use python; then
	  python_fix_shebang "${ED}"
	  python_optimize
	fi
	einstalldocs
	 insinto /etc/sssd
	insopts -m600
	doins src/examples/sssd-example.conf
	 insinto /etc/logrotate.d
	insopts -m644
	newins src/examples/logrotate sssd
	 newconfd "${FILESDIR}"/sssd.conf sssd
	 keepdir /var/lib/sss/db
	keepdir /var/lib/sss/deskprofile
	keepdir /var/lib/sss/gpo_cache
	keepdir /var/lib/sss/keytabs
	keepdir /var/lib/sss/mc
	keepdir /var/lib/sss/pipes/private
	keepdir /var/lib/sss/pubconf/krb5.include.d
	keepdir /var/lib/sss/secrets
	keepdir /var/log/sssd
	keepdir /etc/sssd/conf.d
	keepdir /etc/sssd/pki
	 # strip empty dirs
	if ! use doc; then
	  rm -r "${ED}"/usr/share/doc/"${PF}"/doc || die
	  rm -r "${ED}"/usr/share/doc/"${PF}"/{hbac,idmap,nss_idmap}_doc || die
	fi
	 rm -r "${ED}"/run || die
	find "${ED}" -type f -name '*.la' -delete || die
}

pkg_postinst() {
	tmpfiles_process sssd-tmpfiles.conf
	echo
	elog "You must set up sssd.conf (default installed into /etc/sssd)"
	elog "and (optionally) configuration in /etc/pam.d in order to use SSSD"
	elog "features."
	echo
	optfeature "Kerberos keytab renew (see krb5_renew_interval)" app-crypt/adcli
	 if ! use python; then
	          echo
	          ewarn "sssctl analyze will not work because the python USE flag is disabled."
	fi
}



# vim: filetype=ebuild
