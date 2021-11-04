# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3+ )

SRC_URI="https://files.pythonhosted.org/packages/3e/9f/b5da3301a47ce8fd6a12e89ea74a85aedda4ad646fd3a371424ef5a2ffc7/certbot-dns-rfc2136-1.21.0.tar.gz"
KEYWORDS="*"

inherit distutils-r1

DESCRIPTION="RFC 2136 DNS Authenticator plugin for Certbot"
HOMEPAGE="https://github.com/certbot/certbot https://letsencrypt.org/"

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

CDEPEND=">=dev-python/setuptools-1.0[${PYTHON_USEDEP}]"
RDEPEND="${CDEPEND}
	>=app-crypt/certbot-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/acme-0.29.0[${PYTHON_USEDEP}]
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/zope-interface[${PYTHON_USEDEP}]
	dev-python/dnspython[${PYTHON_USEDEP}]"
DEPEND="${CDEPEND}"