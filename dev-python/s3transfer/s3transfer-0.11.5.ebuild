# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="An Amazon S3 Transfer Manager"
HOMEPAGE="https://github.com/boto/s3transfer https://pypi.org/project/s3transfer/"
SRC_URI="https://files.pythonhosted.org/packages/c4/2b/5c9562795c2eb2b5f63536961754760c25bf0f34af93d36aa28dea2fb303/s3transfer-0.11.5.tar.gz -> s3transfer-0.11.5.tar.gz"

DEPEND=""
IUSE=""
SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="*"
S="${WORKDIR}/s3transfer-0.11.5"