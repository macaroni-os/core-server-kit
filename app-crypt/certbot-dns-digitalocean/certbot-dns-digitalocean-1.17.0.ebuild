# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3+ )

SRC_URI="https://files.pythonhosted.org/packages/dd/a6/19b13d0b04f3d7c320f623bd80c7ea043250df798f5977488f34cd5803bb/certbot-dns-digitalocean-1.17.0.tar.gz"
KEYWORDS="*"

inherit distutils-r1

DESCRIPTION="DigitalOcean DNS Authenticator plugin for Certbot"
HOMEPAGE="https://github.com/certbot/certbot https://letsencrypt.org/"

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

CDEPEND=">=dev-python/setuptools-1.0[${PYTHON_USEDEP}]"
RDEPEND="${CDEPEND}
	>=app-crypt/certbot-1.1.0[${PYTHON_USEDEP}]
	>=app-crypt/acme-0.29.0[${PYTHON_USEDEP}]
	>=dev-python/python-digitialocean-1.11[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/zope-interface[${PYTHON_USEDEP}]"
DEPEND="${CDEPEND}"