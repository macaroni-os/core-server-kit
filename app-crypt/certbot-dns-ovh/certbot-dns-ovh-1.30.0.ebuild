# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3+ )

SRC_URI="https://files.pythonhosted.org/packages/20/ba/654d9c29c2975d7f89ee9952864e1b927bc8d95618ebd9ea1e129abebe5f/certbot-dns-ovh-1.30.0.tar.gz -> certbot-dns-ovh-1.30.0.tar.gz"
KEYWORDS="*"

inherit distutils-r1

DESCRIPTION="OVH DNS Authenticator plugin for Certbot"
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
	>=dev-python/dns-lexicon-2.7.14[${PYTHON_USEDEP}]"
DEPEND="${CDEPEND}"