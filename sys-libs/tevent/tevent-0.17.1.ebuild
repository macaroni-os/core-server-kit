# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit python-single-r1 autotools

DESCRIPTION="Samba tevent library"
HOMEPAGE="https://tevent.samba.org/"
SRC_URI="https://download.samba.org/pub/tevent/tevent-0.17.1.tar.gz -> tevent-0.17.1.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"
IUSE="python"
REQUIRED_USE="${PYTHON_REQUIRED_USE}
"
BDEPEND="${PYTHON_DEPS}
	virtual/pkgconfig
	dev-util/cmocka
"
RDEPEND="dev-libs/libbsd
	sys-libs/talloc
	python? (
	  ${PYTHON_DEPS}
	  sys-libs/talloc[python,${PYTHON_USEDEP}]
	)
	
"
DEPEND="${RDEPEND}
	net-libs/libtirpc
	
"
pkg_setup() {
	python-single-r1_pkg_setup
}
src_prepare() {
	default
}
src_configure() {
	econf \
	  --libdir="${EPREFIX}/usr/$(get_libdir)" \
	  --disable-dependency-tracking \
	  --disable-warnings-as-errors \
	  --bundled-libraries=NONE \
	  --builtin-libraries=NONE \
	  $(usex python '' '--disable-python')
}
src_install() {
	emake DESTDIR="${ED}" install
	use python && python_domodule tevent.py
	insinto /usr/include
	doins tevent_internal.h
}


# vim: filetype=ebuild
