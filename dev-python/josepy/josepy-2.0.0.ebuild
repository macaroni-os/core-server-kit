# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
DISTUTILS_USE_PEP517="poetry"
inherit distutils-r1

DESCRIPTION="JOSE protocol implementation in Python"
HOMEPAGE="None https://pypi.org/project/josepy/"
SRC_URI="https://files.pythonhosted.org/packages/a9/29/e7c14150f200c5cd49d1a71b413f61b97406f57872ad693857982c0869c9/josepy-2.0.0.tar.gz -> josepy-2.0.0.tar.gz"

DEPEND=""
RDEPEND="
	>=dev-python/cryptography-1.5[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	dev-python/sphinx[${PYTHON_USEDEP}]
	dev-python/sphinx_rtd_theme[${PYTHON_USEDEP}]"
IUSE=""
SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="*"
S="${WORKDIR}/josepy-2.0.0"