# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3+ )

SRC_URI="https://files.pythonhosted.org/packages/0a/88/8a7dc5d9e4f83c099a52aa1505b58face8420dbf5735082e7fbf6d4536da/certbot_dns_nsone-3.1.0.tar.gz -> certbot_dns_nsone-3.1.0.tar.gz"
KEYWORDS="*"

inherit distutils-r1

DESCRIPTION="NS1 DNS Authenticator plugin for Certbot (Let's Encrypt Client)"
HOMEPAGE="https://github.com/certbot/certbot https://letsencrypt.org/"

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

CDEPEND=">=dev-python/setuptools-1.0[${PYTHON_USEDEP}]"
RDEPEND="${CDEPEND}
	>=app-crypt/certbot-0.31.0[${PYTHON_USEDEP}]
	>=dev-python/acme-0.39.0[${PYTHON_USEDEP}]
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/zope-interface[${PYTHON_USEDEP}]
	>=dev-python/dns-lexicon-2.2.1[${PYTHON_USEDEP}]"
DEPEND="${CDEPEND}"