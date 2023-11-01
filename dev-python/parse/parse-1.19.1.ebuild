# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="parse() is the opposite of format()"
HOMEPAGE=" https://pypi.org/project/parse/"
SRC_URI="https://files.pythonhosted.org/packages/29/d9/a874f3b01b618dae366de5d18c529d961dddf58eccca5c99ba691040325e/parse-1.19.1.tar.gz -> parse-1.19.1.tar.gz"

DEPEND=""
IUSE=""
SLOT="0"
LICENSE="MIT"
KEYWORDS="*"
S="${WORKDIR}/parse-1.19.1"