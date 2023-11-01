# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="An Amazon S3 Transfer Manager"
HOMEPAGE="https://github.com/boto/s3transfer https://pypi.org/project/s3transfer/"
SRC_URI="https://files.pythonhosted.org/packages/3f/ff/5fd9375f3fe467263cff9cad9746fd4c4e1399440ea9563091c958ff90b5/s3transfer-0.7.0.tar.gz -> s3transfer-0.7.0.tar.gz"

DEPEND=""
IUSE=""
SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="*"
S="${WORKDIR}/s3transfer-0.7.0"