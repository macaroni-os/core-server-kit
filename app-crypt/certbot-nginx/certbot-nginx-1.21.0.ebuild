# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3+ )

SRC_URI="https://files.pythonhosted.org/packages/fb/e3/a1d4f4ba901f99a0c900921aa3abe14fec51fe25bc3a2d0b2066ed7c2a86/certbot-nginx-1.21.0.tar.gz"
KEYWORDS="*"

inherit distutils-r1

DESCRIPTION="Nginx plugin for certbot (Let's Encrypt Client)"
HOMEPAGE="https://github.com/certbot/certbot https://letsencrypt.org/"

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

CDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${CDEPEND}
	>=dev-python/acme-1.0.0[${PYTHON_USEDEP}]
	>=app-crypt/certbot-1.1.0[${PYTHON_USEDEP}]
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	>=dev-python/pyparsing-1.5.5[${PYTHON_USEDEP}]
	dev-python/zope-interface[${PYTHON_USEDEP}]"
DEPEND="${CDEPEND}"