# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION=""
HOMEPAGE="https://github.com/boto/s3transfer https://pypi.org/project/s3transfer/"
SRC_URI="https://files.pythonhosted.org/packages/49/bd/def2ab4c04063a5e114963aae90bcd3e3aca821a595124358b3b00244407/s3transfer-0.6.1.tar.gz -> s3transfer-0.6.1.tar.gz
"

DEPEND=""
RDEPEND="
	$(python_gen_cond_dep '
	>=dev-python/futures-2.2.0[${PYTHON_USEDEP}]
	<dev-python/futures-4.0.0[${PYTHON_USEDEP}]
	' -2
	)"

IUSE=""
SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="*"
S="${WORKDIR}/s3transfer-0.6.1"