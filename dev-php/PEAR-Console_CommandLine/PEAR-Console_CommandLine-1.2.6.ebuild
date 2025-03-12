# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PN="${PN/PEAR-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A full-featured command-line options and arguments parser"
HOMEPAGE="http://pear.php.net/package/${MY_PN}"
SRC_URI="https://github.com/pear/Console_CommandLine/tarball/611c5bff2e47ec5a184748cb5fedc2869098ff28 -> Console_CommandLine-1.2.6-611c5bf.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE="examples test"

# Only needs PEAR_Exception (not yet packaged) -- not all of PEAR-PEAR.
RDEPEND="dev-lang/php:*
	dev-php/PEAR-PEAR"

# Beware, the test suite really needs PEAR-PEAR.
DEPEND="test? ( ${RDEPEND} )"

S="${WORKDIR}/${MY_P}"

post_src_unpack() {
    if [ ! -d "${S}" ] ; then
        mv ${WORKDIR}/pear-* ${S} || die
    fi
}

src_prepare() {
	# There's one occurrence of @data_dir@ that needs to be replaced
	# This location just has to agree with where we put the "data"
	# directory during src_install().
	default
	sed -i "s|@data_dir@|${EPREFIX}/usr/share|" \
		Console/CommandLine/XmlParser.php || die
}

src_install() {
	use examples && dodoc -r docs/examples

	insinto "/usr/share/${MY_PN}"
	doins -r data

	insinto /usr/share/php
	doins -r Console
}

src_test() {
	# Requires the "pear" executable from dev-php/PEAR-PEAR.
	pear run-tests tests || die

	# The command succeeds regardless of whether or not the test suite
	# passed, but this file is only written when there was a failure.
	[[ -f run-tests.log ]] && die "test suite failed"
}