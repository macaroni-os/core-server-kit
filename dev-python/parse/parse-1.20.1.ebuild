# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="parse() is the opposite of format()"
HOMEPAGE=" https://pypi.org/project/parse/"
SRC_URI="https://files.pythonhosted.org/packages/22/08/63ad287eaded9f6bbaabb08f82da03c0eb106eb1fa0aac29663a32ea3c6a/parse-1.20.1.tar.gz -> parse-1.20.1.tar.gz"

DEPEND=""
IUSE=""
SLOT="0"
LICENSE="MIT"
KEYWORDS="*"
S="${WORKDIR}/parse-1.20.1"