# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
MY_PN=${PN/-bin/}
ALERTMANAGER_USER="${MY_PN}"
ALERTMANAGER_HOME="/var/lib/${MY_PN}"
inherit user

DESCRIPTION="Prometheus Alertmanager"
HOMEPAGE="https://github.com/prometheus/alertmanager"
SRC_URI="
amd64? ( https://github.com/prometheus/alertmanager/releases/download/v0.30.0/alertmanager-0.30.0.linux-amd64.tar.gz -> alertmanager-bin-0.30.0.linux-amd64.tar.gz )
arm64? ( https://github.com/prometheus/alertmanager/releases/download/v0.30.0/alertmanager-0.30.0.linux-arm64.tar.gz -> alertmanager-bin-0.30.0.linux-arm64.tar.gz )"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="amd64 arm64"
post_src_unpack() {
	mv alertmanager-* ${S}
}

pkg_setup() {
	enewgroup ${ALERTMANAGER_USER}
	enewuser ${ALERTMANAGER_USER} -1 -1 "${ALERTMANAGER_HOME}" ${ALERTMANAGER_USER}
}

src_install() {
	dobin ${MY_PN} amtool
	insinto /etc/"${MY_PN}"
	doins ${MY_PN}.yml
	newconfd ${FILESDIR}/${MY_PN}.confd ${MY_PN}
	newinitd ${FILESDIR}/${MY_PN}.initd ${MY_PN}
	keepdir /var/{lib,log}/"${MY_PN}"
	fowners ${ALERTMANAGER_USER}:${ALERTMANAGER_USER} /var/{lib,log}/"${MY_PN}"
	fperms 0750 /var/{lib,log}/"${MY_PN}"
}


# vim: filetype=ebuild
