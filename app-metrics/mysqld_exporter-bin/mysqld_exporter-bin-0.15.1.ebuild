# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit user

MY_PN=${PN/-bin/}
MY_PN_BASE=${MY_PN/_exporter/}
MY_P=${MY_PN}-${PV}

DESCRIPTION="Exporter for MySQL server metrics"
HOMEPAGE="https://github.com/prometheus/mysqld_exporter"
SRC_URI="amd64? (
  https://github.com/prometheus/mysqld_exporter/releases/download/v0.15.1/mysqld_exporter-0.15.1.linux-amd64.tar.gz -> mysqld_exporter-0.15.1.linux-amd64.tar.gz
)
arm64? (
  https://github.com/prometheus/mysqld_exporter/releases/download/v0.15.1/mysqld_exporter-0.15.1.linux-arm64.tar.gz -> mysqld_exporter-0.15.1.linux-arm64.tar.gz
)
"

KEYWORDS="-* amd64 arm64"
LICENSE="Apache-2.0"
SLOT="0"
IUSE="amd64 arm64"

DEPEND=""
RDEPEND="${DEPEND}"

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
	if [ "${MY_PN}" == "blackbox_exporter" ] ; then
		insinto /etc/"${MY_PN}"
		doins ${MY_PN_BASE}.yml
	fi
	newconfd ${REPODIR}/app-metrics/files/${MY_PN}/${MY_PN}.confd ${MY_PN}
	newinitd ${REPODIR}/app-metrics/files/exporter.initd ${MY_PN}
	keepdir /var/{lib,log}/"${MY_PN}"
	fowners ${EXPORTER_USER}:${EXPORTER_USER} /var/{lib,log}/"${MY_PN}"
	fperms 0750 /var/{lib,log}/"${MY_PN}"
}