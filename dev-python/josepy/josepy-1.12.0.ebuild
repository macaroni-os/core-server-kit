# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="JOSE protocol implementation in Python"
HOMEPAGE="https://github.com/certbot/josepy https://pypi.org/project/josepy/"
SRC_URI="https://files.pythonhosted.org/packages/e1/e1/e531cc19a0b74b1d09877a67b5935e0be22e2cbbf15cecb36ec97378b644/josepy-1.12.0.tar.gz
"

DEPEND=""
RDEPEND=""

IUSE=""
SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="*"

S="${WORKDIR}/josepy-1.12.0"