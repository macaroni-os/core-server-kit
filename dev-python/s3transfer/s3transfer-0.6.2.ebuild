# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="An Amazon S3 Transfer Manager"
HOMEPAGE="https://github.com/boto/s3transfer https://pypi.org/project/s3transfer/"
SRC_URI="https://files.pythonhosted.org/packages/5a/47/d676353674e651910085e3537866f093d2b9e9699e95e89d960e78df9ecf/s3transfer-0.6.2.tar.gz -> s3transfer-0.6.2.tar.gz
"

DEPEND=""
IUSE=""
SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="*"
S="${WORKDIR}/s3transfer-0.6.2"