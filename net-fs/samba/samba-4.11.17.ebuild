# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3+ )
PYTHON_REQ_USE='threads(+),xml(+)'
inherit python-single-r1 waf-utils linux-info pam

MY_PV="${PV/_rc/rc}"
MY_P="${PN}-${MY_PV}"

SRC_PATH="stable"
[[ ${PV} = *_rc* ]] && SRC_PATH="rc"

SRC_URI="mirror://samba/${SRC_PATH}/${MY_P}.tar.gz"
[[ ${PV} = *_rc* ]] || \
KEYWORDS="*"

DESCRIPTION="Samba Suite Version 4"
HOMEPAGE="https://www.samba.org/"
LICENSE="GPL-3"

SLOT="0"

IUSE="acl addc addns ads ceph client cluster cups debug dmapi fam gpg iprint
json ldap pam profiling-data python quota selinux snapper syslog
system-heimdal +system-mitkrb5 test winbind zeroconf"

CDEPEND="
	>=app-arch/libarchive-3.1.2
	dev-lang/perl:=
	dev-libs/libbsd
	dev-libs/libtasn1
	dev-libs/popt
	>=net-libs/gnutls-3.2.0
	net-libs/libnsl
	sys-libs/e2fsprogs-libs
	$(python_gen_cond_dep '
		dev-python/subunit[${PYTHON_USEDEP}]
		>=sys-libs/ldb-2.0.12[ldap(+)?,python?,${PYTHON_USEDEP}]
		<sys-libs/ldb-2.2.0[ldap(+)?,python?,${PYTHON_USEDEP}]
		>=sys-libs/talloc-2.2.0[python?,${PYTHON_USEDEP}]
		>=sys-libs/tdb-1.4.2[python?,${PYTHON_USEDEP}]
		>=sys-libs/tevent-0.10.0[python?,${PYTHON_USEDEP}]
		>=sys-libs/talloc-2.2.0[python?,${PYTHON_USEDEP}]
		>=sys-libs/tdb-1.4.2[python?,${PYTHON_USEDEP}]
		>=sys-libs/tevent-0.10.0[python?,${PYTHON_USEDEP}]
	')
	sys-libs/libcap
	sys-libs/ncurses:0=
	sys-libs/readline:0=
	sys-libs/zlib
	virtual/libiconv
	pam? ( sys-libs/pam )
	acl? ( virtual/acl )
	addns? (
		net-dns/bind-tools[gssapi]
		$(python_gen_cond_dep '
		dev-python/dnspython:=[${PYTHON_USEDEP}]
		')
	)
	ceph? ( sys-cluster/ceph )
	cluster? (
		net-libs/rpcsvc-proto
		!dev-db/ctdb
	)
	cups? ( net-print/cups )
	debug? ( dev-util/lttng-ust )
	dmapi? ( sys-apps/dmapi )
	fam? ( app-admin/fam )
	gpg? ( app-crypt/gpgme )
	json? ( dev-libs/jansson )
	ldap? ( net-nds/openldap )
	snapper? ( sys-apps/dbus )
	system-heimdal? ( >=app-crypt/heimdal-1.5[-ssl] )
	system-mitkrb5? ( >=app-crypt/mit-krb5-1.15.1 )
	zeroconf? ( net-dns/avahi[dbus] )
"
DEPEND="${CDEPEND}
	${PYTHON_DEPS}
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt
	>=dev-util/cmocka-1.1.1
	net-libs/libtirpc
	virtual/pkgconfig
	|| (
		net-libs/rpcsvc-proto
		<sys-libs/glibc-2.26[rpc(+)]
	)
	test? (
		>=sys-libs/nss_wrapper-1.1.6
		>=net-dns/resolv_wrapper-1.1.4
		>=net-libs/socket_wrapper-1.2.3
		>=sys-libs/uid_wrapper-1.2.1
		>=sys-libs/pam_wrapper-1.0.7
	)"
RDEPEND="${CDEPEND}
	python? ( ${PYTHON_DEPS} )
	client? ( net-fs/cifs-utils[ads?] )
	selinux? ( sec-policy/selinux-samba )
	!dev-perl/Parse-Yapp
"

REQUIRED_USE="
	addc? ( python json winbind )
	addns? ( python )
	ads? ( acl ldap winbind )
	cluster? ( ads )
	gpg? ( addc )
	test? ( python )
	?? ( system-heimdal system-mitkrb5 )
	${PYTHON_REQUIRED_USE}
"

# the test suite is messed, it uses system-installed samba
# bits instead of what was built, tests things disabled via use
# flags, and generally just fails to work in a way ebuilds could
# rely on in its current state
RESTRICT="test"

S="${WORKDIR}/${MY_P}"

PATCHES=(
	"${FILESDIR}/${PN}-4.4.0-pam.patch"
	"${FILESDIR}/${PN}-4.9.2-timespec.patch"
	"${FILESDIR}/${PN}-4.13-winexe_option.patch"
	"${FILESDIR}/${PN}-4.13-vfs_snapper_configure_option.patch"
	"${FILESDIR}/samba-4.11-glibc-2.32-nss-compat.patch"
)

CONFDIR="${FILESDIR}/4.11"

WAF_BINARY="${S}/buildtools/bin/waf"

SHAREDMODS=""

pkg_setup() {
	# Package fails to build with distcc
	export DISTCC_DISABLE=1

	python-single-r1_pkg_setup
	if use cluster ; then
		SHAREDMODS="idmap_rid,idmap_tdb2,idmap_ad"
	elif use ads ; then
		SHAREDMODS="idmap_ad"
	fi
}

src_prepare() {
	default

	# un-bundle dnspython
	sed -i -e '/"dns.resolver":/d' "${S}"/third_party/wscript || die

	# unbundle iso8601 unless tests are enabled
	if ! use test ; then
		sed -i -e '/"iso8601":/d' "${S}"/third_party/wscript || die
	fi

	## ugly hackaround for bug #592502
	#cp /usr/include/tevent_internal.h "${S}"/lib/tevent/ || die

	# get rid of annoying xattr.h warning:
	find -iname *.[ch] -exec sed -i -e 's:<attr/xattr\.h>:\<sys/xattr.h>:g' {} \; || die
	sed -e 's:<gpgme\.h>:<gpgme/gpgme.h>:' \
		-i source4/dsdb/samdb/ldb_modules/password_hash.c \
	|| die
}

src_configure() {
	# when specifying libs for samba build you must append NONE to the end to
	# stop it automatically including things
	local bundled_libs="NONE"
	if ! use system-heimdal && ! use system-mitkrb5 ; then
		bundled_libs="heimbase,heimntlm,hdb,kdc,krb5,wind,gssapi,hcrypto,hx509,roken,asn1,com_err,NONE"
	fi

	local myconf=(
		--enable-fhs
		--sysconfdir="${EPREFIX}/etc"
		--localstatedir="${EPREFIX}/var"
		--with-modulesdir="${EPREFIX}/usr/$(get_libdir)/samba"
		--with-piddir="${EPREFIX}/run/${PN}"
		--bundled-libraries="${bundled_libs}"
		--builtin-libraries=NONE
		--disable-rpath
		--disable-rpath-install
		--nopyc
		--nopyo
		--without-winexe
		$(use_with acl acl-support)
		$(usex addc '' '--without-ad-dc')
		$(use_with addns dnsupdate)
		$(use_with ads)
		$(use_enable ceph cephfs)
		$(use_with cluster cluster-support)
		$(use_enable cups)
		$(use_with dmapi)
		$(use_with fam)
		$(use_with gpg gpgme)
		$(use_with json )
		$(use_enable iprint)
		$(use_with pam)
		$(usex pam "--with-pammodulesdir=${EPREFIX}/$(get_libdir)/security" '')
		$(use_with quota quotas)
		$(use_enable snapper)
		$(use_with syslog)
		$(use_with winbind)
		$(usex python '' '--disable-python')
		$(use_enable zeroconf avahi)
		$(usex test '--enable-selftest' '')
		$(usex system-mitkrb5 "--with-system-mitkrb5 $(usex addc --with-experimental-mit-ad-dc '')" '')
		$(use_with debug lttng)
		$(use_with ldap)
		$(use_with profiling-data)
		--with-shared-modules=${SHAREDMODS}
		--jobs 1
	)

	CPPFLAGS="-I${SYSROOT}${EPREFIX}/usr/include/et ${CPPFLAGS}" \
		waf-utils_src_configure ${myconf[@]}
}

src_compile() {
	waf-utils_src_compile
}

src_install() {
	waf-utils_src_install

	# Make all .so files executable
	find "${ED}" -type f -name "*.so" -exec chmod +x {} + || die

	# install ldap schema for server (bug #491002)
	if use ldap ; then
		insinto /etc/openldap/schema
		doins examples/LDAP/samba.schema
	fi

	# create symlink for cups (bug #552310)
	if use cups ; then
		dosym ../../../bin/smbspool /usr/libexec/cups/backend/smb
	fi

	# install example config file
	insinto /etc/samba
	doins examples/smb.conf.default

	# Fix paths in example file (#603964)
	sed \
		-e '/log file =/s@/usr/local/samba/var/@/var/log/samba/@' \
		-e '/include =/s@/usr/local/samba/lib/@/etc/samba/@' \
		-e '/path =/s@/usr/local/samba/lib/@/var/lib/samba/@' \
		-e '/path =/s@/usr/local/samba/@/var/lib/samba/@' \
		-e '/path =/s@/usr/spool/samba@/var/spool/samba@' \
		-i "${ED%/}"/etc/samba/smb.conf.default || die

	# Install init script and conf.d file
	newinitd "${CONFDIR}/samba4.initd-r1" samba
	newconfd "${CONFDIR}/samba4.confd" samba


	if use pam && use winbind ; then
		newpamd "${CONFDIR}/system-auth-winbind.pam" system-auth-winbind
		# bugs #376853 and #590374
		insinto /etc/security
		doins examples/pam_winbind/pam_winbind.conf
	fi

	keepdir /var/cache/samba
	keepdir /var/lib/ctdb
	keepdir /var/lib/samba/{bind-dns,private}
	keepdir /var/log/samba
}

src_install_all() {
	# Attempt to fix bug #673168
	find "${ED}" -type d -name "Yapp" -print0 \
		| xargs -0 --no-run-if-empty rm -r || die
}

src_test() {
	"${WAF_BINARY}" test || die "test failed"
}

pkg_postinst() {
	ewarn "Be aware that this release contains the best of all of Samba's"
	ewarn "technology parts, both a file server (that you can reasonably expect"
	ewarn "to upgrade existing Samba 3.x releases to) and the AD domain"
	ewarn "controller work previously known as 'samba4'."

	elog "For further information and migration steps make sure to read "
	elog "https://samba.org/samba/history/${P}.html "
	elog "https://wiki.samba.org/index.php/Samba4/HOWTO "
}
