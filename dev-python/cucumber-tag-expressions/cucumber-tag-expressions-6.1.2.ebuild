# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Provides a tag-expression parser and evaluation logic for cucumber/behave"
HOMEPAGE="None https://pypi.org/project/cucumber-tag-expressions/"
SRC_URI="https://files.pythonhosted.org/packages/3d/1e/49c8695e628c3751349ee3055ed46a37c114f3a9ddff8044f78ab8c4e0a5/cucumber_tag_expressions-6.1.2.tar.gz -> cucumber_tag_expressions-6.1.2.tar.gz"

DEPEND=""
IUSE=""
SLOT="0"
LICENSE="MIT"
KEYWORDS="*"
S="${WORKDIR}/cucumber_tag_expressions-6.1.2"