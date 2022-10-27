# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION=""
HOMEPAGE="https://github.com/boto/boto3 https://pypi.org/project/boto3/"
SRC_URI="https://files.pythonhosted.org/packages/a9/00/8c503ad7bf04fe7671cf6728a59a44639bfc7a52a4a6d9e5d43b951b78ab/boto3-1.25.2.tar.gz -> boto3-1.25.2.tar.gz
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
S="${WORKDIR}/boto3-1.25.2"