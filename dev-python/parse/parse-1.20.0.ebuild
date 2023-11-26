# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="parse() is the opposite of format()"
HOMEPAGE=" https://pypi.org/project/parse/"
SRC_URI="https://files.pythonhosted.org/packages/c4/69/5d4f4e827bdff9682327cdd696abadf55d311ab94724282e99a34a736d51/parse-1.20.0.tar.gz -> parse-1.20.0.tar.gz"

DEPEND=""
IUSE=""
SLOT="0"
LICENSE="MIT"
KEYWORDS="*"
S="${WORKDIR}/parse-1.20.0"