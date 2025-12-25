# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
QA_FLAGS_IGNORED="/usr/bin/mcfly"
inherit cargo

DESCRIPTION="Fly through your shell history. Great Scott!"
HOMEPAGE="https://github.com/cantino/mcfly"
SRC_URI="
https://api.github.com/repos/cantino/mcfly/tarball/v0.9.4 -> mcfly-0.9.4-17f03db.tar.gz
mirror://macaroni/mcfly-0.9.4-mark-rust-bundle-17f03db.tar.xz -> mcfly-0.9.4-mark-rust-bundle-17f03db.tar.xz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
BDEPEND="virtual/rust
"
RDEPEND="dev-db/sqlite
	
"
DEPEND="${RDEPEND}
"
src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/cantino-mcfly-* ${S} || die
}
src_install() {
	cargo_src_install
	insinto "/usr/share/mcfly"
	doins "mcfly".{bash,fish,zsh}
	einstalldocs
}
pkg_postinst() {
	elog "To start using mcfly, add the following to your shell:"
	elog
	elog "~/.bashrc"
	local p="${EPREFIX}/usr/share/mcfly/mcfly.bash"
	elog "[[ -f ${p} ]] && source ${p}"
	elog
	elog "~/.config/fish/config.fish"
	local p="${EPREFIX}/usr/share/mcfly/mcfly.fish"
	elog "if test -r ${p}"
	elog "    source ${p}"
	elog "    mcfly_key_bindings"
	elog
	elog "~/.zsh"
	local p="${EPREFIX}/usr/share/mcfly/mcfly.zsh"
	elog "[[ -f ${p} ]] && source ${p}"
}


# vim: filetype=ebuild
