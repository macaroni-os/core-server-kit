# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit autotools systemd

DESCRIPTION="A highly configurable replacement for syslogd/klogd"
HOMEPAGE="https://github.com/hvisage/metalog"
SRC_URI="https://api.github.com/repos/hvisage/metalog/tarball/refs/tags/metalog-20260811 -> metalog-20260811-1f3256c.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
IUSE="systemd unicode"
BDEPEND="sys-devel/autoconf-archive
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/libpcre2
	sys-libs/zlib
	
"
DEPEND="${RDEPEND}
"

post_src_unpack() {
	mv hvisage-metalog-* ${S}
}


src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf $(use_with unicode)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog README NEWS metalog.conf
	 into /
	dosbin "${FILESDIR}"/consolelog.sh
	 newconfd "${FILESDIR}"/metalog.confd metalog
	if use systemd ; then
	  systemd_newunit "${FILESDIR}/metalog.service-r1" "metalog.service"
	else
	  newinitd "${FILESDIR}"/metalog.initd-r1 metalog
	fi
}

pkg_preinst() {
	if [[ -d "${ROOT}"/etc/metalog ]] && [[ ! -e "${ROOT}"/etc/metalog.conf ]] ; then
	  mv -f "${ROOT}"/etc/metalog/metalog.conf "${ROOT}"/etc/metalog.conf
	  rmdir "${ROOT}"/etc/metalog
	  export MOVED_METALOG_CONF=true
	else
	  export MOVED_METALOG_CONF=false
	fi
}

pkg_postinst() {
	if ${MOVED_METALOG_CONF} ; then
	  ewarn "The default metalog.conf file has been moved"
	  ewarn "from /etc/metalog/metalog.conf to just"
	  ewarn "/etc/metalog.conf.  If you had a standard"
	  ewarn "setup, the file has been moved for you."
	fi
}



# vim: filetype=ebuild
