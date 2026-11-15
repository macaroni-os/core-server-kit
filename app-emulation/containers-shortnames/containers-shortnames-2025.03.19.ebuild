# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7

DESCRIPTION="Configures default shortnames (aliases) for containers"
HOMEPAGE="https://github.com/containers/shortnames"
SRC_URI="https://api.github.com/repos/containers/shortnames/tarball/v2025.03.19 -> containers-shortnames-2025.03.19-4b8136e.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"

post_src_unpack() {
	mv containers-shortnames-* ${S}
}


src_configure() {
	:
}
src_compile() {
	:
}
src_install() {
	insinto /etc/containers/registries.conf.d
	newins shortnames.conf 000-shortnames.conf
}



# vim: filetype=ebuild
