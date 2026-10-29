# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
DISTUTILS_USE_PEP517=standalone
inherit distutils-r1

DESCRIPTION="Universal Command Line Environment for AWS"
HOMEPAGE="https://github.com/aws/aws-cli"
SRC_URI="https://api.github.com/repos/aws/aws-cli/tarball/refs/tags/2.39.0 -> awscliv2-2.39.0-ad3e46f.tar.gz"
LICENSE="Apache-2.0 BSD"
SLOT="0"
KEYWORDS="*"
BDEPEND="dev-python/flit_core[${PYTHON_USEDEP}]
	
"
RDEPEND="!app-admin/awscli
	!app-admin/awscli-bin
	dev-python/aws-crt-python[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/distro[${PYTHON_USEDEP}]
	dev-python/docutils[${PYTHON_USEDEP}]
	dev-python/jmespath[${PYTHON_USEDEP}]
	dev-python/prompt_toolkit[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/ruamel-yaml[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
	dev-python/wcwidth[${PYTHON_USEDEP}]
	
"

post_src_unpack() {
	mv aws-aws-cli-* ${S}
}



# vim: filetype=ebuild
