# Distributed under the terms of the GNU General Public License v2

EAPI=7
MY_PN=${PN/-bin/}
MY_PN_BASE=${MY_PN/_exporter/}
EXPORTER_USER="${MY_PN}"
EXPORTER_HOME="/var/lib/${MY_PN}"
inherit user

DESCRIPTION="Exports metrics from memcached servers for consumption by Prometheus."
HOMEPAGE="https://github.com/prometheus/memcached_exporter"
SRC_URI="
amd64? ( https://github.com/prometheus/memcached_exporter/releases/download/v0.15.2/memcached_exporter-0.15.2.linux-amd64.tar.gz -> memcached_exporter-bin-0.15.2.linux-amd64.tar.gz )
arm64? ( https://github.com/prometheus/memcached_exporter/releases/download/v0.15.2/memcached_exporter-0.15.2.linux-arm64.tar.gz -> memcached_exporter-bin-0.15.2.linux-arm64.tar.gz )"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="amd64 arm64"
post_src_unpack() {
	mv memcached_exporter-* ${S}
}

pkg_setup() {
	enewgroup ${EXPORTER_USER}
	enewuser ${EXPORTER_USER} -1 -1 "${EXPORTER_HOME}" ${EXPORTER_USER}
}

src_install() {
	dobin ${MY_PN}
	newconfd ${FILESDIR}/${MY_PN}.confd ${MY_PN}
	newinitd ${FILESDIR}/exporter.initd ${MY_PN}
	keepdir /var/{lib,log}/"${MY_PN}"
	fowners ${EXPORTER_USER}:${EXPORTER_USER} /var/{lib,log}/"${MY_PN}"
	fperms 0750 /var/{lib,log}/"${MY_PN}"
}


# vim: filetype=ebuild
