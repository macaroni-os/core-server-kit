# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit autotools

DESCRIPTION="libqb is a library providing high performance logging, tracing, ipc, and poll."
HOMEPAGE="http://clusterlabs.github.io/libqb/"
SRC_URI="https://api.github.com/repos/ClusterLabs/libqb/tarball/v2.0.9 -> libqb-2.0.9-4b496d0.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="*"
DOCS=(
	README.markdown
)
IUSE="debug doc examples systemd"
BDEPEND="app-arch/xz-utils
	doc? (
	  app-text/doxygen[dot]
	)
	
"
RDEPEND="dev-libs/glib:2
	dev-libs/libxml2:=
	
"
DEPEND="${RDEPEND}
"

post_src_unpack() {
	mv ClusterLabs-libqb-* ${S}
}


src_prepare() {
	default
	# Skip installation of text documents without value
	sed -e '/dist_doc_DATA/d' -i Makefile.am || die
	# Do not append version suffix "-yank"
	sed 's|1-yank|1|' -i configure.ac || die
	eautoreconf
}
src_configure() {
	econf \
	  --disable-static \
	  --with-socket-dir=/run \
	  $(use_enable systemd systemd-journal) \
	  $(use_enable debug)
}
src_compile() {
	default
	use doc && emake doxygen
}
src_install() {
	emake install DESTDIR="${D}"
	if use examples ; then
	  docinto examples
	  dodoc examples/*.c
	fi
	use doc && HTML_DOCS=("docs/html/.")
	einstalldocs
	find "${D}" -name '*.la' -delete || die
}



# vim: filetype=ebuild
