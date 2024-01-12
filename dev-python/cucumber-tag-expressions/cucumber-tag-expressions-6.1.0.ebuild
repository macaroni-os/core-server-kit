# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Provides a tag-expression parser and evaluation logic for cucumber/behave"
HOMEPAGE="https://github.com/cucumber/tag-expressions https://pypi.org/project/cucumber-tag-expressions/"
SRC_URI="https://files.pythonhosted.org/packages/6f/9b/b90d1a022d9d81d6b4bc2d1e212cbdab1482bf58c0de319378087ae5f513/cucumber-tag-expressions-6.1.0.tar.gz -> cucumber-tag-expressions-6.1.0.tar.gz"

DEPEND=""
IUSE=""
SLOT="0"
LICENSE="BSD"
KEYWORDS="*"
S="${WORKDIR}/cucumber-tag-expressions-6.1.0"