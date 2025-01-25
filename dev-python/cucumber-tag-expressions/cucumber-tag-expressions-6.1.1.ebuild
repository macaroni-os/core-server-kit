# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Provides a tag-expression parser and evaluation logic for cucumber/behave"
HOMEPAGE="None https://pypi.org/project/cucumber-tag-expressions/"
SRC_URI="https://files.pythonhosted.org/packages/5d/bb/38e1fbb680695d5265355caaaed015a5268c94a570a75f24e1838d7f7708/cucumber_tag_expressions-6.1.1.tar.gz -> cucumber_tag_expressions-6.1.1.tar.gz"

DEPEND=""
IUSE=""
SLOT="0"
LICENSE="MIT"
KEYWORDS="*"
S="${WORKDIR}/cucumber_tag_expressions-6.1.1"