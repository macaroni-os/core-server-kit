# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7

PYTHON_COMPAT=( python3+ )
DISTUTILS_USE_PEP517="setuptools"
inherit distutils-r1

DESCRIPTION="Radically simple IT automation"
HOMEPAGE="https://ansible.com/"
SRC_URI="https://files.pythonhosted.org/packages/19/17/5da525931b5867b4f542c1ef1cdc5b55d28948da7eadf650d9f0f75df0ca/ansible-9.0.1.tar.gz -> ansible-9.0.1.tar.gz
"
RDEPEND="
	virtual/ssh
	net-misc/sshpass

	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/httplib2[${PYTHON_USEDEP}]
	dev-python/importlib_resources[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/netaddr[${PYTHON_USEDEP}]
	dev-python/paramiko[${PYTHON_USEDEP}]
	dev-python/pexpect[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/packaging[${PYTHON_USEDEP}]
"

IUSE=""
SLOT="0"
LICENSE="GPL-3+"
KEYWORDS="*"
S="${WORKDIR}/ansible-9.0.1"
