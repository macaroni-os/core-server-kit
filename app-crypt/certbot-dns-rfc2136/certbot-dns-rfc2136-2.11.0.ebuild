# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3+ )

SRC_URI="https://files.pythonhosted.org/packages/99/33/afed0ff25bf60681047c8dadc58c7da484363d99cdfd1be3be6dccbe1632/certbot_dns_rfc2136-2.11.0.tar.gz -> certbot_dns_rfc2136-2.11.0.tar.gz"
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