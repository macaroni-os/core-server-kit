# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
NPM_DEFAULT_OPTS="-E --force"
inherit npmv1

DESCRIPTION="Incus UI web application"
HOMEPAGE="https://github.com/zabbly/incus-ui-canonical"
SRC_URI="https://api.github.com/repos/zabbly/incus-ui-canonical/tarball/refs/tags/incus-0.22.0 -> incus-ui-0.22.0-118b369.tar.gz"
LICENSE="GPL-3.0"
SLOT="0"
KEYWORDS="*"
RESTRICT="network-sandbox"

post_src_unpack() {
	mv zabbly-incus-ui-canonical-* ${S}
}


src_prepare() {
	npmv1_src_prepare
	# Replace the function running git command for retrieve sha
	sed -i -e 's|.*rev-parse.*|  const result \= "118b369445dedbd4f9721830dee49e6a2fc5c999"\;|g' vite.config.ts
}
src_compile() {
	npmv1_src_compile
	npm run build
}
src_install() {
	dodir /usr/share/incus-ui
	insinto /usr/share/incus-ui
	doins -r build/ui/*
}



# vim: filetype=ebuild
