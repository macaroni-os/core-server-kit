# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PN="${PN/PEAR-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="The Log framework provides an abstracted logging system"
HOMEPAGE="http://pear.php.net/package/${MY_PN}"
SRC_URI="https://github.com/pear/Log/tarball/f1ce70cfc8ee30af93c313f4e6444a7abe6aea03 -> Log-1.14.4-f1ce70c.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE="examples test"

# The DB, Mail, and MDB2 dependencies are technically optional, but
# automagic. To avoid surprises, we require them unconditionally.
RDEPEND="dev-lang/php:*
	dev-php/PEAR-PEAR
	dev-php/PEAR-DB
	dev-php/PEAR-Mail
	dev-php/PEAR-MDB2"
DEPEND="test? ( ${RDEPEND} )"

S="${WORKDIR}/${MY_P}"

post_src_unpack() {
    if [ ! -d "${S}" ] ; then
        mv ${WORKDIR}/pear-* ${S} || die
    fi
}

src_install() {
	dodoc docs/guide.txt misc/log.sql
	use examples && dodoc -r examples

	# I don't like installing "Log.php" right at the top-level, but any
	# packages depending on us will expect to find it there and not as
	# e.g. Log/Log.php.
	insinto "/usr/share/php/"
	doins Log.php
	doins -r Log
}

src_test() {
	# Requires the "pear" executable from dev-php/PEAR-PEAR.
	pear run-tests tests || die

	# The command succeeds regardless of whether or not the test suite
	# passed, but this file is only written when there was a failure.
	[[ -f run-tests.log ]] && die "test suite failed"
}