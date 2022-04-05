# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="ACME client"
HOMEPAGE="https://github.com/letsencrypt/letsencrypt https://pypi.org/project/certbot/"
SRC_URI="https://files.pythonhosted.org/packages/9c/78/90a464a4a10c6ac506243273db9bae4186b36e7c02e47ee613403e7d95cb/certbot-1.26.0.tar.gz
"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/acme-1.20.0[${PYTHON_USEDEP}]
	dev-python/configargparse[${PYTHON_USEDEP}]
	dev-python/configobj[${PYTHON_USEDEP}]
	>=dev-python/cryptography-2.1.4[${PYTHON_USEDEP}]
	dev-python/distro[${PYTHON_USEDEP}]
	dev-python/josepy[${PYTHON_USEDEP}]
	>=dev-python/parsedatetime-2.4[${PYTHON_USEDEP}]
	dev-python/pyrfc3339[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/zope-component[${PYTHON_USEDEP}]
	dev-python/zope-interface[${PYTHON_USEDEP}]"

IUSE=""
SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="*"

S="${WORKDIR}/certbot-1.26.0"