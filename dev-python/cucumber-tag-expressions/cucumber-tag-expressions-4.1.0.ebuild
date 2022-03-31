# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Provides tag-expression parser for cucumber/behave"
HOMEPAGE="https://github.com/cucumber/tag-expressions-python https://pypi.org/project/cucumber-tag-expressions/"
SRC_URI="https://files.pythonhosted.org/packages/88/0f/980a044d0592a49460199b117880de1cbbb8e46d9c385c772bf87aa537ef/cucumber-tag-expressions-4.1.0.tar.gz
"

DEPEND=""
RDEPEND=""

IUSE=""
SLOT="0"
LICENSE="BSD"
KEYWORDS="*"

S="${WORKDIR}/cucumber-tag-expressions-4.1.0"