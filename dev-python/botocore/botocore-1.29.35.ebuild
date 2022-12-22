# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION=""
HOMEPAGE="https://github.com/boto/botocore https://pypi.org/project/botocore/"
SRC_URI="https://files.pythonhosted.org/packages/ab/9f/2b1d4b28f3c40d0827de9b9027e0e3c41967b685cdae67aa64dea746eec4/botocore-1.29.35.tar.gz -> botocore-1.29.35.tar.gz
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
S="${WORKDIR}/botocore-1.29.35"