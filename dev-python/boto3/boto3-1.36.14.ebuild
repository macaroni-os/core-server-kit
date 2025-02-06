# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="The AWS SDK for Python"
HOMEPAGE="https://github.com/boto/boto3 https://pypi.org/project/boto3/"
SRC_URI="https://files.pythonhosted.org/packages/20/78/2bef75ba63337615b9582287b47bdf577890b153a090cd69af6d3b89fef0/boto3-1.36.14.tar.gz -> boto3-1.36.14.tar.gz"

DEPEND=""
RDEPEND="
	dev-python/botocore[${PYTHON_USEDEP}]
	dev-python/jmespath[${PYTHON_USEDEP}]
	dev-python/s3transfer[${PYTHON_USEDEP}]"
IUSE=""
SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="*"
S="${WORKDIR}/boto3-1.36.14"