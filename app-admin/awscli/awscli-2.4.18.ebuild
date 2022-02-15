# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

MY_PN=aws-cli
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Universal Command Line Interface for Amazon Web Services"
HOMEPAGE="https://github.com/aws/aws-cli/tree/v2"
SRC_URI="https://github.com/aws/aws-cli/tarball/2dc95b00fc398fff714f2a6ad9a67426d5f6f726 -> aws-cli-2.4.18-2dc95b0.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE=""

DEPEND=""
RDEPEND="
	dev-python/python-dateutil
	dev-python/jmespath
	dev-python/prompt_toolkit
	dev-python/colorama
	dev-python/ruamel-yaml
	dev-python/aws-crt-python
	!dev-python/awscli
	!app-admin/awscli-bin
"
BDEPEND=""