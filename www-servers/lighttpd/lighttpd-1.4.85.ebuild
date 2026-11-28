# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
LUA_COMPAT=( lua5-{1..3} )
inherit autotools flag-o-matic lua-single systemd user

DESCRIPTION="Lightweight high-performance web server"
HOMEPAGE="https://www.lighttpd.net https://github.com/lighttpd/lighttpd1.4"
SRC_URI="https://api.github.com/repos/lighttpd/lighttpd1.4/tarball/refs/tags/lighttpd-1.4.85 -> lighttpd-1.4.85-4852959.tar.gz"
LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="*"
IUSE="bzip2 dbi doc fam ipv6 kerberos ldap libev lua minimal mmap mysql pcre php postgres rrdtool sasl selinux ssl systemd sqlite webdav xattr zlib"
REQUIRED_USE="kerberos? ( ssl ) webdav? ( sqlite ) lua? ( ${LUA_REQUIRED_USE} )"
# Commons depends
CDEPEND="bzip2?    ( app-arch/bzip2 )
	dbi?      ( dev-db/libdbi )
	fam?      ( virtual/fam )
	ldap?     ( >=net-nds/openldap-2.1.26 )
	libev?    ( dev-libs/libev )
	lua?      ( >=dev-lang/lua-5.1:= )
	mysql?    ( dev-db/mysql-connector-c:= )
	pcre?     ( dev-libs/libpcre2 )
	php?      ( dev-lang/php:*[cgi] )
	postgres? ( dev-db/postgresql:* )
	rrdtool?  ( net-analyzer/rrdtool )
	sasl?     ( dev-libs/cyrus-sasl )
	ssl? ( dev-libs/openssl:0=[kerberos(-)?] )
	sqlite?   ( dev-db/sqlite:3 )
	webdav? (
	  dev-libs/libxml2
	  sys-fs/e2fsprogs
	)
	xattr? ( sys-apps/attr )
	zlib?  ( sys-libs/zlib )
	
"
BDEPEND="virtual/pkgconfig
	doc? ( dev-python/docutils )
	
"
RDEPEND="${CDEPEND}
	selinux? ( sec-policy/selinux-apache )
	
"
DEPEND="${CDEPEND}
	
"

post_src_unpack() {
	mv lighttpd-lighttpd1.4-* ${S}
}


update_config() {
	local config="${D}/etc/lighttpd/lighttpd.conf"
	 # enable php/mod_fastcgi settings
	use php && { sed -i -e 's|#.*\(include.*fastcgi.*$\)|\1|' ${config} || die; }
	 # enable stat() caching
	use fam && { sed -i -e 's|#\(.*stat-cache.*$\)|\1|' ${config} || die; }
	 # automatically listen on IPv6 if built with USE=ipv6. Bug #234987
	use ipv6 && { sed -i -e 's|# server.use-ipv6|server.use-ipv6|' ${config} || die; }
}

remove_non_essential() {
	local libdir="${D}/usr/$(get_libdir)/${PN}"
	 # text docs
	use doc || rm -fr "${D}"/usr/share/doc/${PF}/txt
	 # non-essential modules
	rm -f \
	  ${libdir}/mod_{compress,evhost,expire,proxy,scgi,secdownload,simple_vhost,status,setenv,trigger*,usertrack}.* || die
	 # allow users to keep some based on USE flags
	use pcre    || rm -f ${libdir}/mod_{ssi,re{direct,write}}.*
	use webdav  || rm -f ${libdir}/mod_webdav.*
	use mysql   || rm -f ${libdir}/mod_mysql_vhost.*
	use lua     || rm -f ${libdir}/mod_{cml,magnet}.*
	use rrdtool || rm -f ${libdir}/mod_rrdtool.*
	use zlib    || rm -f ${libdir}/mod_compress.*
}

pkg_setup() {
	use lua && lua-single_pkg_setup
	 enewgroup lighttpd 302
	enewuser lighttpd 302 -1 /dev/null lighttpd
}

src_prepare() {
	default
	sed -i -e 's|\(rst2html\)|\1.py|g' doc/outdated/Makefile.am || \
	  die "sed doc/Makefile.am failed"
	eautoreconf
}

src_configure() {
	# The lua bit requires a bit of explanation. The lighttpd autoconf script
	# handles the value passed to --with-lua as follows:
	#  - "no" - do nothing
	#  - "yes" - query pkgconfig for VERSIONED lua packages, starting with 5.3
	#    and going down; only if lua5.1 cannot be found plain "lua" is tried
	#  - any other value is passed to pkgconfig as the exact package name to use.
	econf --libdir=/usr/$(get_libdir)/${PN} \
	  --enable-lfs \
	  $(use_enable ipv6) \
	  $(use_enable mmap) \
	  $(use_with bzip2) \
	  $(use_with dbi) \
	  $(use_with fam) \
	  $(use_with kerberos krb5) \
	  $(use_with ldap) \
	  $(use_with libev) \
	  $(use_with lua) \
	  $(use_with mysql) \
	  $(use_with pcre pcre2) \
	  $(use_with postgres pgsql) \
	  $(use_with sasl) \
	  $(use_with ssl openssl) \
	  $(use_with sqlite sqlite) \
	  $(use_with webdav webdav-props) \
	  $(use_with webdav webdav-locks) \
	  $(use_with xattr attr) \
	  $(use_with zlib)
}

src_compile() {
	emake
	 if use doc ; then
	  einfo "Building HTML documentation"
	  cd doc || die
	  emake html
	fi
}

src_install() {
	default
	 find "${D}" -name '*.la' -delete || die
	 # init script stuff
	newconfd "${FILESDIR}"/lighttpd.confd lighttpd
	if use systemd ; then
	  systemd_dounit "${FILESDIR}"/lighttpd.service
	else
	  newinitd "${FILESDIR}"/lighttpd.initd lighttpd
	  use fam && has_version app-admin/fam && \
	    { sed -i 's/after famd/need famd/g' "${D}"/etc/init.d/lighttpd || die; }
	fi
	 # configs
	insinto /etc/lighttpd
	doins "${FILESDIR}"/conf/lighttpd.conf
	doins "${FILESDIR}"/conf/mime-types.conf
	doins "${FILESDIR}"/conf/mod_cgi.conf
	doins "${FILESDIR}"/conf/mod_fastcgi.conf
	 # update lighttpd.conf directives based on conditionals
	update_config
	 # docs
	dodoc AUTHORS README NEWS doc/scripts/*.sh
	newdoc doc/config//lighttpd.conf lighttpd.conf.distrib
	 use doc && dodoc -r doc
	 docinto txt
	dodoc doc/outdated/*.txt
	 # logrotate
	insinto /etc/logrotate.d
	newins "${FILESDIR}"/lighttpd.logrotate-r1 lighttpd
	 keepdir /var/l{ib,og}/lighttpd /var/www/localhost/htdocs
	fowners lighttpd:lighttpd /var/l{ib,og}/lighttpd
	fperms 0750 /var/l{ib,og}/lighttpd
	 #spawn-fcgi may optionally be installed via www-servers/spawn-fcgi
	rm -f "${D}"/usr/bin/spawn-fcgi "${D}"/usr/share/man/man1/spawn-fcgi.* || die
	 use minimal && remove_non_essential
}

pkg_postinst() {
	if use ipv6 ; then
	  einfo "IPv6 support is enabled: lighttpd listens on IPv6 if server.use-ipv6"
	  einfo "is set in /etc/lighttpd/lighttpd.conf. Migration guide:"
	  einfo "http://redmine.lighttpd.net/projects/lighttpd/wiki/IPv6-Config"
	fi
	 if [[ -f ${ROOT}etc/conf.d/spawn-fcgi.conf ]] ; then
	  einfo "spawn-fcgi is now provided by www-servers/spawn-fcgi."
	  einfo "spawn-fcgi's init script configuration is now located"
	  einfo "at /etc/conf.d/spawn-fcgi."
	fi
	 if [[ -f ${ROOT}etc/lighttpd.conf ]] ; then
	  elog "MacaroniOS has a customized configuration,"
	  elog "which is now located in /etc/lighttpd.  Please migrate your"
	  elog "existing configuration."
	fi
}



# vim: filetype=ebuild
