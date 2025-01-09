# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Low-level, data-driven core of boto 3."
HOMEPAGE="https://github.com/boto/botocore https://pypi.org/project/botocore/"
SRC_URI="https://files.pythonhosted.org/packages/d8/b7/1cf5da213ce2e00a5bcd480a9355aa23f787e11ef63eecb637bd7e48deef/botocore-1.35.95.tar.gz -> botocore-1.35.95.tar.gz"

DEPEND="dev-python/tomli[${PYTHON_USEDEP}]"
RDEPEND="
	dev-python/jmespath[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]"
IUSE=""
SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="*"
S="${WORKDIR}/botocore-1.35.95"