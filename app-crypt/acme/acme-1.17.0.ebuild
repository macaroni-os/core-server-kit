# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3+ )

SRC_URI="https://files.pythonhosted.org/packages/1d/f7/a45147f334184b448408b2a91edd009971b629740b05ec8ead592d0f0da8/acme-1.17.0.tar.gz"
KEYWORDS="*"

inherit distutils-r1

DESCRIPTION="ACME protocol implementation in Python"
HOMEPAGE="https://github.com/certbot/certbot https://letsencrypt.org/"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

CDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="
	${CDEPEND}
	>=dev-python/pyopenssl-0.13.1[${PYTHON_USEDEP}]
	>=dev-python/cryptography-1.2.3[${PYTHON_USEDEP}]
	>=dev-python/josepy-1.1.0[${PYTHON_USEDEP}]
	dev-python/mock[${PYTHON_USEDEP}]
	>=dev-python/six-1.9.0[${PYTHON_USEDEP}]
	dev-python/pyrfc3339[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/requests-toolbelt[${PYTHON_USEDEP}]
	>=dev-python/requests-2.6.0[${PYTHON_USEDEP}]"
DEPEND="${CDEPEND}"

distutils_enable_tests pytest

python_prepare_all() {
	# required as deps of deps can trigger this too...
	echo '    ignore:.*collections\.abc:DeprecationWarning' >> ../pytest.ini
	distutils-r1_python_prepare_all
}