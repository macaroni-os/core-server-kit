# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3+ )

SRC_URI="https://files.pythonhosted.org/packages/bc/e3/89796b46e968fee60f28dfe75456a459c9da9e4c056de92e188504abff69/certbot-dns-sakuracloud-2.10.0.tar.gz -> certbot-dns-sakuracloud-2.10.0.tar.gz"
KEYWORDS="*"

inherit distutils-r1

DESCRIPTION="Sakura Cloud DNS Authenticator plugin for Certbot"
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
	>=dev-python/dns-lexicon-2.1.23[${PYTHON_USEDEP}]"
DEPEND="${CDEPEND}"