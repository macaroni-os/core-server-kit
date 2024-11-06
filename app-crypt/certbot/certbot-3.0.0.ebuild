# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="ACME client"
HOMEPAGE="https://github.com/certbot/certbot https://pypi.org/project/certbot/"
SRC_URI="https://files.pythonhosted.org/packages/43/88/2be7d027cd2def0790d29d58a4287d99b261a24e3eaad2e66c7938527a38/certbot-3.0.0.tar.gz -> certbot-3.0.0.tar.gz"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/acme-1.28.0[${PYTHON_USEDEP}]
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
S="${WORKDIR}/certbot-3.0.0"