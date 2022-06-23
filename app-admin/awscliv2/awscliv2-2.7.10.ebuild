# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="v2 of the Universal Command Line Interface for Amazon Web Services"
HOMEPAGE="https://github.com/aws/aws-cli/tree/v2"
SRC_URI="https://github.com/aws/aws-cli/tarball/2f6b2d775f78fcb26ad82dcb915656881b274f58 -> aws-cli-2.7.10-2f6b2d7.tar.gz"

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