# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
DISTUTILS_USE_PEP517="poetry"
inherit distutils-r1

DESCRIPTION="JOSE protocol implementation in Python"
HOMEPAGE="https://github.com/certbot/josepy https://pypi.org/project/josepy/"
SRC_URI="https://files.pythonhosted.org/packages/2c/cd/684c45107851da4507854ef4b16fcdce448e02668f0e7c359d0558cbfbeb/josepy-1.14.0.tar.gz -> josepy-1.14.0.tar.gz"

DEPEND=""
RDEPEND="
	>=dev-python/cryptography-1.5[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	dev-python/sphinx[${PYTHON_USEDEP}]
	dev-python/sphinx-rtd-theme[${PYTHON_USEDEP}]"
IUSE=""
SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="*"
S="${WORKDIR}/josepy-1.14.0"