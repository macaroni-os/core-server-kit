# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit user systemd

DESCRIPTION="Relational database offering many ANSI SQL standard features"
HOMEPAGE="https://www.firebirdsql.org/"
SRC_URI="https://github.com/FirebirdSQL/firebird/releases/download/v4.0.7/Firebird-4.0.7.3271-0.tar.xz -> firebird-4.0.7.tar.xz"
LICENSE="IDPL Interbase-1.0"
SLOT="0"
KEYWORDS="*"
IUSE="+server systemd"
RDEPEND="dev-libs/icu:=
	dev-libs/libedit
	sys-libs/zlib
	
"
DEPEND="${RDEPEND}
"
pkg_setup() {
	# static uid/gid 450 per macaroni-os/macaroni-commons
	# packages/entities/groups.yaml (firebird: uid 450, gid 450,
	# home /dev/null, shell /sbin/nologin). -1 lets user.eclass
	# pick the nologin shell (it rejects a literal one), the gid
	# comes from the primary group created just above — same
	# pattern as the ntp/epmd specs in net-kit/lang-kit.
	enewgroup firebird 450
	enewuser firebird 450 -1 /dev/null firebird
}

post_src_unpack() {
	# official snapshot unpacks to Firebird-<version>.<build>-0
	mv Firebird-* "${S}" || die
}

src_compile() {
	# Firebird's make system uses ROOT as its own build-root variable;
	# the exported portage ROOT hits the examples/*/Makefile.in
	# ifndef ROOT guards and makes extauth compile against a nonexistent
	# $(ROOT)/include. Unsetting it restores the plain upstream `make`.
	unset ROOT
	emake
}

src_configure() {
	# Firebird only supports in-tree builds (writeBuildNum.sh is invoked
	# relative to the source dir), so no BUILD_DIR econf here
	./configure \
		--prefix="/usr/lib64/firebird" \
		--with-editline \
		--with-system-editline \
		--with-fbbin="/usr/bin" \
		--with-fbsbin="/usr/sbin" \
		--with-fbconf="/etc/firebird" \
		--with-fblib="/usr/lib64" \
		--with-fbinclude="/usr/include" \
		--with-fbdoc="/usr/share/doc/${PF}" \
		--with-fbsample="/usr/share/firebird/examples" \
		--with-fbsample-db="/usr/share/firebird/examples/empbuild" \
		--with-fbhelp="/usr/share/firebird/help" \
		--with-fbintl="/usr/lib64/firebird/intl" \
		--with-fbmisc="/usr/share/firebird" \
		--with-fbsecure-db="/etc/firebird" \
		--with-fbmsg="/usr/share/firebird/msg" \
		--with-fblog="/var/log/firebird" \
		--with-fbglock="/var/run/firebird" \
		--with-fbplugins="/usr/lib64/firebird/plugins" \
		--with-fbtzdata="/usr/share/firebird/tzdata" \
		--with-builtin-tommath \
		--with-builtin-tomcrypt \
		--with-gnu-ld || die
}

src_install() {
	# built tree staged by the upstream makefiles
	cd "${S}/gen/Release/firebird" || die

	# include/ holds flat C headers plus the firebird/ C++ API
	# subdirectory (Interface.h; php's pdo_firebird includes it);
	# doheader omits directories, so install the subdir explicitly
	doheader include/*.h
	insinto /usr/include/firebird
	doins -r include/firebird/.
	# libfbclient RUNPATHs /usr/lib64 and NEEDs the bundled
	# libtommath/libtomcrypt shared objects built in this tree.
	# The fbclient chain and ib_util are real file + relative links;
	# libtom{math,crypt} are staged as ABSOLUTE libtool symlinks into
	# the build tree (they would dangle after merge), so the real SONAME
	# objects get copied in and the dev links are recreated relative
	dolib.so lib/libfbclient.so* lib/libib_util.so
	cp -L lib/libtommath.so.0 "${ED}/usr/lib64/libtommath.so.0" || die
	cp -L lib/libtomcrypt.so.1 "${ED}/usr/lib64/libtomcrypt.so.1" || die
	dosym libtommath.so.0 /usr/lib64/libtommath.so
	dosym libtomcrypt.so.1 /usr/lib64/libtomcrypt.so

	# Interbase-era compat symlinks kept by upstream's install.sh
	dosym libfbclient.so "/usr/lib64/libgds.so"
	dosym libfbclient.so "/usr/lib64/libgds.so.0"
	dosym libfbclient.so "/usr/lib64/libfbclient.so.1"

	insinto /usr/share/firebird/msg
	doins firebird.msg

	use server || return 0

	# isql collides with the unixODBC isql client (Gentoo renamed it too)
	mv bin/isql bin/fbsql || die

	dobin bin/{fb_config,fbsql,fbsvcmgr,fbtracemgr,gbak,gfix,gpre,gsec,gsplit,gstat,nbackup,qli}
	dosbin bin/{firebird,fbguard,fb_lock_print}

	insinto /usr/share/firebird/help
	insopts -m0660 -o firebird -g firebird
	doins help/help.fdb

	exeinto /usr/lib64/firebird/intl
	doexe intl/libfbintl.so
	dosym libfbintl.so "/usr/lib64/firebird/intl/fbintl.so"
	insinto /usr/lib64/firebird/intl
	insopts -m0644 -o root -g root
	doins intl/fbintl.conf

	exeinto /usr/lib64/firebird/plugins
	doexe plugins/*.so
	exeinto /usr/lib64/firebird/plugins/udr
	doexe plugins/udr/*.so

	insinto /usr/share/firebird/tzdata
	doins -r tzdata/*

	insinto /etc/firebird/plugins
	insopts -m0644 -o root -g root
	doins plugins/udr_engine.conf

	insinto /etc/firebird
	doins databases.conf fbtrace.conf firebird.conf plugins.conf replication.conf

	# security4.fdb starts empty: the SYSDBA password is set on first
	# admin run, ownership belongs to the service account
	insopts -m0660 -o firebird -g firebird
	doins security4.fdb

	# the service account homedir is /dev/null (static entities
	# data), so keep the data and log dirs explicitly
	diropts -m0755 -o firebird -g firebird
	keepdir /var/lib/firebird
	keepdir /var/log/firebird

	# systemd USE selects the init system: unit under systemd,
	# OpenRC initd otherwise (maintainer pattern, #511 review)
	if use systemd ; then
		systemd_dounit "${FILESDIR}/firebird.service"
	else
		newinitd "${FILESDIR}/firebird.initd" firebird
	fi
}

pkg_postinst() {
	elog "The packaged security4.fdb starts empty. With an empty security"
	elog "database the first trusted local SYSDBA connection creates the"
	elog "account: stop the server, run fbsql -user sysdba as the firebird"
	elog "OS user and execute CREATE USER (verified in this build)."
	elog "See doc/README.security_database.txt upstream or"
	elog "https://www.firebirdsql.org/en/firebird-4-0/ for details."
}


# vim: filetype=ebuild
