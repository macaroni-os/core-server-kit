# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="Library for handling version information and constraints"
HOMEPAGE="https://github.com/phar-io/version"
SRC_URI="https://github.com/phar-io/version/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="*"
IUSE=""

S="${WORKDIR}/version-${PV}"

RDEPEND="dev-php/fedora-autoloader
	dev-lang/php:*"

src_install() {
	insinto /usr/share/php/PharIo/Version
	doins src/*.php
	doins "${FILESDIR}/autoload.php"
	dodoc README.md
}
