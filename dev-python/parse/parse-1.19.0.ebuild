# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="parse() is the opposite of format()"
HOMEPAGE="https://github.com/r1chardj0n3s/parse https://pypi.org/project/parse/"
SRC_URI="https://files.pythonhosted.org/packages/89/a1/82ce536be577ba09d4dcee45db58423a180873ad38a2d014d26ab7b7cb8a/parse-1.19.0.tar.gz
"

DEPEND=""
RDEPEND=""

IUSE=""
SLOT="0"
LICENSE="MIT"
KEYWORDS="*"

S="${WORKDIR}/parse-1.19.0"