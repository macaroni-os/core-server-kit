# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="JSON Matching Expressions"
HOMEPAGE="https://github.com/jmespath/jmespath.py https://pypi.org/project/jmespath/"
SRC_URI="https://files.pythonhosted.org/packages/06/7e/44686b986ef9ca6069db224651baaa8300b93af2a085a5b135997bf659b3/jmespath-1.0.0.tar.gz
"

DEPEND=""
RDEPEND=""

IUSE=""
SLOT="0"
LICENSE="MIT"
KEYWORDS="*"

S="${WORKDIR}/jmespath-1.0.0"