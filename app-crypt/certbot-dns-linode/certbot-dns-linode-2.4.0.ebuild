# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3+ )

SRC_URI="https://files.pythonhosted.org/packages/e4/b0/abfdc7e7d76f8010ad55793bbfa98a82dd28ee3ad58b1ac86c47833681d8/certbot-dns-linode-2.4.0.tar.gz -> certbot-dns-linode-2.4.0.tar.gz"
KEYWORDS="*"

inherit distutils-r1

DESCRIPTION="Linode DNS Authenticator plugin for Certbot"
HOMEPAGE="https://github.com/certbot/certbot https://letsencrypt.org/"

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

CDEPEND=">=dev-python/setuptools-1.0[${PYTHON_USEDEP}]"
RDEPEND="${CDEPEND}
	>=app-crypt/certbot-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/acme-0.31.0[${PYTHON_USEDEP}]
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/zope-interface[${PYTHON_USEDEP}]
	>=dev-python/dns-lexicon-2.2.3[${PYTHON_USEDEP}]"
DEPEND="${CDEPEND}"