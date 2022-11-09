# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION=""
HOMEPAGE="https://github.com/boto/boto3 https://pypi.org/project/boto3/"
SRC_URI="https://files.pythonhosted.org/packages/db/09/8ac167664014a49131abcc67b5977d7ea0e896f8b00a42f1ef829575798b/boto3-1.26.5.tar.gz -> boto3-1.26.5.tar.gz
"

DEPEND=""
RDEPEND="
	dev-python/botocore[${PYTHON_USEDEP}]
	dev-python/jmespath[${PYTHON_USEDEP}]
	dev-python/s3transfer[${PYTHON_USEDEP}]"

IUSE=""
SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="*"
S="${WORKDIR}/boto3-1.26.5"