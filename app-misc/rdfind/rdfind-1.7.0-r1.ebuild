# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Find duplicate files based on their content"
HOMEPAGE="https://github.com/pauldreik/rdfind"
SRC_URI="https://github.com/pauldreik/rdfind/tarball/4c0b37733434376b86d407a9c1582ec14bfa47bb -> rdfind-1.7.0-4c0b377.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="*"

RDEPEND="dev-libs/nettle:="
DEPEND="${RDEPEND}"
BDEPEND="sys-devel/autoconf-archive"

post_src_unpack() {
	if [ ! -d "${S}" ]; then
		mv "${WORKDIR}"/* "${S}" || die
	fi
}

src_prepare() {
	default
	eautoreconf
}

src_test() {
	# Bug 840544
	local -x SANDBOX_PREDICT="${SANDBOX_PREDICT}"
	addpredict /
	default
}