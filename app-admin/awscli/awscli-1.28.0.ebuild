# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Universal Command Line Environment for AWS."
HOMEPAGE="http://aws.amazon.com/cli/ https://pypi.org/project/awscli/"
SRC_URI="https://files.pythonhosted.org/packages/82/e8/f4d8f9898411e61d0c7d30ba671339111709ee87d96b7d5a5b84dcb8ddf4/awscli-1.28.0.tar.gz -> awscli-1.28.0.tar.gz
"

DEPEND=""
RDEPEND="
	dev-python/botocore[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/docutils[${PYTHON_USEDEP}]
	dev-python/jmespath[${PYTHON_USEDEP}]
	dev-python/rsa[${PYTHON_USEDEP}]
	dev-python/s3transfer[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]"
IUSE=""
SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="*"
S="${WORKDIR}/awscli-1.28.0"

python_install_all() {
		newbashcomp bin/aws_bash_completer aws

		insinto /usr/share/zsh/site-functions
		newins bin/aws_zsh_completer.sh _aws

		distutils-r1_python_install_all

		rm "${ED}"/usr/bin/{aws.cmd,aws_bash_completer,aws_zsh_completer.sh} || die
}
