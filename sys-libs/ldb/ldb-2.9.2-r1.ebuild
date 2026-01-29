# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit python-single-r1 autotools

DESCRIPTION="LDAP-like embedded database"
HOMEPAGE="https://ldb.samba.org"
SRC_URI="https://download.samba.org/pub/ldb/ldb-2.9.2.tar.gz -> ldb-2.9.2.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"
PATCHES=(
	"${FILESDIR}/ldb-1.1.31-fix_PKGCONFIGDIR-when-python-disabled.patch"
	"${FILESDIR}/ldb-2.9.0-optional_packages.patch"
	"${FILESDIR}/ldb-2.5.2-skip-wav-tevent-check.patch"
)
IUSE="+ldap +lmdb python"
BDEPEND="${PYTHON_DEPS}
	dev-libs/libxslt
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/libbsd
	dev-libs/popt
	dev-util/cmocka
	sys-libs/talloc
	sys-libs/tdb
	sys-libs/tevent
	ldap? ( net-nds/openldap )
	python? (
	  ${PYTHON_DEPS}
	  sys-libs/talloc[python,${PYTHON_USEDEP}]
	  sys-libs/tdb[python,${PYTHON_USEDEP}]
	  sys-libs/tevent[python,${PYTHON_USEDEP}]
	)
	
"
DEPEND="${RDEPEND}
	
"
pkg_setup() {
	export DISTCC_DISABLE=1
	python-single-r1_pkg_setup
}
src_prepare() {
	default
}
src_configure() {
	local myconf=(
	  $(usex ldap '' --disable-ldap)
	  $(usex lmdb '' --without-ldb-lmdb)
	  --disable-rpath
	  --disable-rpath-install --bundled-libraries=NONE
	  --with-modulesdir="${EPREFIX}"/usr/$(get_libdir)/samba
	  --builtin-libraries=NONE
	)
	use python || myconf+=( --disable-python )
	econf "${myconf[@]}"
}
src_install() {
	emake DESTDIR="${ED}" install
	use python && python_optimize
}


# vim: filetype=ebuild
