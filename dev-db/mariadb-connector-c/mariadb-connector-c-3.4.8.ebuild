# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit cmake toolchain-funcs

DESCRIPTION="C client library for MariaDB/MySQL"
HOMEPAGE="https://mariadb.org/"
SRC_URI="https://archive.mariadb.org/connector-c-3.4.8/mariadb-connector-c-3.4.8-src.tar.gz -> mariadb-connector-c-3.4.8.tar.gz"
LICENSE="LGPL-2.1+"
SLOT="0/3"
KEYWORDS="*"
PATCHES=(
	"${FILESDIR}/mariadb-connector-c-3.1.3-fix-pkconfig-file.patch"
)
IUSE="+curl gnutls kerberos +ssl static-libs
"
RDEPEND="sys-libs/zlib:=
	virtual/libiconv:=
	curl? ( net-misc/curl:= )
	kerberos? (
	  || (
	    app-crypt/mit-krb5
	    app-crypt/heimdal
	  )
	)
	ssl? (
	  gnutls? ( net-libs/gnutls:= )
	  !gnutls? ( dev-libs/openssl:= )
	)
	
"
DEPEND="${RDEPEND}
"
S="${WORKDIR}/mariadb-connector-c-3.4.8-src"
src_prepare() {
	cmake_src_prepare
	sed -i -e 's|DESTINATION "bin"|DESTINATION ${INSTALL_BINDIR}|g' \
	  mariadb_config/CMakeLists.txt
}
src_configure() {
	tc-ld-disable-gold
	local mycmakeargs=(
	  -DWITH_EXTERNAL_ZLIB=ON
	  -DWITH_SSL:STRING=$(usex ssl $(usex gnutls GNUTLS OPENSSL) OFF)
	  -DWITH_CURL=$(usex curl ON OFF)
	  -DWITH_ICONV=ON
	  -DCLIENT_PLUGIN_AUTH_GSSAPI_CLIENT:STRING=$(usex kerberos DYNAMIC OFF)
	  -DMARIADB_UNIX_ADDR="/var/run/mysqld/mysqld.sock"
	  -DINSTALL_LIBDIR="$(get_libdir)"
	  -DINSTALL_PCDIR="$(get_libdir)/pkgconfig"
	  -DINSTALL_PLUGINDIR="$(get_libdir)/mariadb/plugin"
	  -DINSTALL_BINDIR=bin
	  -DWITH_UNIT_TESTS=OFF
	)
	cmake_src_configure
}
src_install() {
	cmake_src_install
	# Plugin available on mariadb
	rm -v "${ED}"/usr/$(get_libdir)/mariadb/plugin/zstd.so
	if ! use static-libs ; then
	  find "${ED}" -name "*.a" -delete || die
	fi
}


# vim: filetype=ebuild
