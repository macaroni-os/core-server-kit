# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit user

MY_PN=${PN/-bin/}
MY_P=${MY_PN}-${PV}

DESCRIPTION="Prometheus Alertmanager"
HOMEPAGE="https://github.com/prometheus/alertmanager"
SRC_URI="amd64? (
  https://github.com/prometheus/alertmanager/releases/download/v0.27.0/alertmanager-0.27.0.linux-amd64.tar.gz -> alertmanager-0.27.0.linux-amd64.tar.gz
)
arm64? (
  https://github.com/prometheus/alertmanager/releases/download/v0.27.0/alertmanager-0.27.0.linux-arm64.tar.gz -> alertmanager-0.27.0.linux-arm64.tar.gz
)
"

KEYWORDS="-* amd64 arm64"
LICENSE="Apache-2.0"
SLOT="0"
IUSE="amd64 arm64"

DEPEND=""
RDEPEND="${DEPEND}"

ALERTMANAGER_USER="${MY_PN}"
ALERTMANAGER_HOME="/var/lib/${MY_PN}"

pkg_setup() {
	enewgroup ${ALERTMANAGER_USER}
	enewuser ${ALERTMANAGER_USER} -1 -1 "${ALERTMANAGER_HOME}" ${ALERTMANAGER_USER}
}

post_src_unpack() {
	if [ ! -d "${S}" ] ; then
		mv "${WORKDIR}"/${MY_PN}-* "${S}" || die
	fi
}

src_install() {
	dobin ${MY_PN} amtool
	insinto /etc/"${MY_PN}"
	doins ${MY_PN}.yml
	newconfd ${REPODIR}/app-metrics/files/${MY_PN}/${MY_PN}.confd ${MY_PN}
	newinitd ${REPODIR}/app-metrics/files/${MY_PN}/${MY_PN}.initd ${MY_PN}
	keepdir /var/{lib,log}/"${MY_PN}"
	fowners ${ALERTMANAGER_USER}:${ALERTMANAGER_USER} /var/{lib,log}/"${MY_PN}"
	fperms 0750 /var/{lib,log}/"${MY_PN}"
}