# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Fly through your shell history. Great Scott!"
HOMEPAGE="https://github.com/cantino/mcfly"
SRC_URI="https://github.com/cantino/mcfly/tarball/4e96d87be5722881cff02ebf574190c85f998cf1 -> mcfly-0.9.3-4e96d87.tar.gz
https://distfiles.macaronios.org/f7/7f/9b/f77f9bf00202124384cf768e8fc8767bb518d53d3ccff8024205d5a4464eadaaa15b5ca389515e866b453e43fc257c76b93f15a7109da2abf8382311ccb0da91 -> mcfly-0.9.3-funtoo-crates-bundle-9a392e00cb8de4c08a4a52f33f4573a11891bf1e7394a8ec36bbd2f2610b55360416c5e07f0828394d9caf48f2616e924afda1a296525eb0875f1ee42d480b92.tar.gz"

LICENSE="Apache-2.0 BSD BSD-2 CC0-1.0 MIT Unlicense"
SLOT="0"
KEYWORDS="*"

DEPEND="dev-db/sqlite:3"
RDEPEND="${DEPEND}"
BDEPEND="virtual/rust"

QA_FLAGS_IGNORED="/usr/bin/mcfly"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/cantino-mcfly-* ${S} || die
}

src_install() {
	cargo_src_install

	insinto "/usr/share/${PN}"
	doins "${PN}".{bash,fish,zsh}

	einstalldocs
}

pkg_postinst() {

	elog "To start using ${PN}, add the following to your shell:"
	elog
	elog "~/.bashrc"
	local p="${EPREFIX}/usr/share/${PN}/${PN}.bash"
	elog "[[ -f ${p} ]] && source ${p}"
	elog
	elog "~/.config/fish/config.fish"
	local p="${EPREFIX}/usr/share/${PN}/${PN}.fish"
	elog "if test -r ${p}"
	elog "    source ${p}"
	elog "    mcfly_key_bindings"
	elog
	elog "~/.zsh"
	local p="${EPREFIX}/usr/share/${PN}/${PN}.zsh"
	elog "[[ -f ${p} ]] && source ${p}"
}