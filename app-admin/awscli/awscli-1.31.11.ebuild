# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Universal Command Line Environment for AWS."
HOMEPAGE="http://aws.amazon.com/cli/ https://pypi.org/project/awscli/"
SRC_URI="https://files.pythonhosted.org/packages/ea/b3/b58518300635953677a81c05d095e28533098c2bbc78a1ca4e95e20dac39/awscli-1.31.11.tar.gz -> awscli-1.31.11.tar.gz"

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
S="${WORKDIR}/awscli-1.31.11"

python_install_all() {
		newbashcomp bin/aws_bash_completer aws

		insinto /usr/share/zsh/site-functions
		newins bin/aws_zsh_completer.sh _aws

		distutils-r1_python_install_all

		rm "${ED}"/usr/bin/{aws.cmd,aws_bash_completer,aws_zsh_completer.sh} || die
}
