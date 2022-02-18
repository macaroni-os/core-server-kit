# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="v2 of the Universal Command Line Interface for Amazon Web Services"
HOMEPAGE="https://github.com/aws/aws-cli/tree/v2"
SRC_URI="https://github.com/aws/aws-cli/tarball/fc19835c43cb269e18be30aaf6b7f7d3bbabd087 -> aws-cli-2.4.19-fc19835.tar.gz"

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

post_src_unpack() {
	if [ ! -d "${S}" ] ; then
		mv "${WORKDIR}"/aws-aws-cli-* "${S}" || die
	fi
}