# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit user

MY_PN=${PN/-bin/}
MY_P=${MY_PN}-${PV}

DESCRIPTION="Exporter for machine metrics"
HOMEPAGE="https://github.com/prometheus/node_exporter"
SRC_URI="https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-amd64.tar.gz -> node_exporter-1.3.1.linux-amd64.tar.gz"


KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

DEPEND=""

EXPORTER_USER="${MY_PN}"
EXPORTER_HOME="/var/lib/${MY_PN}"


pkg_setup() {
	enewgroup ${EXPORTER_USER}
	enewuser ${EXPORTER_USER} -1 -1 "${EXPORTER_HOME}" ${EXPORTER_USER}
}

post_src_unpack() {
	if [ ! -d "${S}" ] ; then
		mv "${WORKDIR}"/${MY_PN}-* "${S}" || die
	fi
}

src_install() {
	dobin ${MY_PN}
	newconfd "${FILESDIR}"/"${MY_PN}".confd ${MY_PN}
	newinitd "${FILESDIR}"/"${MY_PN}"-1.initd ${MY_PN}
}