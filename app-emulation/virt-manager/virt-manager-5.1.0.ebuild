# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit gnome3 python-single-r1 meson

DESCRIPTION="A graphical tool for administering virtual machines/containers"
HOMEPAGE="https://virt-manager.org https://github.com/virt-manager/virt-manager"
SRC_URI="https://releases.pagure.org/virt-manager/virt-manager-5.1.0.tar.xz -> virt-manager-5.1.0.tar.xz"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="*"
IUSE="gtk policykit sasl"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
BDEPEND="sys-devel/gettext
	
"
RDEPEND="${PYTHON_DEPS}
	|| ( dev-libs/libisoburn app-cdr/cdrtools )
	app-emulation/libvirt-glib[introspection]
	$(python_gen_cond_dep '
	  dev-libs/libxml2[python,${PYTHON_USEDEP}]
	  dev-python/argcomplete[${PYTHON_USEDEP}]
	  dev-python/libvirt-python[${PYTHON_USEDEP}]
	  dev-python/pygobject:3[${PYTHON_USEDEP}]
	  dev-python/requests[${PYTHON_USEDEP}]
	')
	sys-libs/libosinfo[introspection]
	gtk? (
	  gnome-base/dconf
	  net-libs/gtk-vnc[gtk3(+),introspection]
	  net-misc/spice-gtk[usbredir,gtk3,introspection,sasl?]
	  policykit? ( sys-auth/polkit[introspection] )
	  sys-apps/dbus[X]
	  x11-libs/gtk+:3[introspection]
	  || (
	    x11-libs/gtksourceview:4[introspection]
	    x11-libs/gtksourceview:3.0[introspection]
	  )
	  x11-libs/vte:2.91[introspection]
	)
	
"
DEPEND="${RDEPEND}
"
src_configure() {
	local emesonargs=(
	  -Dupdate-icon-cache=false
	  -Dcompile-schemas=false
	  -Ddefault-graphics=spice # default
	  -Dtests=disabled
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	if ! use gtk; then
	  rm -r "${ED}/usr/share/applications/${PN}.desktop" || die
	  rm -r "${ED}/usr/share/${PN}/icons/" || die
	  rm -r "${ED}/usr/share/${PN}/ui/" || die
	  rm -r "${ED}/usr/share/icons/" || die
	  rm -r "${ED}/usr/bin/${PN}" || die
	fi
	python_fix_shebang "${ED}"
	python_optimize "${ED}"/usr/share/virt-manager/virt{inst,Manager}
}
pkg_postinst() {
	use gtk && gnome3_pkg_postinst
}


# vim: filetype=ebuild
