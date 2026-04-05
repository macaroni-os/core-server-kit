# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
MY_PN=${PN/-bin/}
PROMETHEUS_USER="${MY_PN}"
PROMETHEUS_HOME="/var/lib/${MY_PN}"
inherit user

DESCRIPTION="The Prometheus monitoring system and time series database."
HOMEPAGE="https://prometheus.io/"
SRC_URI="
amd64? ( https://github.com/prometheus/prometheus/releases/download/v3.11.0/prometheus-3.11.0.linux-amd64.tar.gz -> prometheus-bin-3.11.0.linux-amd64.tar.gz )
arm64? ( https://github.com/prometheus/prometheus/releases/download/v3.11.0/prometheus-3.11.0.linux-arm64.tar.gz -> prometheus-bin-3.11.0.linux-arm64.tar.gz )"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="amd64 arm64"
post_src_unpack() {
	mv prometheus-* ${S}
}

pkg_setup() {
	enewgroup ${PROMETHEUS_USER}
	enewuser ${PROMETHEUS_USER} -1 -1 "${PROMETHEUS_HOME}" ${PROMETHEUS_USER}
}

src_install() {
	dobin ${MY_PN} promtool
	insinto /etc/"${MY_PN}"
	doins ${MY_PN}.yml
	newconfd ${FILESDIR}/${MY_PN}.confd ${MY_PN}
	newinitd ${FILESDIR}/${MY_PN}.initd ${MY_PN}
	keepdir /var/{lib,log}/"${MY_PN}"
	fowners ${PROMETHEUS_USER}:${PROMETHEUS_USER} /var/{lib,log}/"${MY_PN}"
	fperms 0750 /var/{lib,log}/"${MY_PN}"
}


# vim: filetype=ebuild
