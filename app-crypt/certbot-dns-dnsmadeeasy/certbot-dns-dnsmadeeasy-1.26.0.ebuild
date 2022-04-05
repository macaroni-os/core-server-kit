# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3+ )

SRC_URI="https://files.pythonhosted.org/packages/c3/0b/8f35d2fa77e19f849b63ef89818ae48a4a9ae74ea8ed178853c7990d0df8/certbot-dns-dnsmadeeasy-1.26.0.tar.gz"
KEYWORDS="*"

inherit distutils-r1

DESCRIPTION="DNS Made Easy DNS Authenticator plugin for Certbot"
HOMEPAGE="https://github.com/certbot/certbot https://letsencrypt.org/"

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

CDEPEND=">=dev-python/setuptools-1.0[${PYTHON_USEDEP}]"
RDEPEND="${CDEPEND}
	>=app-crypt/certbot-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/acme-0.31.0[${PYTHON_USEDEP}]
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/zope-interface[${PYTHON_USEDEP}
	>=dev-python/dns-lexicon-2.2.1[${PYTHON_USEDEP}]"
DEPEND="${CDEPEND}"