# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit user systemd

DESCRIPTION="Loki: like Prometheus, but for logs"
HOMEPAGE="https://grafana.com/oss/loki/ https://github.com/grafana/loki"
SRC_URI="
amd64? ( https://github.com/grafana/loki/releases/download/v3.6.19/loki-linux-amd64.zip -> loki-3.6.19-linux-amd64.zip )
amd64? ( https://github.com/grafana/loki/releases/download/v3.6.19/logcli-linux-amd64.zip -> logcli-3.6.19-linux-amd64.zip )
amd64? ( https://github.com/grafana/loki/releases/download/v3.6.19/lokitool-linux-amd64.zip -> lokitool-3.6.19-linux-amd64.zip )
amd64? ( https://github.com/grafana/loki/releases/download/v3.6.19/loki-canary-linux-amd64.zip -> loki-canary-3.6.19-linux-amd64.zip )
arm64? ( https://github.com/grafana/loki/releases/download/v3.6.19/loki-linux-arm64.zip -> loki-3.6.19-linux-arm64.zip )
arm64? ( https://github.com/grafana/loki/releases/download/v3.6.19/logcli-linux-arm64.zip -> logcli-3.6.19-linux-arm64.zip )
arm64? ( https://github.com/grafana/loki/releases/download/v3.6.19/lokitool-linux-arm64.zip -> lokitool-3.6.19-linux-arm64.zip )
arm64? ( https://github.com/grafana/loki/releases/download/v3.6.19/loki-canary-linux-arm64.zip -> loki-canary-3.6.19-linux-arm64.zip )"
LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="*"
IUSE="amd64 arm64 systemd"
RESTRICT="strip"
BDEPEND="app-arch/unzip
	
"
RDEPEND="!app-metrics/loki
	
"
S="${WORKDIR}"

pkg_setup() {
	enewgroup loki 513
	enewuser loki 513 -1 /var/lib/loki loki
}

src_compile() { :; }

src_install() {
	newbin loki-linux-* loki
	newbin logcli-linux-* logcli
	newbin lokitool-linux-* lokitool
	newbin loki-canary-linux-* loki-canary
	insinto /etc/loki
	newins "${FILESDIR}/config.yaml" config.yaml
	newconfd "${FILESDIR}/loki.confd" loki
	if use systemd ; then
		systemd_dounit "${FILESDIR}/loki.service"
	else
		newinitd "${FILESDIR}/loki.initd" loki
	fi
	keepdir /var/{lib,log}/loki
	fowners loki:loki /var/{lib,log}/loki
	fperms 0750 /var/{lib,log}/loki
}


# vim: filetype=ebuild
