# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit ssl-cert systemd toolchain-funcs perl-module user

DESCRIPTION="Robust, small and high performance http and reverse proxy server"
HOMEPAGE="http://nginx.org"
SRC_URI="
https://github.com/nginx/nginx/releases/download/release-1.31.8/nginx-1.31.8.tar.gz -> nginx-1.31.8.tar.gz
nginx_modules_external_ndk? ( https://github.com/vision5/ngx_devel_kit/archive/v0.3.3.tar.gz -> ngx_devel_kit-0.3.3.tar.gz )
nginx_modules_external_brotli? ( https://github.com/google/ngx_brotli/archive/v1.0.0rc.tar.gz -> ngx_brotli-1.0.0rc.tar.gz )
nginx_modules_external_upload_progress? ( https://github.com/masterzen/nginx-upload-progress-module/archive/v0.9.2.tar.gz -> nginx-upload-progress-module-0.9.2.tar.gz )
nginx_modules_external_headers_more? ( https://github.com/openresty/headers-more-nginx-module/archive/v0.37.tar.gz -> headers-more-nginx-module-0.37.tar.gz )
nginx_modules_external_cache_purge? ( https://github.com/FRiCKLE/ngx_cache_purge/archive/2.3.tar.gz -> ngx_cache_purge-2.3.tar.gz )
nginx_modules_external_slowfs_cache? ( https://github.com/FRiCKLE/ngx_slowfs_cache/archive/1.10.tar.gz -> ngx_slowfs_cache-1.10.tar.gz )
nginx_modules_external_dav_ext? ( https://github.com/arut/nginx-dav-ext-module/archive/v3.0.0.tar.gz -> nginx-dav-ext-module-3.0.0.tar.gz )
nginx_modules_external_encrypted_session? ( https://github.com/openresty/encrypted-session-nginx-module/archive/5ab56cebe8771081942b85066ebad05c2017a6f3.tar.gz -> encrypted-session-nginx-module-5ab56cebe8771081942b85066ebad05c2017a6f3.tar.gz )
nginx_modules_external_fancyindex? ( https://github.com/aperezdc/ngx-fancyindex/archive/v0.5.2.tar.gz -> ngx-fancyindex-0.5.2.tar.gz )
nginx_modules_external_mogilefs? ( https://github.com/vkholodkov/nginx-mogilefs-module/archive/1.0.4.tar.gz -> nginx-mogilefs-module-1.0.4.tar.gz )
nginx_modules_external_push? ( https://github.com/slact/nchan/archive/b95f64c0f49223ebcaddb18609ac5644d41fca14.tar.gz -> nchan-b95f64c0f49223ebcaddb18609ac5644d41fca14.tar.gz )
nginx_modules_external_lua? ( https://github.com/openresty/lua-nginx-module/archive/v0.10.26.tar.gz -> lua-nginx-module-0.10.26.tar.gz )
nginx_modules_external_auth_pam? ( https://github.com/stogh/ngx_http_auth_pam_module/archive/v1.5.5.tar.gz -> ngx_http_auth_pam_module-1.5.5.tar.gz )
nginx_modules_external_upstream_check? ( https://github.com/yaoweibin/nginx_upstream_check_module/archive/87bfa66ddf16c17053ba7bbae72400c9939ecf6d.tar.gz -> nginx_upstream_check_module-87bfa66ddf16c17053ba7bbae72400c9939ecf6d.tar.gz )
nginx_modules_external_metrics? ( https://github.com/liquidm/ngx_metrics/archive/v0.1.1.tar.gz -> ngx_metrics-0.1.1.tar.gz )
nginx_modules_external_vhost_traffic_status? ( https://github.com/vozlt/nginx-module-vts/archive/v0.2.2.tar.gz -> nginx-module-vts-0.2.2.tar.gz )
nginx_modules_external_naxsi? ( https://github.com/wargio/naxsi/archive/1.6.tar.gz -> naxsi-1.6.tar.gz )
nginx_modules_external_rtmp? ( https://github.com/arut/nginx-rtmp-module/archive/v1.2.2.tar.gz -> nginx-rtmp-module-1.2.2.tar.gz )
nginx_modules_external_accept_language? ( https://github.com/giom/nginx_accept_language_module/archive/2f69842f83dac77f7d98b41a2b31b13b87aeaba7.tar.gz -> nginx_accept_language_module-2f69842f83dac77f7d98b41a2b31b13b87aeaba7.tar.gz )
nginx_modules_external_concat? ( https://github.com/alibaba/nginx-http-concat/archive/1.2.2.tar.gz -> nginx-http-concat-1.2.2.tar.gz )
nginx_modules_external_echo? ( https://github.com/openresty/echo-nginx-module/archive/v0.63.tar.gz -> echo-nginx-module-0.63.tar.gz )
nginx_modules_external_modsecurity? ( https://github.com/owasp-modsecurity/ModSecurity-nginx/archive/v1.0.3.tar.gz -> ModSecurity-nginx-1.0.3.tar.gz )
nginx_modules_external_push_stream? ( https://github.com/wandenberg/nginx-push-stream-module/archive/f858fc01e809bc87cc667e1cdd38fc35492cd2f5.tar.gz -> nginx-push-stream-module-0.5.5-2-gf858fc01.tar.gz )
nginx_modules_external_sticky? ( https://github.com/dvershinin/nginx-sticky-module-ng/archive/08a395c66e425540982c00482f55034e1fee67b6.tar.gz -> nginx-sticky-module-ng-08a395c66e425540982c00482f55034e1fee67b6.tar.gz )
nginx_modules_external_ajp? ( https://github.com/dvershinin/nginx_ajp_module/archive/v0.3.3.tar.gz -> nginx_ajp_module-0.3.3.tar.gz )
nginx_modules_external_njs? ( https://github.com/nginx/njs/archive/1.0.2.tar.gz -> njs-1.0.2.tar.gz )"
LICENSE="BSD-2"
SLOT="0"
KEYWORDS="*"
PATCHES=(
	"${FILESDIR}/patches/nginx-fix-perl-install-path.patch"
	"${FILESDIR}/patches/nginx-httpoxy-mitigation-r1.patch"
)
IUSE="+aio +http +http2 +http-cache +pcre pcre-jit +poll rtmp +select cpp_test debug full google_perftools +ipv6 libatomic luajit ssl stream systemd threads vim-syntax"
REQUIRED_USE="
full? (
    nginx_modules_http_access
    nginx_modules_http_addition
    nginx_modules_http_auth_basic
    nginx_modules_http_auth_request
    nginx_modules_http_autoindex
    nginx_modules_http_browser
    nginx_modules_http_charset
    nginx_modules_http_dav
    nginx_modules_http_degradation
    nginx_modules_http_empty_gif
    nginx_modules_http_fastcgi
    nginx_modules_http_flv
    nginx_modules_http_geo
    nginx_modules_http_geoip
    nginx_modules_http_grpc
    nginx_modules_http_gunzip
    nginx_modules_http_gzip
    nginx_modules_http_gzip_static
    nginx_modules_http_image_filter
    nginx_modules_http_limit_conn
    nginx_modules_http_limit_req
    nginx_modules_http_map
    nginx_modules_http_memcached
    nginx_modules_http_mirror
    nginx_modules_http_mp4
    nginx_modules_http_perl
    nginx_modules_http_proxy
    nginx_modules_http_random_index
    nginx_modules_http_realip
    nginx_modules_http_referer
    nginx_modules_http_rewrite
    nginx_modules_http_scgi
    nginx_modules_http_secure_link
    nginx_modules_http_split_clients
    nginx_modules_http_ssi
    nginx_modules_http_ssl
    nginx_modules_http_stub_status
    nginx_modules_http_sub
    nginx_modules_http_upstream_hash
    nginx_modules_http_upstream_ip_hash
    nginx_modules_http_upstream_keepalive
    nginx_modules_http_upstream_least_conn
    nginx_modules_http_upstream_zone
    nginx_modules_http_userid
    nginx_modules_http_uwsgi
    nginx_modules_http_xslt
    nginx_modules_mail_imap
    nginx_modules_mail_pop3
    nginx_modules_mail_smtp
    nginx_modules_stream_access
    nginx_modules_stream_geo
    nginx_modules_stream_geoip
    nginx_modules_stream_limit_conn
    nginx_modules_stream_map
    nginx_modules_stream_realip
    nginx_modules_stream_return
    nginx_modules_stream_split_clients
    nginx_modules_stream_ssl_preread
    nginx_modules_stream_upstream_hash
    nginx_modules_stream_upstream_least_conn
    nginx_modules_stream_upstream_zone
)
pcre-jit? ( pcre )
nginx_modules_http_grpc? ( http2 )
nginx_modules_external_dav_ext? ( nginx_modules_http_dav nginx_modules_http_xslt )
nginx_modules_external_encrypted_session? ( nginx_modules_external_ndk )
nginx_modules_external_lua? (
    luajit
    nginx_modules_http_rewrite
)
nginx_modules_external_metrics? ( nginx_modules_http_stub_status )
nginx_modules_external_modsecurity? ( pcre )
nginx_modules_external_naxsi? ( pcre )
nginx_modules_external_push_stream? ( ssl )"
RESTRICT="test"
RDEPEND="google_perftools? ( dev-util/google-perftools )
	http-cache? ( dev-libs/openssl:0= )
	pcre? ( dev-libs/libpcre )
	pcre-jit? ( dev-libs/libpcre[jit] )
	ssl? ( dev-libs/openssl:0= )
	http2? ( dev-libs/openssl:0= )
	nginx_modules_external_brotli? ( app-arch/brotli )
	nginx_modules_http_geoip? ( dev-libs/geoip )
	nginx_modules_http_gunzip? ( sys-libs/zlib )
	nginx_modules_http_gzip? ( sys-libs/zlib )
	nginx_modules_http_gzip_static? ( sys-libs/zlib )
	nginx_modules_http_image_filter? ( media-libs/gd[jpeg,png] )
	nginx_modules_http_perl? ( >=dev-lang/perl-5.8:= )
	nginx_modules_http_rewrite? ( dev-libs/libpcre )
	nginx_modules_http_secure_link? ( dev-libs/openssl:0= )
	nginx_modules_http_xslt? ( dev-libs/libxml2 dev-libs/libxslt )
	nginx_modules_external_lua? ( dev-lang/luajit:2= )
	nginx_modules_external_auth_pam? ( virtual/pam )
	nginx_modules_external_metrics? ( dev-libs/yajl )
	nginx_modules_external_dav_ext? ( dev-libs/libxml2 )
	nginx_modules_external_modsecurity? ( dev-libs/modsecurity )
	nginx_modules_stream_geoip? ( dev-libs/geoip )
"
DEPEND="${RDEPEND}
	arm? ( dev-libs/libatomic_ops )
	libatomic? ( dev-libs/libatomic_ops )
"
PDEPEND="vim-syntax? ( app-vim/nginx-syntax )
"
declare -A mod{_pn,_pv,_p,_wd,_lic,_doc}
declare -A mods
# encrypted_session depend on ndk.
# place ndk before modules that depend on it.
# Nginx Development Kit (NDK) (https://github.com/simpl/ngx_devel_kit)
# Must be behind encrypted_session
mod_pn["ndk"]="ngx_devel_kit"
mod_pv["ndk"]="0.3.3"
mod_p["ndk"]="${mod_pn["ndk"]}-${mod_pv["ndk"]}"
mod_wd["ndk"]="${WORKDIR}/${mod_p["ndk"]}"
mod_lic["ndk"]="BSD"
mod_doc["ndk"]="README.md README_AUTO_LIB.md"
mod_pn["brotli"]="ngx_brotli"
mod_pv["brotli"]="1.0.0rc"
mod_p["brotli"]="${mod_pn["brotli"]}-${mod_pv["brotli"]}"
mod_wd["brotli"]="${WORKDIR}/${mod_p["brotli"]}"
mod_lic["brotli"]="BSD-2"
mod_doc["brotli"]="README.md"
# Upload Progress (https://github.com/masterzen/nginx-upload-progress-module)
mod_pn["upload_progress"]="nginx-upload-progress-module"
mod_pv["upload_progress"]="0.9.2"
mod_p["upload_progress"]="${mod_pn["upload_progress"]}-${mod_pv["upload_progress"]}"
mod_wd["upload_progress"]="${WORKDIR}/${mod_p["upload_progress"]}"
mod_lic["upload_progress"]="BSD-2"
mod_doc["upload_progress"]="README CHANGES"
# http_headers_more (https://github.com/openresty/headers-more-nginx-module, BSD license)
mod_pn["headers_more"]="headers-more-nginx-module"
mod_pv["headers_more"]="0.37"
mod_p["headers_more"]="${mod_pn["headers_more"]}-${mod_pv["headers_more"]}"
mod_wd["headers_more"]="${WORKDIR}/${mod_p["headers_more"]}"
mod_lic["headers_more"]="BSD"
# Cache Purge (http://labs.frickle.com/nginx_ngx_cache_purge)
mod_pn["cache_purge"]="ngx_cache_purge"
mod_pv["cache_purge"]="2.3"
mod_p["cache_purge"]="${mod_pn["cache_purge"]}-${mod_pv["cache_purge"]}"
mod_wd["cache_purge"]="${WORKDIR}/${mod_p["cache_purge"]}"
mod_lic["cache_purge"]="BSD-2"
mod_doc["cache_purge"]="README.md CHANGES TODO.md"
# SlowFS Cache (http://labs.frickle.com/nginx_ngx_slowfs_cache)
mod_pn["slowfs_cache"]="ngx_slowfs_cache"
mod_pv["slowfs_cache"]="1.10"
mod_p["slowfs_cache"]="${mod_pn["slowfs_cache"]}-${mod_pv["slowfs_cache"]}"
mod_wd["slowfs_cache"]="${WORKDIR}/${mod_p["slowfs_cache"]}"
mod_lic["slowfs_cache"]="BSD-2"
mod_doc["slowfs_cache"]="README.md CHANGES"
# Dav Ext (https://github.com/arut/nginx-dav-ext-module)
mod_pn["dav_ext"]="nginx-dav-ext-module"
mod_pv["dav_ext"]="3.0.0"
mod_p["dav_ext"]="${mod_pn["dav_ext"]}-${mod_pv["dav_ext"]}"
mod_wd["dav_ext"]="${WORKDIR}/${mod_p["dav_ext"]}"
mod_lic["dav_ext"]="BSD-2"
mod_doc["dav_ext"]="README.rst"
# Encrypted Session (https://github.com/openresty/encrypted-session-nginx-module)
mod_pn["encrypted_session"]="encrypted-session-nginx-module"
mod_pv["encrypted_session"]="5ab56cebe8771081942b85066ebad05c2017a6f3"
mod_p["encrypted_session"]="${mod_pn["encrypted_session"]}-${mod_pv["encrypted_session"]}"
mod_wd["encrypted_session"]="${WORKDIR}/${mod_p["encrypted_session"]}"
mod_lic["encrypted_session"]="BSD-2"
# Fancy Index (https://github.com/aperezdc/ngx-fancyindex)
mod_pn["fancyindex"]="ngx-fancyindex"
mod_pv["fancyindex"]="0.5.2"
mod_p["fancyindex"]="${mod_pn["fancyindex"]}-${mod_pv["fancyindex"]}"
mod_wd["fancyindex"]="${WORKDIR}/${mod_p["fancyindex"]}"
mod_lic["fancyindex"]="BSD-2"
mod_doc["fancyindex"]="README.rst HACKING.md CHANGELOG.md"
# MogileFS Client (http://www.grid.net.ru/nginx/mogilefs.en.html)
mod_pn["mogilefs"]="nginx-mogilefs-module"
mod_pv["mogilefs"]="1.0.4"
mod_p["mogilefs"]="${mod_pn["mogilefs"]}-${mod_pv["mogilefs"]}"
mod_wd["mogilefs"]="${WORKDIR}/${mod_p["mogilefs"]}"
mod_lic["mogilefs"]="BSD"
mod_doc["mogilefs"]="README Changelog"
# Push (https://nchan.io/)
mod_pn["push"]="nchan"
mod_pv["push"]="b95f64c0f49223ebcaddb18609ac5644d41fca14"
mod_p["push"]="${mod_pn["push"]}-${mod_pv["push"]}"
mod_wd["push"]="${WORKDIR}/${mod_p["push"]}"
mod_lic["push"]="MIT"
mod_doc["push"]="README.md changelog.txt"
# Lua (https://github.com/openresty/lua-nginx-module)
mod_pn["lua"]="lua-nginx-module"
mod_pv["lua"]="0.10.26"
mod_p["lua"]="${mod_pn["lua"]}-${mod_pv["lua"]}"
mod_wd["lua"]="${WORKDIR}/${mod_p["lua"]}"
mod_lic["lua"]="BSD-2"
mod_doc["lua"]="README.markdown doc/HttpLuaModule.wiki"
# Auth PAM (https://github.com/sto/ngx_http_auth_pam_module)
mod_pn["auth_pam"]="ngx_http_auth_pam_module"
mod_pv["auth_pam"]="1.5.5"
mod_p["auth_pam"]="${mod_pn["auth_pam"]}-${mod_pv["auth_pam"]}"
mod_wd["auth_pam"]="${WORKDIR}/${mod_p["auth_pam"]}"
mod_lic["auth_pam"]="BSD-2"
mod_doc["auth_pam"]="README.md ChangeLog"
# Upstream Check (https://github.com/yaoweibin/nginx_upstream_check_module)
mod_pn["upstream_check"]="nginx_upstream_check_module"
mod_pv["upstream_check"]="87bfa66ddf16c17053ba7bbae72400c9939ecf6d"
mod_p["upstream_check"]="${mod_pn["upstream_check"]}-${mod_pv["upstream_check"]}"
mod_wd["upstream_check"]="${WORKDIR}/${mod_p["upstream_check"]}"
mod_lic["upstream_check"]="BSD-2"
mod_doc["upstream_check"]="README CHANGES"
# Metrics (https://github.com/liquidm/ngx_metrics)
mod_pn["metrics"]="ngx_metrics"
mod_pv["metrics"]="0.1.1"
mod_p["metrics"]="${mod_pn["metrics"]}-${mod_pv["metrics"]}"
mod_wd["metrics"]="${WORKDIR}/${mod_p["metrics"]}"
mod_lic["metrics"]="BSD-2"
mod_doc["metrics"]="README.md"
# http_vhost_traffic_status (https://github.com/vozlt/nginx-module-vts, BSD license)
mod_pn["vhost_traffic_status"]="nginx-module-vts"
mod_pv["vhost_traffic_status"]="0.2.2"
mod_p["vhost_traffic_status"]="${mod_pn["vhost_traffic_status"]}-${mod_pv["vhost_traffic_status"]}"
mod_wd["vhost_traffic_status"]="${WORKDIR}/${mod_p["vhost_traffic_status"]}"
mod_lic["vhost_traffic_status"]="BSD"
mod_doc["vhost_traffic_status"]="README.md"
# NAXSI (https://github.com/wargio/naxsi)
mod_pn["naxsi"]="naxsi"
mod_pv["naxsi"]="1.6"
mod_p["naxsi"]="${mod_pn["naxsi"]}-${mod_pv["naxsi"]}"
mod_wd["naxsi"]="${WORKDIR}/${mod_p["naxsi"]}/naxsi_src"
mod_lic["naxsi"]="GPL-3+"
mod_doc["naxsi"]="README.md"
# RTMP (http://github.com/arut/nginx-rtmp-module)
mod_pn["rtmp"]="nginx-rtmp-module"
mod_pv["rtmp"]="1.2.2"
mod_p["rtmp"]="${mod_pn["rtmp"]}-${mod_pv["rtmp"]}"
mod_wd["rtmp"]="${WORKDIR}/${mod_p["rtmp"]}"
mod_lic["rtmp"]="BSD-2"
mod_doc["rtmp"]="README.md AUTHORS"
# Accept Language (https://github.com/giom/nginx_accept_language_module)
mod_pn["accept_language"]="nginx_accept_language_module"
mod_pv["accept_language"]="2f69842f83dac77f7d98b41a2b31b13b87aeaba7"
mod_p["accept_language"]="${mod_pn["accept_language"]}-${mod_pv["accept_language"]}"
mod_wd["accept_language"]="${WORKDIR}/${mod_p["accept_language"]}"
mod_lic["accept_language"]="BSD-2"
mod_doc["accept_language"]="README.textile"
# Concat (https://github.com/alibaba/nginx-http-concat)
mod_pn["concat"]="nginx-http-concat"
mod_pv["concat"]="1.2.2"
mod_p["concat"]="${mod_pn["concat"]}-${mod_pv["concat"]}"
mod_wd["concat"]="${WORKDIR}/${mod_p["concat"]}"
mod_lic["concat"]="BSD-2"
mod_doc["concat"]="README.md"
# Echo (https://github.com/openresty/echo-nginx-module)
mod_pn["echo"]="echo-nginx-module"
mod_pv["echo"]="0.63"
mod_p["echo"]="${mod_pn["echo"]}-${mod_pv["echo"]}"
mod_wd["echo"]="${WORKDIR}/${mod_p["echo"]}"
mod_lic["echo"]="BSD-2"
# modsecurity for nginx (https://github.com/SpiderLabs/ModSecurity-nginx, https://github.com/SpiderLabs/ModSecurity, Apache-2.0)
mod_pn["modsecurity"]="ModSecurity-nginx"
mod_pv["modsecurity"]="1.0.3"
mod_p["modsecurity"]="${mod_pn["modsecurity"]}-${mod_pv["modsecurity"]}"
mod_wd["modsecurity"]="${WORKDIR}/${mod_p["modsecurity"]}"
mod_lic["modsecurity"]="Apache-2.0"
mod_doc["modsecurity"]="README.md CHANGES"
# Push Stream (https://github.com/wandenberg/nginx-push-stream-module)
mod_pn["push_stream"]="nginx-push-stream-module"
mod_pv["push_stream"]="0.5.5-2-gf858fc01"
mod_p["push_stream"]="${mod_pn["push_stream"]}-${mod_pv["push_stream"]}"
mod_wd["push_stream"]="${WORKDIR}/nginx-push-stream-module-f858fc01e809bc87cc667e1cdd38fc35492cd2f5"
mod_lic["push_stream"]="GPL-3"
mod_doc["push_stream"]="README.textile CHANGELOG.textile AUTHORS"
# Sticky (https://github.com/dvershinin/nginx-sticky-module-ng,
# same pinned commit as the retired bitbucket tarball)
mod_pn["sticky"]="nginx-sticky-module-ng"
mod_pv["sticky"]="08a395c66e425540982c00482f55034e1fee67b6"
mod_p["sticky"]="${mod_pn["sticky"]}-${mod_pv["sticky"]}"
mod_wd["sticky"]="${WORKDIR}/${mod_p["sticky"]}"
mod_lic["sticky"]="BSD-2"
mod_doc["sticky"]="README.md Changelog.txt"
# AJP (https://github.com/dvershinin/nginx_ajp_module)
mod_pn["ajp"]="nginx_ajp_module"
mod_pv["ajp"]="0.3.3"
mod_p["ajp"]="${mod_pn["ajp"]}-${mod_pv["ajp"]}"
mod_wd["ajp"]="${WORKDIR}/${mod_p["ajp"]}"
mod_lic["ajp"]="BSD-2"
mod_doc["ajp"]="README"
# njs-module (https://github.com/nginx/njs, as-is)
mod_pn["njs"]="njs"
mod_pv["njs"]="1.0.2"
mod_p["njs"]="${mod_pn["njs"]}-${mod_pv["njs"]}"
mod_wd["njs"]="${WORKDIR}/${mod_p["njs"]}"
mod_lic["njs"]="as-is"
mod_doc["njs"]="README.md CHANGES"

for m in ${!mod_pn[@]} ; do
	LICENSE+=" nginx_modules_external_${m}? ( ${mod_lic[$m]} )"
done

mods[standard]="access auth_basic autoindex browser charset empty_gif fastcgi
	geo  grpc gzip limit_conn limit_req map memcached mirror
	proxy referer rewrite scgi ssi split_clients userid uwsgi"

mods[upstream]="upstream_hash upstream_ip_hash upstream_keepalive upstream_least_conn upstream_zone"

mods[optional]="addition auth_request dav degradation flv geoip gunzip
	gzip_static image_filter mp4 perl random_index realip secure_link
	ssl stub_status sub xslt"

mods[standard_stream]="access geo limit_conn map return split_clients upstream_hash upstream_least_conn upstream_zone"

mods[optional_stream]="geoip realip ssl_preread"

mods[mail]="imap pop3 smtp"

mods[dynamic]="xslt image_filter geoip perl mail stream stream_geoip"

for m in ${mods[upstream]} ; do
	IUSE+=" +nginx_modules_http_${m}" ; done

for m in ${mods[standard]} ; do
	IUSE+=" +nginx_modules_http_${m}" ; done

for m in ${mods[standard_stream]} ; do
	IUSE+=" +nginx_modules_stream_${m}" ; done

for m in ${mods[optional]} ; do
	IUSE+=" nginx_modules_http_${m}" ; done

for m in ${mods[optional_stream]} ; do
	IUSE+=" nginx_modules_stream_${m}" ; done

for m in ${mods[mail]} ; do
	IUSE+=" nginx_modules_mail_${m}" ; done

for m in ${mods[dynamic]} ; do
		IUSE+=" nginx_modules_dynamic_${m}" ; done

for m in ${!mod_pn[@]} ; do
	IUSE+=" nginx_modules_external_${m}" ; done

pkg_setup() {

	NGINX_HOME="/var/lib/${PN}"
	NGINX_HOME_TMP="${NGINX_HOME}/tmp"

	if egetent group ${PN} > /dev/null ; then
		elog "${PN} group already exist."
		elog "group creation step skipped."
	else
		# static uid/gid: macaroni-commons packages/entities/groups.yaml
		enewgroup  ${PN} 82 > /dev/null
		elog "${PN} group created by portage."
	fi

	if egetent passwd  ${PN} > /dev/null ; then
		elog "${PN} user already exist."
		elog "user creation step skipped."
	else
		enewuser ${PN} 82 -1 /dev/null \
			${PN} > /dev/null
		elog "${PN} service user"
		elog "was created by portage."
	fi

	if use libatomic ; then
		ewarn "GCC 4.1+ features built-in atomic operations."
		ewarn "Using libatomic_ops is only needed if using"
		ewarn "a different compiler or a GCC prior to 4.1"
	fi

	if [[ -n $NGINX_ADD_MODULES ]] ; then
		ewarn "You are building custom modules via \$NGINX_ADD_MODULES!"
		ewarn "This nginx installation is not supported!"
		ewarn "Make sure you can reproduce the bug without those modules"
		ewarn "_before_ reporting bugs."
	fi

	if ! use http ; then
		ewarn "To actually disable all http-functionality you also have"
		ewarn "to disable all nginx http modules."
	fi

	if use nginx_modules_external_mogilefs && use threads; then
		eerror "mogilefs won't compile with threads support."
		eerror "Please disable either flag and try again."
		die "Can't compile mogilefs with threads support"
	fi
}

src_prepare() {

	# PATCHES (spec patches:) and user patches via default
	default

	if use nginx_modules_external_upstream_check; then
		eapply "${FILESDIR}/patches/upstream-check-plus-stream.patch"
	fi

	if use nginx_modules_external_njs; then
		cd "${mod_wd[njs]}" || die
		sed -e 's/-Werror//g' -i auto/cc || die
		cd "${S}" || die
	fi

	if use nginx_modules_external_naxsi; then
		cd "${WORKDIR}/${mod_p[naxsi]}"
		eapply "${FILESDIR}/patches/naxsi_1.21_pcre2.patch"
		cd "${S}" || die
	fi

	if use nginx_modules_external_brotli; then
		cd "${WORKDIR}/${mod_p[brotli]}"
		eapply "${FILESDIR}/patches/http_brotli-detect-brotli-r3.patch"
		cd "${S}" || die
	fi

	if use nginx_modules_external_cache_purge; then
		cd "${WORKDIR}/${mod_p[cache_purge]}"
		eapply "${FILESDIR}/patches/http_cache_purge-1.11.6+.patch"
		cd "${S}" || die

	fi

	if use nginx_modules_external_upload_progress; then
		cd "${WORKDIR}/${mod_p[upload_progress]}"
		eapply "${FILESDIR}/patches/http_uploadprogress-issue_50-r1.patch"
		cd "${S}" || die

	fi

	if use nginx_modules_external_sticky; then
		cd "${WORKDIR}/${mod_p[sticky]}"
		eapply "${FILESDIR}"/patches/http_sticky-nginx-1.23.0.patch
		cd "${S}" || die
	fi

	if use nginx_modules_external_upload_progress; then
		cd "${WORKDIR}/${mod_p[upload_progress]}"
		eapply "${FILESDIR}"/patches/http_uploadprogress-nginx-1.23.0.patch
		cd "${S}" || die
	fi

	find auto/ -type f -print0 | xargs -0 sed -i 's:\&\& make:\&\& \\$(MAKE):' || die
	# We have config protection, don't rename etc files
	sed -i 's;.default;;' auto/install || die
	# remove useless files

	sed -e '/koi-/d' -e '/win-/d' -i "${S}/auto/install" || die

	# Don't install to /etc/nginx/ if not in use
	local m
	for m in fastcgi scgi uwsgi ; do
		if ! use nginx_modules_http_${m} ; then
			sed -e "/${m}/d" -i "${S}/auto/install" || die
		fi
	done

	eapply_user
}

src_configure() {
	cd "${S}"

	local nginx_configure= http_enabled= mail_enabled= stream_enabled= WITHOUT_IPV6=

	use aio                && nginx_configure+=" --with-file-aio"
	use cpp_test           && nginx_configure+=" --with-cpp_test_module"
	use debug              && nginx_configure+=" --with-debug"
	use google_perftools   && nginx_configure+=" --with-google_perftools_module"
	use http2              && nginx_configure+=" --with-http_v2_module"
	use libatomic          && nginx_configure+=" --with-libatomic"
	use pcre               && nginx_configure+=" --with-pcre"
	use pcre-jit           && nginx_configure+=" --with-pcre-jit"
	use threads            && nginx_configure+=" --with-threads"

	if ! use ipv6; then
		WITHOUT_IPV6=" -DNGX_HAVE_INET6=0"
	fi

	for m in ${mods[upstream]}; do
		use nginx_modules_http_${m} && http_enabled=1 || nginx_configure+=" --without-http_${m}_module"
	done

	for m in ${mods[standard]}; do
		use nginx_modules_http_${m} && http_enabled=1 || nginx_configure+=" --without-http_${m}_module"
	done

	for m in ${mods[standard_stream]}; do
		use nginx_modules_stream_${m} && stream_enabled=1 && nginx_configure+=" --without-stream_${m}_module"
	done

	for m in ${mods[optional]}; do
		use nginx_modules_http_${m} && http_enabled=1 && nginx_configure+=" --with-http_${m}_module"
	done

	for m in ${mods[optional_stream]}; do
		use nginx_modules_stream_${m} && stream_enabled=1 && nginx_configure+=" --with-stream_${m}_module"
	done

	# enable dynamic ngx_http_geoip_module
	use nginx_modules_dynamic_geoip && nginx_configure+=" --with-http_geoip_module=dynamic"

	# enable dynamic ngx_http_image_filter_module
	use nginx_modules_dynamic_image_filter && nginx_configure+=" --with-http_image_filter_module=dynamic"

	# enable dynamic POP3/IMAP4/SMTP proxy module
	use nginx_modules_dynamic_mail && nginx_configure+=" --with-mail=dynamic"

	# enable dynamic TCP/UDP proxy module
	use nginx_modules_dynamic_stream && nginx_configure+=" --with-stream=dynamic"

	# enable dynamic ngx_stream_geoip_module
	use nginx_modules_dynamic_stream_geoip && nginx_configure+=" --with-stream_geoip_module=dynamic"

	# enable dynamic ngx_http_xslt_module
	use nginx_modules_dynamic_xslt && nginx_configure+=" --with-http_xslt_module=dynamic"

	use nginx_modules_external_ndk && http_enabled=1 && nginx_configure+=" --add-module=${mod_wd['ndk']}"

	for m in ${!mod_pn[@]} ; do
		[[ $m == "ndk" ]] && continue
		[[ $m == "njs" ]] && continue
		use nginx_modules_external_${m} && http_enabled=1 && nginx_configure+=" --add-module=${mod_wd[$m]}"
	done

	use nginx_modules_external_njs && http_enabled=1 && nginx_configure+=" --add-module=${mod_wd['njs']}/nginx"

	if use nginx_modules_external_lua ; then
		http_enabled=1
		export LUAJIT_LIB="$(pkg-config --variable libdir luajit)"
		export LUAJIT_INC="$(pkg-config --variable includedir luajit)"
	fi

	if use http || use http-cache || use http2; then
		http_enabled=1
	fi

	if [[ $http_enabled ]] ; then
		use http-cache || nginx_configure+=" --without-http-cache"
		use ssl && nginx_configure+=" --with-http_ssl_module"
	else
		nginx_configure+=" --without-http --without-http-cache"
	fi

	if use stream ; then
		stream_enabled=1
	fi

	if [[ $stream_enabled ]] ; then
		nginx_configure+=" --with-stream"
		use ssl && nginx_configure+=" --with-stream_ssl_module"
	fi

	for m in ${mods[mail]} ; do
		use nginx_modules_mail_${m} && \
			mail_enabled=1 || \
			nginx_configure+=" --without-mail_${m}_module"
	done

	if [[ -n "${mail_enabled}" ]] ; then
		nginx_configure+=" --with-mail"
		use ssl && nginx_configure+=" --with-mail_ssl_module"
	fi

	for mod in $NGINX_ADD_MODULES; do
		nginx_configure+=" --add-module=${mod}"
	done

	export LANG=C LC_ALL=C
	tc-export CC

	nginx_configure+=" --user=${PN} --group=${PN}"

	./configure \
		--prefix="/usr" \
		--conf-path="/etc/${PN}/${PN}.conf" \
		--error-log-path="/var/log/${PN}/error_log" \
		--pid-path="/run/${PN}.pid" \
		--lock-path="/run/lock/${PN}.lock" \
		--with-cc-opt="-I/usr/include${WITHOUT_IPV6}" \
		--with-ld-opt="-L/usr/$(get_libdir)" \
		--http-log-path="/var/log/${PN}/access_log" \
		--http-client-body-temp-path="${NGINX_HOME_TMP}/client" \
		--http-proxy-temp-path="${NGINX_HOME_TMP}/proxy" \
		--http-fastcgi-temp-path="${NGINX_HOME_TMP}/fastcgi" \
		--http-scgi-temp-path="${NGINX_HOME_TMP}/scgi" \
		--http-uwsgi-temp-path="${NGINX_HOME_TMP}/uwsgi" \
		$(use_with poll poll_module) \
		$(use_with select select_module) \
		--with-compat \
		${nginx_configure} || die "configure failed"

	# Cosmetic: keeps nginx -V output short and readable.
	sed -e "s;${WORKDIR};external_module;g" -i "${S}/objs/ngx_auto_config.h" || die
}

src_compile() {
	export LANG=C LC_ALL=C
	emake LINK="${CC} ${LDFLAGS}" OTHERLDFLAGS="${LDFLAGS}"
}

src_install() {
	emake DESTDIR="${ED}" install

	insinto "/etc/${PN}"
	doins "${FILESDIR}/${PN}.conf"

	if use systemd ; then
		systemd_dounit "${FILESDIR}/${PN}.service"
	else
		newinitd "${FILESDIR}/${PN}.initd" "${PN}"
	fi
	newconfd "${FILESDIR}"/${PN}.confd "${PN}"

	keepdir "/etc/${PN}"/sites-{available,enabled}
	insinto "/etc/${PN}/sites-available"
	doins "${FILESDIR}/sites-available/localhost"

	dodir "/usr/share/nginx/html"
	insinto "/usr/share/nginx/html"
	doins "${FILESDIR}/example/index.html"
	doins "${FILESDIR}/example/nginx-logo.png"
	doins "${FILESDIR}/example/powered-by-macaronios.png"

	keepdir "/etc/${PN}"/conf.d
	insinto "/etc/${PN}/conf.d"
	doins "${FILESDIR}/conf.d/cis.conf"
	doins "${FILESDIR}/conf.d/default.conf"

	doman "${S}/man/nginx.8"

	# just keepdir. do not copy the default htdocs files (bug #449136)
	keepdir "/var/www/localhost"
	rm -r "${ED}/usr/html" || die
	# set up a list of directories to keep

	local keepdir_list="${NGINX_HOME_TMP}/client"
	local m
	for m in proxy fastcgi scgi uwsgi; do
		use nginx_modules_http_${m} && keepdir_list+=" ${NGINX_HOME_TMP}/${m}"
	done

	keepdir /var/log/nginx ${keepdir_list}

	# this solves a problem with SELinux where nginx doesn't see the directories
	# as root and tries to create them as nginx
	fperms 0750 "${NGINX_HOME_TMP}"
	fowners ${PN}:0 "${NGINX_HOME_TMP}"

	fperms 0700 ${keepdir_list}
	fowners ${PN}:${PN} ${keepdir_list}

	fperms 0750 /var/log/nginx
	fowners 0:${PN} /var/log/nginx
	# logrotate
	insinto /etc/logrotate.d
	newins "${FILESDIR}/${PN}.logrotate" "${PN}"
	keepdir_list+=" /var/log/${PN}"

	# Don't create /run
	rm -rf "${ED%/}"/run || die

	if use nginx_modules_http_perl ; then
		cd "${S}/objs/src/http/modules/perl"
		emake DESTDIR="${ED}" INSTALLDIRS=vendor install
		perl_delete_localpod
	fi

	for m in ${!mod_pn[@]} ; do
	if use nginx_modules_external_${m} ; then
		docinto "${mod_p[$m]}"
		for d in ${mod_doc[$m]} ; do
			dodoc ${mod_wd[$m]}/${d} ; done
	fi
	done
}

pkg_preinst() {
	if [[ ! -d "/etc/${PN}/sites-available" ]] ; then
		first_install=yes
	else
		first_install=no
	fi
}

pkg_postinst() {
	if [[ "${first_install}" = "yes" ]] && \
		[[ ! -e "/etc/${PN}/sites-enabled/localhost" ]] ; then
			einfo "Enabling example Web site (see http://127.0.0.1)"
			ln -s "../sites-available/localhost" \
			"/etc/${PN}/sites-enabled/localhost" || \
			die
	fi

	if use ssl; then
		if [[ ! -f /etc/ssl/${PN}/${PN}.key ]]; then
			install_cert /etc/ssl/${PN}/${PN}
			chown ${PN}:${PN} /etc/ssl/${PN}/${PN}.{crt,csr,key,pem}
		fi
	fi

	einfo "If nginx complains about insufficient number of open files at"
	einfo "start, ensure that you have a correct /etc/security/limits.conf"
	einfo "and then do relogin to your system to ensure that the new max"
	einfo "open file limits are active. Then try restarting nginx again."

	# If the nginx user can't change into or read the dir, display a warning.
	# If su is not available we display the warning nevertheless since
	# we can't check properly
	su -s /bin/sh -c "cd /var/log/${PN} && ls" ${PN} >&/dev/null
	if [[ $? -ne 0 ]] ; then
		ewarn "Please make sure that the (${PN}) user"
		ewarn "or (${PN}) group has"
		ewarn "at least 'rx' permissions (default on fresh install)"
		ewarn "on /var/log/${PN} directory."
		ewarn "Otherwise you end up with empty log files"
		ewarn "after a logrotate."
		# Contrary to this warning, it was not the default for <nginx-1.19.4-r2
		ewarn "Attempting to fix permissions automatically:"
		ewarn "Changing group ownership to ${PN} and adding 'rx' to group."
		chown :${PN} /var/log/${PN}
		chmod g+rx /var/log/${PN}
	fi
}

# vim: filetype=ebuild
