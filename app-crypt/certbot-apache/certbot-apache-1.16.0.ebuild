# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3+ )

SRC_URI="https://files.pythonhosted.org/packages/7a/6b/48a749f9da63a81ac882bc532cd7208cd186588ce40d4c9db50b6db551d2/certbot-apache-1.16.0.tar.gz"
KEYWORDS="*"

inherit distutils-r1

DESCRIPTION="Apache plugin for certbot (Let's Encrypt Client)"
HOMEPAGE="https://github.com/certbot/certbot https://letsencrypt.org/"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND=">=app-crypt/acme-0.29.0[${PYTHON_USEDEP}]
	>=app-crypt/certbot-1.1.0[${PYTHON_USEDEP}]
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/python-augeas[${PYTHON_USEDEP}]
	dev-python/zope-component[${PYTHON_USEDEP}]
	dev-python/zope-interface[${PYTHON_USEDEP}]"
DEPEND="test? ( ${RDEPEND}
	dev-python/nose[${PYTHON_USEDEP}] )
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_test() {
	nosetests || die
}