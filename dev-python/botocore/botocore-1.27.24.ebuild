# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Low-level, data-driven core of boto 3."
HOMEPAGE="https://github.com/boto/botocore https://pypi.org/project/botocore/"
SRC_URI="https://files.pythonhosted.org/packages/10/04/8ff7149d8b43cf75e15e117bb85ca36965721c0c2ee3c55539a103961976/botocore-1.27.24.tar.gz
"

DEPEND="dev-python/tomli[${PYTHON_USEDEP}]"
RDEPEND="
	dev-python/jmespath[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]"

IUSE=""
SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="*"
S="${WORKDIR}/botocore-1.27.24"