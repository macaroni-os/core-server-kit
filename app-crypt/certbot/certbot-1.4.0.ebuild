# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3+ )

SRC_URI="https://files.pythonhosted.org/packages/7c/63/c6f81f0b7d860a6b3b4b80715101724592e19be2a8e6dd0a25aea0889f1a/certbot-1.4.0.tar.gz -> certbot-1.4.0.tar.gz"
KEYWORDS="*"

inherit distutils-r1

DESCRIPTION="Let's encrypt client to automate deployment of X.509 certificates"
HOMEPAGE="https://github.com/certbot/certbot https://letsencrypt.org/"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

CDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="
	${CDEPEND}
	>=app-crypt/acme-0.40.0[${PYTHON_USEDEP}]
	>=dev-python/configargparse-0.9.3[${PYTHON_USEDEP}]
	dev-python/configobj[${PYTHON_USEDEP}]
	>=dev-python/cryptography-2.8[${PYTHON_USEDEP}]
	>=dev-python/distro-1.0.1[${PYTHON_USEDEP}]
	>=dev-python/josepy-1.1.0[${PYTHON_USEDEP}]
	dev-python/mock[${PYTHON_USEDEP}]
	>=dev-python/parsedatetime-1.3[${PYTHON_USEDEP}]
	dev-python/pyrfc3339[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/zope-component[${PYTHON_USEDEP}]
	dev-python/zope-interface[${PYTHON_USEDEP}]"
DEPEND="${CDEPEND}"

distutils_enable_tests pytest

python_prepare_all() {
	# required as deps of deps can trigger this too...
	echo '    ignore:.*collections\.abc:DeprecationWarning' >> ../pytest.ini
	distutils-r1_python_prepare_all
}