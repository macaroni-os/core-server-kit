# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_8+ )
inherit distutils-r1

DESCRIPTION=""
HOMEPAGE="https://github.com/aws/aws-cli"
SRC_URI="https://github.com/aws/aws-cli/tarball/5f942a86a529e48aa15fa959a55a24ab605cfa19 -> aws-cli-2.17.60-5f942a8.tar.gz
"

DEPEND=""
RDEPEND="
	!app-admin/awscli
	!app-admin/awscli-bin
	dev-python/aws-crt-python[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/distro[${PYTHON_USEDEP}]
	dev-python/jmespath[${PYTHON_USEDEP}]
	dev-python/prompt_toolkit[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/ruamel-yaml[${PYTHON_USEDEP}]"

IUSE=""
SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="*"

post_src_unpack() {
	if [ ! -d "${S}" ]; then
		mv "${WORKDIR}"/aws-* "$S" || die
	fi
}

DISTUTILS_USE_PEP517=standalone
