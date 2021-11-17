# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="JOSE protocol implementation in Python"
HOMEPAGE="https://github.com/certbot/josepy https://pypi.org/project/josepy/"
SRC_URI="https://files.pythonhosted.org/packages/29/00/5391c3cef85d042ce2f40bf702428d10394ff932fc19dba086b52b00fe9f/josepy-1.11.0.tar.gz
"

DEPEND=""
RDEPEND=""

IUSE=""
SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="*"

S="${WORKDIR}/josepy-1.11.0"