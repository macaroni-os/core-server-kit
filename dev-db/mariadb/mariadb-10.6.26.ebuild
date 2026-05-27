# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
CMAKE_BUILD_TYPE="RelWithDebInfo"
inherit eutils flag-o-matic toolchain-funcs cmake user

DESCRIPTION="An enhanced, drop-in replacement for MySQL"
HOMEPAGE="https://mariadb.org/"
SRC_URI="https://archive.mariadb.org/mariadb-10.6.26/source/mariadb-10.6.26.tar.gz -> mariadb-10.6.26.tar.gz"
LICENSE="GPL-2 LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
IUSE="+backup columnstore cracklib debug
extraengine galera innodb-lz4 innodb-lzo
innodb-snappy jemalloc kerberos latin1
numa odbc oqgraph pam +perl profiling rocksdb
+server sst-rsync sst-mariabackup static systemtap s3
tcmalloc xml yassl
"
REQUIRED_USE="?? ( tcmalloc jemalloc )
static? ( yassl !pam )
"
# Commons depends
CDEPEND="dev-libs/libpcre2:=
	sys-apps/sed
	sys-apps/texinfo
	sys-libs/ncurses:0=
	sys-libs/zlib:0=
	sys-libs/binutils-libs:=
	sys-libs/readline:=
	jemalloc? ( dev-libs/jemalloc:= )
	kerberos? ( virtual/krb5 )
	sys-process/procps:=
	dev-libs/libaio:=
	server? (
	  app-arch/bzip2
	  app-arch/xz-utils
	  backup? ( app-arch/libarchive:= )
	  columnstore? (
	    app-arch/snappy
	    dev-libs/boost:=
	    dev-libs/libxml2:=
	  )
	  cracklib? ( sys-libs/cracklib:= )
	  extraengine? (
	    odbc? ( dev-db/unixODBC:= )
	    xml? ( dev-libs/libxml2:= )
	  )
	  innodb-lz4? ( app-arch/lz4 )
	  innodb-lzo? ( dev-libs/lzo )
	  innodb-snappy? ( app-arch/snappy )
	  oqgraph? (
	    dev-libs/boot:=
	    dev-libs/judy:=
	  )
	  pam? ( sys-libs/pam:= )
	  s3? ( net-misc/curl )
	)
	systemtap? ( dev-util/systemtap:= )
	tcmalloc? ( dev-tuil/google-perftools:= )
	yassl? ( net-libs/gnutls:= )
	!yassl? (
	  dev-libs/openssl:=
	)
	
"
BDEPEND="virtual/yacc
	
"
RDEPEND="${CDEPEND}
	!dev-db/mariadb:10.6
	!virtual/mysql
	!virtual/libmysqlclient
	server? (
	  columnstore? ( dev-db/mariadb-connector-c )
	  galera? (
	    sys-apps/iproute2
	    sys-cluster/galera
	    sst-rsync? ( sys-process/lsof )
	    sst-mariabackup? ( net-misc/socat[ssl] )
	  )
	  dev-db/mysql-init-scripts
	)
	perl? (
	  virtual/perl-Getopt-Long
	  dev-perl/TermReadKey
	  virtual/perl-Term-ANSIColor
	  virtual/perl-Time-HiRes
	)
	
"
DEPEND="${CDEPEND}
	static? ( sys-libs/ncurses[static-libs] )
	
"
PDEPEND="perl? ( dev-perl/DBD-mysql )
	app-admin/whip
	sys-apps/whip-catalog
	
"
mysql_init_vars() {
	MY_SHAREDSTATEDIR=${MY_SHAREDSTATEDIR="/usr/share/mariadb"}
	MY_SYSCONFDIR=${MY_SYSCONFDIR="/etc/mysql"}
	MY_LOCALSTATEDIR=${MY_LOCALSTATEDIR="/var/lib/mysql"}
	MY_LOGDIR=${MY_LOGDIR="/var/log/mysql"}
	if [[ -z "${MY_DATADIR}" ]] ; then
	  MY_DATADIR=""
	  if [[ -f "${MY_SYSCONFDIR}/my.cnf" ]] ; then
	    MY_DATADIR=$(my_print_defaults mysqld 2>/dev/null \
	      | sed -ne '/datadir/s|^--datadir=||p' \
	      | tail -n1)
	    if [[ -z "${MY_DATADIR}" ]] ; then
	      MY_DATADIR=$(grep ^datadir "${MY_SYSCONFDIR}/my.cnf" \
	      | sed -e 's/.*=\s*//' \
	      | tail -n1)
	    fi
	  fi
	  if [[ -z "${MY_DATADIR}" ]] ; then
	    MY_DATADIR="${MY_LOCALSTATEDIR}"
	    einfo "Using default MY_DATADIR"
	  fi
	  elog "MySQL MY_DATADIR is ${MY_DATADIR}"
	   if [[ -z "${PREVIOUS_DATADIR}" ]] ; then
	    if [[ -e "${MY_DATADIR}" ]] ; then
	      # If you get this and you're wondering about it, see bug #207636
	      elog "MySQL datadir found in ${MY_DATADIR}"
	      elog "A new one will not be created."
	      PREVIOUS_DATADIR="yes"
	    else
	      PREVIOUS_DATADIR="no"
	    fi
	    export PREVIOUS_DATADIR
	  fi
	else
	  if [[ ${EBUILD_PHASE} == "config" ]]; then
	    local new_MY_DATADIR
	    new_MY_DATADIR=$(my_print_defaults mysqld 2>/dev/null \
	      | sed -ne '/datadir/s|^--datadir=||p' \
	      | tail -n1)
	     if [[ ( -n "${new_MY_DATADIR}" ) && ( "${new_MY_DATADIR}" != "${MY_DATADIR}" ) ]]; then
	      ewarn "MySQL MY_DATADIR has changed"
	      ewarn "from ${MY_DATADIR}"
	      ewarn "to ${new_MY_DATADIR}"
	      MY_DATADIR="${new_MY_DATADIR}"
	    fi
	  fi
	fi
	 export MY_SHAREDSTATEDIR MY_SYSCONFDIR
	export MY_LOCALSTATEDIR MY_LOGDIR
	export MY_DATADIR
}
pkg_setup() {
	# This should come after all of the die statements
	enewgroup mysql 60 || die "problem adding 'mysql' group"
	enewuser mysql 60 -1 /dev/null mysql || die "problem adding 'mysql' user"
}
src_prepare() {
	eapply_user
	_disable_plugin() {
	  echo > "${S}/plugin/${1}/CMakeLists.txt" || die
	}
	_disable_engine() {
	  echo > "${S}/storage/${1}/CMakeLists.txt" || die
	}
	if use jemalloc; then
	  echo "TARGET_LINK_LIBRARIES(mariadbd LINK_PUBLIC jemalloc)" >> "${S}/sql/CMakeLists.txt"
	elif use tcmalloc; then
	  echo "TARGET_LINK_LIBRARIES(mariadbd tcmalloc)" >> "${S}/sql/CMakeLists.txt"
	fi
	local plugin
	local server_plugins=(
	  handler_socket
	  auth_socket
	  feedback
	  metadata_lock_info
	  locale_info
	  qc_info
	  server_audit
	  sql_errlog
	  auth_ed25519
	)
	local test_plugins=(
	  audit_null
	  auth_examples
	  daemon_example
	  fulltext
	  debug_key_management
	  example_key_management
	  versioning
	)
	if ! use server; then # These plugins are for the server
	  for plugin in "${server_plugins[@]}" ; do
	    _disable_plugin "${plugin}"
	  done
	fi
	for plugin in "${test_plugins[@]}" ; do
	_disable_plugin "${plugin}"
	done
	_disable_engine test_sql_discovery
	echo > "${S}/plugin/auth_pam/testing/CMakeLists.txt" || die
	_disable_engine example
	if ! use oqgraph ; then # avoids extra library checks
	_disable_engine oqgraph
	fi
	_disable_engine mroonga
	 # Fix static bindings in galera replication
	sed -i -e 's~add_library(wsrep_api_v26$~add_library(wsrep_api_v26 STATIC~' \
	"${S}"/wsrep-lib/wsrep-API/CMakeLists.txt || die
	sed -i -e 's~add_library(wsrep-lib$~add_library(wsrep-lib STATIC~' \
	"${S}"/wsrep-lib/src/CMakeLists.txt || die
	 # Don't clash with dev-db/mysql-connector-c
	sed -i -e 's/ my_print_defaults.1//' \
	-e 's/ perror.1//' \
	"${S}"/man/CMakeLists.txt || die
	 # Fix galera_recovery.sh script
	sed -i -e "s~@bindir@/my_print_defaults~/usr/libexec/mariadb/my_print_defaults~" \
	  scripts/galera_recovery.sh || die
	sed -i -e 's~ \$basedir/lib/\*/mariadb19/plugin~~' \
	  "${S}"/scripts/mysql_install_db.sh || die
	 cmake_src_prepare
}
src_configure() {
	# bug 508724 mariadb cannot use ld.gold
	tc-ld-disable-gold
	# Bug #114895, bug #110149
	filter-flags "-O" "-O[01]"
	append-cxxflags -felide-constructors
	append-flags -fno-strict-aliasing
	# debug hack wrt #497532
	mycmakeargs=(
	  -DCMAKE_C_FLAGS_RELWITHDEBINFO="$(usex debug '' '-DNDEBUG')"
	  -DCMAKE_CXX_FLAGS_RELWITHDEBINFO="$(usex debug '' '-DNDEBUG')"
	  -DCMAKE_INSTALL_PREFIX="/usr"
	  -DMYSQL_DATADIR="/var/lib/mysql"
	  -DSYSCONFDIR="/etc/mysql"
	  -DINSTALL_BINDIR=bin
	  -DINSTALL_DOCDIR=share/doc/${PF}
	  -DINSTALL_DOCREADMEDIR=share/doc/${PF}
	  -DINSTALL_INCLUDEDIR=include/mysql
	  -DINSTALL_INFODIR=share/info
	  -DINSTALL_LIBDIR=$(get_libdir)
	  -DINSTALL_MANDIR=share/man
	  -DINSTALL_MYSQLSHAREDIR=share/mariadb
	  -DINSTALL_PLUGINDIR=$(get_libdir)/mariadb/plugin
	  -DINSTALL_SCRIPTDIR=bin
	  -DINSTALL_MYSQLDATADIR="/var/lib/mysql"
	  -DINSTALL_SBINDIR=sbin
	  -DINSTALL_SUPPORTFILESDIR="/usr/share/mariadb"
	  -DWITH_COMMENT="MacaroniOS Linux mariadb-10.6.26"
	  -DWITH_UNIT_TESTS=OFF
	  -DWITH_LIBEDIT=0
	  -DWITH_ZLIB=system
	  -DWITHOUT_LIBWRAP=1
	  -DENABLED_LOCAL_INFILE=1
	  -DMYSQL_UNIX_ADDR="/var/run/mysqld/mysqld.sock"
	  -DINSTALL_UNIX_ADDRDIR="/var/run/mysqld/mysqld.sock"
	  -DWITH_DEFAULT_COMPILER_OPTIONS=0
	  -DWITH_DEFAULT_FEATURE_SET=0
	  # The build forces this to be defined when cross-compiling.  We pass it
	  # all the time for simplicity and to make sure it is actually correct.
	  -DSTACK_DIRECTION=$(tc-stack-grows-down && echo -1 || echo 1)
	  -DPKG_CONFIG_EXECUTABLE="/usr/bin/$(tc-getPKG_CONFIG)"
	  -DPLUGIN_AUTH_GSSAPI=$(usex kerberos DYNAMIC NO)
	  -DAUTH_GSSAPI_PLUGIN_TYPE=$(usex kerberos DYNAMIC OFF)
	  -DCONC_WITH_EXTERNAL_ZLIB=YES
	  -DWITH_EXTERNAL_ZLIB=YES
	  -DSUFFIX_INSTALL_DIR=""
	  -DWITH_UNITTEST=OFF
	  -DWITHOUT_CLIENTLIBS=YES
	  -DCLIENT_PLUGIN_DIALOG=OFF
	  -DCLIENT_PLUGIN_AUTH_GSSAPI_CLIENT=OFF
	  -DCLIENT_PLUGIN_CLIENT_ED25519=OFF
	  -DCLIENT_PLUGIN_MYSQL_CLEAR_PASSWORD=STATIC
	  -DCLIENT_PLUGIN_CACHING_SHA2_PASSWORD=OFF
	  -DINSTALL_MYSQLTESTDIR=''
	)
	 if ! use yassl ; then
	  mycmakeargs+=( -DWITH_SSL=system -DCLIENT_PLUGIN_SHA256_PASSWORD=STATIC )
	else
	  mycmakeargs+=( -DWITH_SSL=bundled )
	fi
	# bfd.h is only used starting with 10.1 and can be controlled by NOT_FOR_DISTRIBUTION
	mycmakeargs+=(
	  -DWITH_READLINE=0
	  -DNOT_FOR_DISTRIBUTION=1
	  -DENABLE_DTRACE=$(usex systemtap)
	)
	 if use server ; then
	  # Federated{,X} must be treated special otherwise they will not be built as plugins
	  if ! use extraengine ; then
	    mycmakeargs+=(
	      -DPLUGIN_FEDERATED=NO
	      -DPLUGIN_FEDERATEDX=NO
	    )
	  fi
	  mycmakeargs+=(
	    -DWITH_JEMALLOC=$(usex jemalloc system)
	    -DWITH_PCRE=system
	    -DPLUGIN_OQGRAPH=$(usex oqgraph DYNAMIC NO)
	    -DPLUGIN_SPHINX=NO
	    -DPLUGIN_AUTH_PAM=$(usex pam YES NO)
	    -DPLUGIN_CRACKLIB_PASSWORD_CHECK=$(usex cracklib YES NO)
	    -DPLUGIN_CASSANDRA=NO
	    -DPLUGIN_SEQUENCE=$(usex extraengine YES NO)
	    -DPLUGIN_SPIDER=$(usex extraengine YES NO)
	    -DPLUGIN_S3=$(usex s3 YES NO)
	    -DPLUGIN_COLUMNSTORE=$(usex columnstore YES NO)
	    -DPLUGIN_CONNECT=$(usex extraengine YES NO)
	    -DCONNECT_WITH_MYSQL=1
	    -DCONNECT_WITH_LIBXML2=$(usex xml)
	    -DCONNECT_WITH_ODBC=$(usex odbc)
	    -DCONNECT_WITH_JDBC=OFF
	    # Build failure and autodep wrt bug 639144
	    -DCONNECT_WITH_MONGO=OFF
	    -DWITH_WSREP=$(usex galera)
	    -DWITH_INNODB_LZ4=$(usex innodb-lz4 ON OFF)
	    -DWITH_INNODB_LZO=$(usex innodb-lzo ON OFF)
	    -DWITH_INNODB_SNAPPY=$(usex innodb-snappy ON OFF)
	    -DPLUGIN_MROONGA=NO
	    -DPLUGIN_AUTH_GSSAPI=$(usex kerberos DYNAMIC NO)
	    -DWITH_MARIABACKUP=$(usex backup ON OFF)
	    -DWITH_LIBARCHIVE=$(usex backup ON OFF)
	    -DINSTALL_SQLBENCHDIR=""
	    -DPLUGIN_ROCKSDB=$(usex rocksdb DYNAMIC NO)
	    -DWITH_NUMA=$(usex numa ON OFF)
	    -DSKIP_TESTS=ON
	  )
	   if [[ ( -n ${MYSQL_DEFAULT_CHARSET} ) && ( -n ${MYSQL_DEFAULT_COLLATION} ) ]]; then
	    ewarn "You are using a custom charset of ${MYSQL_DEFAULT_CHARSET}"
	    ewarn "and a collation of ${MYSQL_DEFAULT_COLLATION}."
	    ewarn "You MUST file bugs without these variables set."
	    mycmakeargs+=(
	      -DDEFAULT_CHARSET=${MYSQL_DEFAULT_CHARSET}
	      -DDEFAULT_COLLATION=${MYSQL_DEFAULT_COLLATION}
	    )
	   elif ! use latin1 ; then
	    mycmakeargs+=(
	      -DDEFAULT_CHARSET=utf8
	      -DDEFAULT_COLLATION=utf8_general_ci
	    )
	  else
	    mycmakeargs+=(
	      -DDEFAULT_CHARSET=latin1
	      -DDEFAULT_COLLATION=latin1_swedish_ci
	    )
	  fi
	  mycmakeargs+=(
	    -DEXTRA_CHARSETS=all
	    -DMYSQL_USER=mysql
	    -DDISABLE_SHARED=$(usex static YES NO)
	    -DWITH_DEBUG=$(usex debug)
	    -DWITH_EMBEDDED_SERVER=OFF
	    -DWITH_PROFILING=$(usex profiling)
	  )
	  if use static; then
	    mycmakeargs+=( -DWITH_PIC=1 )
	  fi
	  if use jemalloc || use tcmalloc ; then
	    mycmakeargs+=( -DWITH_SAFEMALLOC=OFF )
	  fi
	  # Storage engines
	  mycmakeargs+=(
	    -DWITH_ARCHIVE_STORAGE_ENGINE=1
	    -DWITH_BLACKHOLE_STORAGE_ENGINE=1
	    -DWITH_CSV_STORAGE_ENGINE=1
	    -DWITH_HEAP_STORAGE_ENGINE=1
	    -DWITH_INNOBASE_STORAGE_ENGINE=1
	    -DWITH_MYISAMMRG_STORAGE_ENGINE=1
	    -DWITH_MYISAM_STORAGE_ENGINE=1
	    -DWITH_PARTITION_STORAGE_ENGINE=1
	  )
	else
	  mycmakeargs+=(
	    -DWITHOUT_SERVER=1
	    -DWITH_EMBEDDED_SERVER=OFF
	    -DEXTRA_CHARSETS=none
	    -DINSTALL_SQLBENCHDIR=
	    -DWITH_SYSTEMD=no
	  )
	fi
	cmake_src_configure
}
src_compile() {
	cmake_src_compile
}
src_install() {
	cmake_src_install
	# Remove an unnecessary, private config header which will never match between ABIs and is not meant to be used
	if [[ -f "${ED}/usr/include/mysql/server/private/config.h" ]] ; then
	  rm "${ED}/usr/include/mysql/server/private/config.h" || die
	fi
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
	rm -rf "${D}/${MY_SHAREDSTATEDIR}/mysql-test"
	# Configuration stuff
	einfo "Building default configuration ..."
	insinto "${MY_SYSCONFDIR#${EPREFIX}}"
	[[ -f "${S}/scripts/mysqlaccess.conf" ]] && doins "${S}"/scripts/mysqlaccess.conf
	cp "${FILESDIR}/my.cnf-10.2" "${TMPDIR}/my.cnf" || die
	doins "${TMPDIR}/my.cnf"
	insinto "${MY_SYSCONFDIR#${EPREFIX}}/mariadb.d"
	cp "${FILESDIR}/my.cnf.distro-client" "${TMPDIR}/50-distro-client.cnf" || die
	doins "${TMPDIR}/50-distro-client.cnf"
	cp "${FILESDIR}/90-replication-server.cnf" "${TMPDIR}/90-replication-server.cnf" || die
	doins "${TMPDIR}/90-replication-server.cnf"
	 if use server ; then
	  mycnf_src="my.cnf.distro-server"
	  sed -e "s!@DATADIR@!${MY_DATADIR}!g" \
	    "${FILESDIR}/${mycnf_src}" \
	  > "${TMPDIR}/my.cnf.ok" || die
	  if use latin1 ; then
	    sed -i -e "/character-set/s|utf8|latin1|g" \
	      "${TMPDIR}/my.cnf.ok" || die
	  fi
	  newins "${TMPDIR}/my.cnf.ok" 50-distro-server.cnf
	  einfo "Including support files and sample configurations"
	  docinto "support-files"
	  local script
	  for script in "${S}"/support-files/magic
	  do
	    [[ -f "$script" ]] && dodoc "${script}"
	  done
	  docinto "scripts"
	  for script in "${S}"/scripts/mysql* ; do
	  [[ ( -f "$script" ) && ( "${script%.sh}" == "${script}" ) ]] && dodoc "${script}"
	  done
	  # Manually install supporting files that conflict with other packages
	  # but are needed for galera and initial installation
	  exeinto /usr/libexec/mariadb
	  doexe "${BUILD_DIR}/extra/my_print_defaults" "${BUILD_DIR}/extra/perror"
	  if use pam ; then
	    keepdir /usr/$(get_libdir)/mariadb/plugin/auth_pam_tool_dir
	  fi
	fi
	# Remove mytop if perl is not selected
	if ! use perl ; then
	  local mytop_file
	  for mytop_file in "${ED}/usr/bin/mytop" "${ED}/usr/share/man/man1/mytop.1" ; do
	    if [[ -e "${mytop_file}" ]] ; then
	      rm -v "${mytop_file}" || die
	    fi
	  done
	fi
	 # Fix a dangling symlink when galera is not built
	if [[ -L "${ED}/usr/bin/wsrep_sst_rsync_wan" ]] && ! use galera ; then
	  rm "${ED}/usr/bin/wsrep_sst_rsync_wan" || die
	fi
	 # Remove broken SST scripts that are incompatible
	local scriptremove
	for scriptremove in wsrep_sst_xtrabackup wsrep_sst_xtrabackup-v2 ; do
	  if [[ -e "${ED}/usr/bin/${scriptremove}" ]] ; then
	    rm "${ED}/usr/bin/${scriptremove}" || die
	  fi
	done
	 # Remove files available on mariadb-connector-c
	rm -v "${ED}"/usr/bin/mariadb_config
	rm -v "${ED}"/usr/$(get_libdir)/libmariadb.*
	rm -v "${ED}"/usr/$(get_libdir)/libmariadbclient.a
}
pkg_postinst() {
	# Make sure the vars are correctly initialized
	mysql_init_vars
	 # Create log directory securely if it does not exist
	[[ -d "${ROOT}/${MY_LOGDIR}" ]] || install -d -m0750 -o mysql -g mysql "${ROOT}/${MY_LOGDIR}"
	 if use server ; then
	  if use pam; then
	    einfo
	    elog "This install includes the PAM authentication plugin."
	    elog "To activate and configure the PAM plugin, please read:"
	    elog "https://mariadb.com/kb/en/mariadb/pam-authentication-plugin/"
	    einfo
	    chown mysql:mysql "${EROOT}/usr/$(get_libdir)/mariadb/plugin/auth_pam_tool_dir" || die
	  fi
	   if [[ -z "${REPLACING_VERSIONS}" ]] ; then
	    einfo
	    elog "You might want to run:"
	    elog "\"emerge --config =${CATEGORY}/${PF}\""
	    elog "if this is a new install."
	    elog
	    elog "If you are switching server implentations, you should run the"
	    elog "mysql_upgrade tool."
	    einfo
	  else
	    einfo
	    elog "If you are upgrading major versions, you should run the"
	    elog "mysql_upgrade tool."
	    einfo
	  fi
	   if use galera ; then
	    einfo
	    elog "Be sure to edit the my.cnf file to activate your cluster settings."
	    elog "This should be done after running \"emerge --config =${CATEGORY}/${PF}\""
	    elog "The first time the cluster is activated, you should add"
	    elog "--wsrep-new-cluster to the options in /etc/conf.d/mysql for one node."
	    elog "This option should then be removed for subsequent starts."
	    einfo
	    if [[ -n "${REPLACING_VERSIONS}" ]] ; then
	      local rver
	      for rver in ${REPLACING_VERSIONS} ; do
	        if ver_test "${rver}" -lt "10.4.0" ; then
	        ewarn "Upgrading galera from a previous version requires admin restart of the entire cluster."
	        ewarn "Please refer to https://mariadb.com/kb/en/library/changes-improvements-in-mariadb-104/#galera-4"
	        ewarn "for more information"
	      fi
	      done
	    fi
	  fi
	fi
}
pkg_config() {
	whip h mariadb.config || die "Error on configure ${P}"
}


# vim: filetype=ebuild
