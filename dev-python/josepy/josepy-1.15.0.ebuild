# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
DISTUTILS_USE_PEP517="poetry"
inherit distutils-r1

DESCRIPTION="JOSE protocol implementation in Python"
HOMEPAGE="https://github.com/certbot/josepy https://pypi.org/project/josepy/"
SRC_URI="https://files.pythonhosted.org/packages/c1/8a/cd416f56cd4492878e8d62701b4ad32407c5ce541f247abf31d6e5f3b79b/josepy-1.15.0.tar.gz -> josepy-1.15.0.tar.gz"

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
S="${WORKDIR}/josepy-1.15.0"