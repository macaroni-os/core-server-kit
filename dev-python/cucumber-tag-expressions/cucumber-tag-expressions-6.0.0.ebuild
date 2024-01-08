# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Provides a tag-expression parser and evaluation logic for cucumber/behave"
HOMEPAGE="https://github.com/cucumber/tag-expressions https://pypi.org/project/cucumber-tag-expressions/"
SRC_URI="https://files.pythonhosted.org/packages/b4/11/0f49165a943e6ea268dd77dee0f43e92ba7957cdf912ad14b19d01fc632f/cucumber-tag-expressions-6.0.0.tar.gz -> cucumber-tag-expressions-6.0.0.tar.gz"

DEPEND=""
IUSE=""
SLOT="0"
LICENSE="BSD"
KEYWORDS="*"
S="${WORKDIR}/cucumber-tag-expressions-6.0.0"