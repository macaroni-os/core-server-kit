# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
APACHE_LAYOUT=MacaroniOS
IUSE_MPMS_FORK="prefork"
IUSE_MPMS_THREAD="event worker"
IUSE_MODULES="access_compat actions alias asis auth_basic auth_digest auth_form authn_alias authn_anon authn_core authn_dbd authn_dbm authn_file authn_socache authz_core authz_dbd authz_dbm authz_groupfile authz_host authz_owner authz_user autoindex brotli cache cache_disk cache_socache cern_meta charset_lite cgi cgid dav dav_fs dav_lock dbd deflate dir dumpio env expires ext_filter file_cache filter headers http2 ident imagemap include info lbmethod_byrequests lbmethod_bytraffic lbmethod_bybusyness lbmethod_heartbeat log_config log_forensic logio macro md mime mime_magic negotiation proxy proxy_ajp proxy_balancer proxy_connect proxy_ftp proxy_html proxy_http proxy_scgi proxy_http2 proxy_fcgi proxy_wstunnel rewrite ratelimit remoteip reqtimeout session session_cookie session_crypto session_dbd setenvif slotmem_shm speling socache_memcache socache_shmcb status substitute unique_id userdir usertrack unixd version vhost_alias watchdog xml2enc"
MODULE_DEPENDS="
auth_form:session
brotli:filter
dav_fs:dav
dav_lock:dav
deflate:filter
cache_disk:cache
ext_filter:filter
file_cache:cache
lbmethod_byrequests:proxy_balancer
lbmethod_byrequests:slotmem_shm
lbmethod_bytraffic:proxy_balancer
lbmethod_bybusyness:proxy_balancer
lbmethod_heartbeat:proxy_balancer
log_forensic:log_config
logio:log_config
cache_socache:cache
md:watchdog
mime_magic:mime
proxy_ajp:proxy
proxy_balancer:proxy
proxy_balancer:slotmem_shm
proxy_connect:proxy
proxy_ftp:proxy
proxy_html:proxy
proxy_html:xml2enc
proxy_http:proxy
proxy_http2:proxy
proxy_scgi:proxy
proxy_fcgi:proxy
proxy_wstunnel:proxy
session_cookie:session
session_dbd:dbd
session_dbd:session
socache_memcache:cache
substitute:filter
"

MODULE_DEFINES="
auth_digest:AUTH_DIGEST
authnz_ldap:AUTHNZ_LDAP
cache:CACHE
cache_disk:CACHE
cache_socache:CACHE
dav:DAV
dav_fs:DAV
dav_lock:DAV
file_cache:CACHE
http2:HTTP2
info:INFO
ldap:LDAP
md:SSL
proxy:PROXY
proxy_ajp:PROXY
proxy_balancer:PROXY
proxy_connect:PROXY
proxy_ftp:PROXY
proxy_html:PROXY
proxy_http:PROXY
proxy_fcgi:PROXY
proxy_scgi:PROXY
proxy_wstunnel:PROXY
socache_shmcb:SSL
socache_memcache:CACHE
ssl:SSL
status:STATUS
suexec:SUEXEC
userdir:USERDIR
"

MODULE_CRITICAL="authn_core authz_core authz_host dir mime unixd"
inherit apache-2 systemd tmpfiles toolchain-funcs

DESCRIPTION="The Apache Web Server"
HOMEPAGE="https://httpd.apache.org/"
SRC_URI="https://archive.apache.org/dist/httpd/httpd-2.4.71.tar.bz2 -> httpd-2.4.71.tar.bz2"
LICENSE="Apache-2.0 Apache-1.1"
SLOT="2"
KEYWORDS="*"
PATCHES=(
	"${FILESDIR}/01_all_mod_rewrite_ampescape.patch"
	"${FILESDIR}/03_all_apache-tools-support-install.patch"
	"${FILESDIR}/04_no_which.patch"
)
DOCS=(
	ABOUT_APACHE
	CHANGES
	LAYOUT
	README
	README.platforms
	VERSIONING
)
IUSE="${IUSE/apache2_modules_http2/+apache2_modules_http2} +suexec-caps suexec-syslog split-usr systemd"
REQUIRED_USE="${REQUIRED_USE} apache2_modules_http2? ( ssl ) apache2_modules_md? ( ssl )"
RDEPEND="apache2_modules_brotli? ( >=app-arch/brotli-0.6.0:= )
	apache2_modules_http2? ( >=net-libs/nghttp2-1.2.1 )
	apache2_modules_proxy_http2? ( >=net-libs/nghttp2-1.2.1 )
	apache2_modules_md? ( >=dev-libs/jansson-2.10 )
	apache2_modules_session_crypto? ( dev-libs/apr-util[openssl] )
	
"
DEPEND="${RDEPEND}
	suexec? ( suexec-caps? ( sys-libs/libcap ) )
	
"
generate_load_module() {
	local endit=0 mod_lines= mod_dir="${ED%/}/usr/$(get_libdir)/apache2/modules"

	if use static; then
		sed -i -e "/%%LOAD_MODULE%%/d" \
			"${D}"/etc/apache2/httpd.conf
		return
	fi

	for m in ${MY_MODS[@]} ; do
		if [[ -e "${mod_dir}/mod_${m}.so" ]] ; then
			for def in ${MODULE_DEFINES} ; do
				if [[ "${m}" == "${def%:*}" ]] ; then
					mod_lines="${mod_lines}\n<IfDefine ${def#*:}>"
					endit=1
				fi
			done

			mod_lines="${mod_lines}\nLoadModule ${m}_module modules/mod_${m}.so"

			if [[ ${endit} -ne 0 ]] ; then
				mod_lines="${mod_lines}\n</IfDefine>"
				endit=0
			fi
		fi
	done

	sed -i -e "s:%%LOAD_MODULE%%:${mod_lines}:" \
		"${D}"/etc/apache2/httpd.conf
}

src_prepare() {
	default

	# Disable install-conf target. We use our customization.
	sed -i -e 's|^INSTALL_TARGETS = install-conf|INSTALL_TARGETS =|g' \
		Makefile.in

	# We use suexec binary from /usr/bin
	sed -i -e 's|^#define SUEXEC_BIN.*|#define SUEXEC_BIN "/usr/bin/suexec"|g' \
		include/httpd.h

	# Creating the MacaroniOS layout
	cp "${FILESDIR}"/customization/macaroni.config.layout "${S}"/ || \
		die "Copying macaroni.config.layout"

	# Ensure right libdir
	# Keep the layout libdir in sync with the final install
	sed -i -e "s:/usr/lib:/usr/$(get_libdir):g" \
		"${S}"/macaroni.config.layout || die "libdir sed failed"
	# Setup the filesystem layout config
	cat "${S}"/macaroni.config.layout >> "${S}"/config.layout || \
		die "Failed preparing config.layout!"
	sed -i -e "s:version:${PF}:g" "${S}"/config.layout

	# apache2.8 instead of httpd.8
	mv docs/man/{httpd,apache2}.8
	sed -i -e 's/httpd\.8/apache2.8/g' Makefile.in

	# Don't rename configure.in _before_ any possible user patches!
	if [[ -f "configure.in" ]] ; then
		einfo "Renaming configure.in to configure.ac"
		mv configure.{in,ac} || die
	fi

	# patched-in MPMs need the build environment rebuilt
	sed -i -e '/sinclude/d' configure.ac
	AT_M4DIR=build eautoreconf

	# ${T} must be not group-writable, else grsec TPE will block it
	chmod g-w "${T}"

	# This package really should upgrade to using pcre's .pc file.
	cat <<-\EOF >"${T}"/pcre-config
	#!/bin/bash
	flags=()
	for flag; do
		if [[ ${flag} == "--version" ]]; then
			flags+=( --modversion )
		else
			flags+=( "${flag}" )
		fi
	done
	exec ${PKG_CONFIG} libpcre "${flags[@]}"
	EOF
	chmod a+x "${T}"/pcre-config
}

pkg_setup() {
	# dependend critical modules which are not allowed in global scope due
	# to USE flag conditionals
	use ssl && MODULE_CRITICAL+=" socache_shmcb"
	use doc && MODULE_CRITICAL+=" alias negotiation setenvif"
	apache-2_pkg_setup
}

src_configure() {
	# Instead of hardcode PLATFORM on server/core.c using PLATFORM
	# define.
	append-cflags -DPLATFORM='\"MacaroniOS\"'

	apache-2_src_configure
}

src_compile() {
	default
}

src_install() {
	emake DESTDIR="${D}" MKINSTALLDIRS="mkdir -p" install

	# install our configuration files
	keepdir /etc/apache2/vhosts.d
	keepdir /etc/apache2/modules.d

	insinto /etc/apache2
	doins -r "${FILESDIR}"/customization/conf/*
	use apache2_modules_mime_magic && doins docs/conf/magic

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/customization/scripts/apache2-logrotate apache2

	# generate a sane default APACHE2_OPTS
	APACHE2_OPTS="-D DEFAULT_VHOST -D INFO"
	use doc && APACHE2_OPTS+=" -D MANUAL"
	use ssl && APACHE2_OPTS+=" -D SSL -D SSL_DEFAULT_VHOST"
	use suexec && APACHE2_OPTS+=" -D SUEXEC"
	if has negotiation ${APACHE2_MODULES} && use apache2_modules_negotiation; then
		APACHE2_OPTS+=" -D LANGUAGE"
	fi

	newconfd "${FILESDIR}"/customization/init/apache2.confd apache2

	generate_load_module

	# Keep the layout libdir in sync with the final install
	sed -i -e "s:/usr/lib:/usr/$(get_libdir):g" \
		"${D}"/etc/conf.d/apache2 "${D}"/etc/apache2/httpd.conf \
		|| die "libdir sed failed"

	sed -i -e "s:APACHE2_OPTS=\".*\":APACHE2_OPTS=\"${APACHE2_OPTS}\":" \
		"${D}"/etc/conf.d/apache2 || die

	# install apache2ctl wrapper for our init script if available
	exeinto /usr/sbin
	doexe "${FILESDIR}"/customization/scripts/apache2ctl

	# provide legacy symlink for apxs
	dosym apxs /usr/sbin/apxs2

	# install some documentation
	dodoc "${DOCS[@]}"
	dodoc "${FILESDIR}"/customization/docs/*

	# drop in a convenient link to the manual
	if use doc ; then
		sed -i -e "s:VERSION:${PVR}:" "${ED%/}/etc/apache2/modules.d/00_apache_manual.conf"
		docompress -x /usr/share/doc/${PF}/manual
	else
		rm -f "${ED%/}/etc/apache2/modules.d/00_apache_manual.conf"
		rm -Rf "${ED%/}/usr/share/doc/${PF}/manual"
	fi

	# the default icons and error pages get stored in
	# /usr/share/apache2/{error,icons}
	dodir /usr/share/apache2
	mv -f "${ED%/}/var/www/localhost/error" "${ED%/}/usr/share/apache2/error"
	mv -f "${ED%/}/var/www/localhost/icons" "${ED%/}/usr/share/apache2/icons"
	rm -rf "${ED%/}/var/www/localhost/"
	eend $?

	# set some sane permissions for suexec
	if use suexec ; then
		local needs_adjustment="$(ver_test ${PV} -ge 2.4.34 && { { ! use suexec-syslog || ! use suexec-caps ; } && echo true || echo false ; } || echo true)"
		if ${needs_adjustment} ; then
			fowners 0:${SUEXEC_CALLER:-apache} /usr/sbin/suexec
			fperms 4710 /usr/sbin/suexec
			# provide legacy symlink for suexec
			dosym /usr/sbin/suexec /usr/sbin/suexec2
		fi
	fi

	# empty dirs
	for i in /var/lib/dav /var/log/apache2 /var/cache/apache2 ; do
		keepdir ${i}
		fowners apache:apache ${i}
		fperms 0750 ${i}
	done

	local i
	local apache_tools_prune_list=(
		/usr/bin/{htdigest,logresolve,htpasswd,htdbm,ab,httxt2dbm}
		/usr/sbin/{checkgid,fcgistarter,htcacheclean,rotatelogs}
		/usr/share/man/man1/{logresolve.1,htdbm.1,htdigest.1,htpasswd.1,dbmmanage.1,ab.1}
		/usr/share/man/man8/{rotatelogs.8,htcacheclean.8}
	)
	for i in ${apache_tools_prune_list[@]} ; do
		rm "${ED%/}"/${i} || die "Failed to prune apache-tools bits"
	done

	# install apxs in /usr/bin and put a symlink into the
	# old location until all ebuilds and eclasses have been modified to
	# use the new location.
	dobin support/apxs
	dosym ../bin/apxs /usr/sbin/apxs

	systemd_dotmpfilesd "${FILESDIR}/apache.conf"

	if use systemd ; then
		systemd_dounit "${FILESDIR}/apache2.service"
	else
		newinitd "${FILESDIR}"/customization/init/apache2.initd apache2

		# Keep the layout libdir in sync with the final install
		sed -i -e "s:/usr/lib:/usr/$(get_libdir):g" \
			"${D}"/etc/init.d/apache2 \
			|| die "libdir sed failed"
	fi

	# Fix path to apache libdir
	sed "s|@LIBDIR@|$(get_libdir)|" -i "${ED%/}"/usr/sbin/apache2ctl || die
}

pkg_postinst() {
	apache-2_pkg_postinst || die "apache-2_pkg_postinst failed"

	tmpfiles_process apache.conf

	# warnings that default config might not work out of the box
	local mod cmod
	for mod in ${MODULE_CRITICAL} ; do
		if ! use "apache2_modules_${mod}"; then
			echo
			ewarn "Warning: Critical module not installed!"
			ewarn "Modules 'authn_core', 'authz_core' and 'unixd'"
			ewarn "are highly recomended but might not be in the base profile yet."
			ewarn "Default config for ssl needs module 'socache_shmcb'."
			ewarn "Enabling the following flags is highly recommended:"
			for cmod in ${MODULE_CRITICAL} ; do
				use "apache2_modules_${cmod}" || \
					ewarn "+ apache2_modules_${cmod}"
				done
				echo
				break
		fi
	done
	# warning for proxy_balancer and missing load balancing scheduler
	if use apache2_modules_proxy_balancer; then
		local lbset=
		for mod in lbmethod_byrequests lbmethod_bytraffic lbmethod_bybusyness lbmethod_heartbeat; do
			if use "apache2_modules_${mod}"; then
				lbset=1 && break
			fi
		done
		if [ ! ${lbset} ] ; then
			echo
			ewarn "Info: Missing load balancing scheduler algorithm module"
			ewarn "(They were split off from proxy_balancer in 2.3)"
			ewarn "In order to get the ability of load balancing, at least"
			ewarn "one of these modules has to be present:"
			ewarn "lbmethod_byrequests lbmethod_bytraffic lbmethod_bybusyness lbmethod_heartbeat"
			echo
		fi
	fi
}


# vim: filetype=ebuild
