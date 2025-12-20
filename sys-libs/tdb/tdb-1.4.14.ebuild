# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit python-single-r1 autotools

DESCRIPTION="LSimple database API"
HOMEPAGE="https://tdb.samba.org/"
SRC_URI="https://download.samba.org/pub/tdb/tdb-1.4.14.tar.gz -> tdb-1.4.14.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"
IUSE="python"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
BDEPEND="${PYTHON_DEPS}
	app-text/docbook-xml-dtd:4.2
	
"
RDEPEND="dev-libs/libbsd
	python? ( ${PYTHON_DEPS} )
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	default
	python_fix_shebang .
}
src_configure() {
	local extra_opts=(
	  --libdir="${EPREFIX}/usr/$(get_libdir)"
	  --disable-warnings-as-errors
	)
	if ! use python; then
	  extra_opts+=( --disable-python )
	fi
	econf "${extra_opts[@]}"
}
src_install() {
	emake DESTDIR="${ED}" install
	use python && python_optimize
}


# vim: filetype=ebuild
