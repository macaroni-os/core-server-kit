# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="ACME protocol implementation in Python"
HOMEPAGE="https://github.com/certbot/certbot https://pypi.org/project/acme/"
SRC_URI="https://files.pythonhosted.org/packages/97/f7/9a3513b27b2196340d06137d7734e66c95af560ff3330928790bdcf9554a/acme-2.7.4.tar.gz -> acme-2.7.4.tar.gz"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="
	!app-crypt/acme[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/cryptography-2.1.4[${PYTHON_USEDEP}]
	>=dev-python/josepy-1.9.0[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-17.3.0[${PYTHON_USEDEP}]
	dev-python/pyrfc3339[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/requests-toolbelt[${PYTHON_USEDEP}]"
IUSE=""
SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="*"
S="${WORKDIR}/acme-2.7.4"