# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit user systemd

DESCRIPTION="Grafana Tempo distributed tracing backend"
HOMEPAGE="https://grafana.com/oss/tempo/ https://github.com/grafana/tempo"
SRC_URI="
amd64? ( https://github.com/grafana/tempo/releases/download/v3.1.1/tempo_3.1.1_linux_amd64.tar.gz -> tempo-bin-3.1.1.linux-amd64.tar.gz )
arm64? ( https://github.com/grafana/tempo/releases/download/v3.1.1/tempo_3.1.1_linux_arm64.tar.gz -> tempo-bin-3.1.1.linux-arm64.tar.gz )"
LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="*"
DOCS=(
	CHANGELOG.md
	LICENSE
	README.md
)
IUSE="amd64 arm64 systemd"
RESTRICT="strip"
RDEPEND="!app-metrics/tempo
	
"
S="${WORKDIR}"

pkg_setup() {
	enewgroup tempo 514
	enewuser tempo 514 -1 /var/lib/tempo tempo
}

src_compile() { :; }

src_install() {
	dobin tempo tempo-query tempo-cli
	einstalldocs
	insinto /etc/tempo
	newins "${FILESDIR}/config.yml" config.yml
	newconfd "${FILESDIR}/tempo.confd" tempo
	if use systemd ; then
		systemd_dounit "${FILESDIR}/tempo.service"
	else
		newinitd "${FILESDIR}/tempo.initd" tempo
	fi
	keepdir /var/{lib,log}/"tempo"
	fowners tempo:tempo /var/{lib,log}/"tempo"
	fperms 0750 /var/{lib,log}/"tempo"
}


# vim: filetype=ebuild
