# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit autotools systemd tmpfiles

DESCRIPTION="Operating system and container binary deployment and upgrades"
HOMEPAGE="https://ostreedev.github.io/ostree/"
SRC_URI="https://github.com/ostreedev/ostree/releases/download/v2026.4/libostree-2026.4.tar.xz -> libostree-2026.4.tar.xz"
LICENSE="NOASSERTION"
SLOT="0"
KEYWORDS="*"
IUSE="avahi curl dracut gnutls +gpg +http2 introspection
doc +libmount man openssl systemd sodium +soup
"
REQUIRED_USE="|| ( soup curl )
"
BDEPEND="virtual/pkgconfig
	sys-fs/e2fsprogs
	sys-devel/bison
	
"
RDEPEND="dev-libs/ding-libs
	dev-libs/glib:2
	app-arch/xz-utils
	app-arch/libarchive
	sys-libs/zlib
	sys-fs/fuse:3=
	avahi? ( net-dns/avahi )
	curl? ( net-misc/curl )
	gnutls? ( net-libs/gnutls )
	openssl? ( dev-libs/openssl )
	sodium? ( dev-libs/libsodium )
	soup? ( net-libs/libsoup:3 )
	libmount? ( sys-apps/util-linux )
	
"
DEPEND="${RDEPEND}
	curl? ( net-libs/libsoup:3 )
	introspection? ( dev-libs/gobject-introspection )
	doc? ( dev-util/gtk-doc )
	man? ( dev-libs/libxslt )
	
"
src_prepare() {
		default
		eautoreconf
}
src_configure() {
		unset YACC
		local econfargs=(
				--enable-man
				--enable-shared
				--with-grub2-mkconfig-path=grub-mkconfig
				--with-modern-grub
				--with-libarchive
				--without-selinux
				$(use_with curl)
				$(use_with dracut dracut yesbutnoconf) #816867
				$(use_enable doc gtk-doc)
				$(usex introspection --enable-introspection={,} yes no)
				$(use_with gpg gpgme)
				$(use_enable http2)
				$(use_with soup soup3)
				--without-soup # libsoup:2.4
				$(use_with libmount)
				$(use_with sodium ed25519-libsodium)
				$(use_with systemd libsystemd)
				$(use_with avahi)
		)
		if use systemd; then
				econfargs+=( --with-systemdsystemunitdir="$(systemd_get_systemunitdir)" )
		fi
		# Crypto for checksums:
		# prefer gnutls over openssl if both are selected
		if use gnutls; then
				econfargs+=( --with-crypto=gnutls )
		elif use openssl; then
				econfargs+=( --with-crypto=openssl )
		else
				econfargs+=( --with-crypto=glib )
		fi
		unset ${!XDG_*}
		econf "${econfargs[@]}"
}
src_install() {
		default
		rm -f ${D}/etc/grub.d/15_ostree
		dotmpfiles src/boot/ostree-tmpfiles.conf #901797
		find "${D}" -name '*.la' -type f -delete || die
}
pkg_postinst() {
		tmpfiles_process ostree-tmpfiles.conf
}


# vim: filetype=ebuild
