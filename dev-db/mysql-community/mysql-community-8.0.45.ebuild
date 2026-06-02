# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
CMAKE_BUILD_TYPE="RelWithDebInfo"
CMAKE_MAKEFILE_GENERATOR=emake
inherit cmake flag-o-matic toolchain-funcs user

DESCRIPTION="A fast, multi-threaded, multi-user SQL database server"
HOMEPAGE="https://www.mysql.com/"
SRC_URI="https://cdn.mysql.com/archives/mysql-8.0/mysql-boost-8.0.45.tar.gz -> mysql-community-8.0.45.tar.gz"
LICENSE="GPL-2"
SLOT="8.0"
KEYWORDS="*"
IUSE="cjk cracklib debug jemalloc latin1 numa +perl profiling router +server tcmalloc"
REQUIRED_USE="?? ( tcmalloc jemalloc )
cjk? ( server )
jemalloc? ( server )
numa? ( server )
profiling? ( server )
router? ( server )
tcmalloc? ( server )
"
# Commons depends
CDEPEND="app-arch/lz4:=
	app-arch/zstd:=
	sys-libs/ncurses:=
	sys-libs/zlib:=
	dev-libs/openssl:=
	server? (
	  dev-libs/icu:=
	  dev-libs/libevent:=[ssl,threads]
	  dev-libs/protobuf:=
	  net-libs/libtirpc:=
	  cjk? ( app-text/mecab:= )
	  jemalloc? ( dev-libs/jemalloc:= )
	  dev-libs/libaio:=
	  sys-process/procps:=
	  numa? ( sys-process/numactl )
	  tcmalloc? ( dev-util/google-perftools:= )
	)
	
"
RDEPEND="${CDEPEND}
	!dev-db/mariadb
	dev-db/mysql-init-scripts
	
"
DEPEND="${CDEPEND}
	sys-devel/gcc
	virtual/yacc
	server? ( net-libs/rpcsvc-proto )
	
"
PDEPEND="perl? ( dev-perl/DBD-mysql )
	
"
S="${WORKDIR}/mysql-8.0.45"

post_src_unpack() {
	mv mysql-mysql-server-* ${S}
}


mysql_init_vars() {
	: ${MY_SHAREDSTATEDIR="${EPREFIX}/usr/share/mysql"}
	: ${MY_SYSCONFDIR="${EPREFIX}/etc/mysql"}
	: ${MY_LOCALSTATEDIR="${EPREFIX}/var/lib/mysql"}
	: ${MY_LOGDIR="${EPREFIX}/var/log/mysql"}
	MY_DATADIR="${MY_LOCALSTATEDIR}"
	export MY_SHAREDSTATEDIR MY_SYSCONFDIR
	export MY_LOCALSTATEDIR MY_LOGDIR
	export MY_DATADIR
}
pkg_setup() {
	enewgroup mysql 60 || die "problem adding 'mysql' group"
	enewuser mysql 60 -1 /dev/null mysql || die "problem adding 'mysql' user"
}
src_prepare() {
	# Avoid rpm call which would trigger sandbox, #692368
	sed -i \
	  -e 's/MY_RPM rpm/MY_RPM rpmNOTEXISTENT/' \
	  CMakeLists.txt || die
	# Remove the centos and rhel selinux policies to support mysqld_safe under SELinux
	if [[ -d "${S}/support-files/SELinux" ]] ; then
	  echo > "${S}/support-files/SELinux/CMakeLists.txt" || die
	fi
	cmake_src_prepare
}
src_configure() {
	# Bug #114895, bug #110149
	filter-flags "-O" "-O[01]"
	append-cxxflags -felide-constructors
	append-cxxflags -std=c++17
	append-flags -fno-strict-aliasing
	mycmakeargs=(
	  -DCMAKE_C_FLAGS_RELWITHDEBINFO="$(usex debug '' '-DNDEBUG')"
	  -DCMAKE_CXX_FLAGS_RELWITHDEBINFO="$(usex debug '' '-DNDEBUG')"
	  -DMYSQL_DATADIR="/var/lib/mysql"
	  -DSYSCONFDIR="/etc/mysql"
	  -DINSTALL_BINDIR=bin
	  -DINSTALL_DOCDIR=share/doc/${PF}
	  -DINSTALL_DOCREADMEDIR=share/doc/${PF}
	  -DINSTALL_INCLUDEDIR=include/mysql
	  -DINSTALL_INFODIR=share/info
	  -DINSTALL_LIBDIR=$(get_libdir)
	  -DINSTALL_MANDIR=share/man
	  -DINSTALL_MYSQLSHAREDIR=share/mysql
	  -DINSTALL_PLUGINDIR=$(get_libdir)/mysql/plugin
	  -DINSTALL_MYSQLDATADIR="/var/lib/mysql"
	  -DINSTALL_SBINDIR=sbin
	  -DINSTALL_SUPPORTFILESDIR="/usr/share/mysql"
	  -DCOMPILATION_COMMENT="MacaroniOS Linux mysql-community-8.0.45"
	  -DWITH_UNIT_TESTS=OFF
	  -DWITH_EDITLINE=bundled
	  -DWITH_ZLIB=system
	  -DWITH_SSL=system
	  -DWITH_LIBWRAP=0
	  -DENABLED_LOCAL_INFILE=1
	  -DMYSQL_UNIX_ADDR="/var/run/mysqld/mysqld.sock"
	  -DWITH_DEFAULT_COMPILER_OPTIONS=0
	  -DSTACK_DIRECTION=$(tc-stack-grows-down && echo -1 || echo 1)
	  -DCMAKE_POSITION_INDEPENDENT_CODE=ON
	  -DWITH_CURL=system
	  -DWITH_BOOST="${S}/boost"
	  -DWITH_ROUTER=$(usex router ON OFF)
	)
	if is-flagq -fno-lto ; then
	  einfo "LTO disabled via {C,CXX,F,FC}FLAGS"
	  mycmakeargs+=( -DWITH_LTO=OFF )
	elif is-flagq -flto ; then
	  einfo "LTO forced via {C,CXX,F,FC}FLAGS"
	  myconf+=( -DWITH_LTO=ON )
	else
	  myconf+=( -DWITH_LTO=OFF )
	fi
	mycmakeargs+=( -DINSTALL_MYSQLTESTDIR='' )
	mycmakeargs+=(
	  -DWITH_ICU=system
	  -DWITH_LZ4=system
	  -DWITH_RAPIDJSON=bundled
	  -DWITH_ZSTD=system
	)
	if [[ -n "${MYSQL_DEFAULT_CHARSET}" && -n "${MYSQL_DEFAULT_COLLATION}" ]] ; then
	  ewarn "You are using a custom charset of ${MYSQL_DEFAULT_CHARSET}"
	  ewarn "and a collation of ${MYSQL_DEFAULT_COLLATION}."
	  ewarn "You MUST file bugs without these variables set."
	  ewarn "Tests will probably fail!"
	  mycmakeargs+=(
	    -DDEFAULT_CHARSET=${MYSQL_DEFAULT_CHARSET}
	    -DDEFAULT_COLLATION=${MYSQL_DEFAULT_COLLATION}
	  )
	elif use latin1 ; then
	  mycmakeargs+=(
	    -DDEFAULT_CHARSET=latin1
	    -DDEFAULT_COLLATION=latin1_swedish_ci
	  )
	else
	  mycmakeargs+=(
	    -DDEFAULT_CHARSET=utf8mb4
	    -DDEFAULT_COLLATION=utf8mb4_0900_ai_ci
	  )
	fi
	if use server ; then
	  mycmakeargs+=(
	    -DWITH_EXTRA_CHARSETS=all
	    -DWITH_DEBUG=$(usex debug)
	    -DWITH_MECAB=$(usex cjk system OFF)
	    -DWITH_LIBEVENT=system
	    -DWITH_PROTOBUF=system
	    -DWITH_NUMA=$(usex numa ON OFF)
	  )
	  if use jemalloc ; then
	    mycmakeargs+=( -DWITH_JEMALLOC=ON )
	  elif use tcmalloc ; then
	    mycmakeargs+=( -DWITH_TCMALLOC=ON )
	  fi
	  if use profiling ; then
	    mycmakeargs+=( -DENABLED_PROFILING=ON )
	  fi
	  mycmakeargs+=(
	    -DWITH_EXAMPLE_STORAGE_ENGINE=0
	    -DWITH_ARCHIVE_STORAGE_ENGINE=1
	    -DWITH_BLACKHOLE_STORAGE_ENGINE=1
	    -DWITH_CSV_STORAGE_ENGINE=1
	    -DWITH_FEDERATED_STORAGE_ENGINE=1
	    -DWITH_HEAP_STORAGE_ENGINE=1
	    -DWITH_INNOBASE_STORAGE_ENGINE=1
	    -DWITH_INNODB_MEMCACHED=0
	    -DWITH_MYISAMMRG_STORAGE_ENGINE=1
	    -DWITH_MYISAM_STORAGE_ENGINE=1
	  )
	else
	  mycmakeargs+=(
	    -DWITHOUT_SERVER=1
	    -DWITH_SYSTEMD=no
	  )
	fi
	cmake_src_configure
}
src_install() {
	cmake_src_install
	# Make sure the vars are correctly initialized
	mysql_init_vars
	# Convenience links
	einfo "Making Convenience links for mysqlcheck multi-call binary"
	dosym "mysqlcheck" "/usr/bin/mysqlanalyze"
	dosym "mysqlcheck" "/usr/bin/mysqlrepair"
	dosym "mysqlcheck" "/usr/bin/mysqloptimize"
	# INSTALL_LAYOUT=STANDALONE causes cmake to create a /usr/data dir
	if [[ -d "${ED}/usr/data" ]] ; then
	  rm -Rf "${ED}/usr/data" || die
	fi
	# Unless they explicitly specific USE=test, then do not install the
	# testsuite. It DOES have a use to be installed, esp. when you want to do a
	# validation of your database configuration after tuning it.
	rm -rf "${ED}/${MY_SHAREDSTATEDIR#${EPREFIX}}/mysql-test"
	# Configuration stuff
	einfo "Building default configuration ..."
	insinto "${MY_SYSCONFDIR#${EPREFIX}}"
	[[ -f "${S}/scripts/mysqlaccess.conf" ]] && doins "${S}"/scripts/mysqlaccess.conf
	cp "${FILESDIR}/my.cnf-8.0" "${TMPDIR}/my.cnf" || die
	doins "${TMPDIR}/my.cnf"
	insinto "${MY_SYSCONFDIR#${EPREFIX}}/mysql.d"
	cp "${FILESDIR}/my.cnf-8.0.distro-client" "${TMPDIR}/50-distro-client.cnf" || die
	doins "${TMPDIR}/50-distro-client.cnf"
	mycnf_src="my.cnf-8.0.distro-server"
	sed -e "s!@DATADIR@!${MY_DATADIR}!g" \
	  "${FILESDIR}/${mycnf_src}" \
	  > "${TMPDIR}/my.cnf.ok" || die
	if use latin1 ; then
	  sed -i \
	    -e "/character-set/s|utf8mb4|latin1|g" \
	    "${TMPDIR}/my.cnf.ok" || die
	fi
	newins "${TMPDIR}/my.cnf.ok" 50-distro-server.cnf
	#Remove mytop if perl is not selected
	[[ -e "${ED}/usr/bin/mytop" ]] && ! use perl && rm -f "${ED}/usr/bin/mytop"
	if use router ; then
	  rm -rf \
	    "${ED}/usr/LICENSE.router" \
	    "${ED}/usr/README.router" \
	    "${ED}/usr/run" \
	    "${ED}/usr/var" \
	    || die
	fi
	# Kill old libmysqclient_r symlinks if they exist. Time to fix what depends on them.
	find "${D}" -name 'libmysqlclient_r.*' -type l -delete || die
	local clientlibs_files=(
	  ${ED}/usr/bin/perror
	  ${ED}/usr/bin/comp_err
	  ${ED}/usr/bin/zlib_decompress
	  ${ED}/usr/bin/my_print_defaults
	  ${ED}/usr/bin/mysql_config
	  ${ED}/usr/lib64/libmysqlclient.*
	  ${ED}/usr/lib64/pkgconfig
	  ${ED}/usr/share/aclocal
	  ${ED}/usr/include/mysql
	  ${ED}/usr/share/man/man1/my_print_defaults.1*
	  ${ED}/usr/share/man/man1/perror.1*
	  ${ED}/usr/share/man/man1/zlib_decompress.1*
	)
	# Remove files associated with client libs:
	for x in ${clientlibs_files[@]}; do
	  einfo "Removing $x"
	  rm -rf $x || die
	done
}
pkg_postinst() {
	# Make sure the vars are correctly initialized
	mysql_init_vars
	# Create log directory securely if it does not exist
	# NOTE: $MY_LOGDIR contains $EPREFIX by default
	[[ -d "${MY_LOGDIR}" ]] || install -d -m0750 -o mysql -g mysql "${MY_LOGDIR}"
	# Note about configuration change
	einfo
	elog "Please follow these steps for initial setup. Run these commands as root:"
	einfo
	elog "# mysqld --initialize-insecure --default_authentication_plugin=mysql_native_password --datadir=${EPREFIX}/var/lib/mysql"
	elog "# /etc/init.d/mysql start"
	elog "# mysql_secure_installation"
	einfo
}



# vim: filetype=ebuild
