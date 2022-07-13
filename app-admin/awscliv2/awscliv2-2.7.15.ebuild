# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="v2 of the Universal Command Line Interface for Amazon Web Services"
HOMEPAGE="https://github.com/aws/aws-cli/tree/v2"
SRC_URI="https://github.com/aws/aws-cli/tarball/43fcd1a0e6e38e72c5f40261806d7dec294abdd9 -> aws-cli-2.7.15-43fcd1a.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE=""

DEPEND=""
RDEPEND="
	dev-python/aws-crt-python
	dev-python/colorama
	dev-python/distro
	dev-python/jmespath
	dev-python/prompt_toolkit
	dev-python/python-dateutil
	dev-python/ruamel-yaml
	!app-admin/awscli
	!app-admin/awscli-bin
"
BDEPEND=""

post_src_unpack() {
	if [ ! -d "${S}" ] ; then
		mv "${WORKDIR}"/aws-aws-cli-* "${S}" || die
	fi
}