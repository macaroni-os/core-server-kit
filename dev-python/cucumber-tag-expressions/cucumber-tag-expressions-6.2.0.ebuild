# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Provides a tag-expression parser and evaluation logic for cucumber/behave"
HOMEPAGE="None https://pypi.org/project/cucumber-tag-expressions/"
SRC_URI="https://files.pythonhosted.org/packages/a2/81/32a2dc51c0720b34f642a6e79da6d89525c1eafd8902798026c233201f6f/cucumber_tag_expressions-6.2.0.tar.gz -> cucumber_tag_expressions-6.2.0.tar.gz"

DEPEND=""
IUSE=""
SLOT="0"
LICENSE="MIT"
KEYWORDS="*"
S="${WORKDIR}/cucumber_tag_expressions-6.2.0"