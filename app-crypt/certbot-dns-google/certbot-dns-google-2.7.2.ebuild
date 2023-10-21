# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3+ )

SRC_URI="https://files.pythonhosted.org/packages/58/ac/f879ffd410048167988f89176f2d29f52ef0070f88cd237ef79abc03d1d4/certbot-dns-google-2.7.2.tar.gz -> certbot-dns-google-2.7.2.tar.gz"
KEYWORDS="*"

inherit distutils-r1

DESCRIPTION="Google Cloud DNS Authenticator plugin for Certbot"
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
	dev-python/httplib2[${PYTHON_USEDEP}]
	>=dev-python/oauth2client-4.0[${PYTHON_USEDEP}]
	>=dev-python/google-api-python-client-1.5.5[${PYTHON_USEDEP}]"
DEPEND="${CDEPEND}"