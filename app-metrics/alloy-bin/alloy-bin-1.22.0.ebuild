# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit user systemd

DESCRIPTION="Vendor-agnostic OpenTelemetry Collector distribution with programmable pipelines"
HOMEPAGE="https://grafana.com/oss/alloy/ https://github.com/grafana/alloy"
SRC_URI="
amd64? ( https://github.com/grafana/alloy/releases/download/v1.22.0/alloy-linux-amd64.zip -> alloy-bin-1.22.0.linux-amd64.zip )
arm64? ( https://github.com/grafana/alloy/releases/download/v1.22.0/alloy-linux-arm64.zip -> alloy-bin-1.22.0.linux-arm64.zip )"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="amd64 arm64 systemd"
RESTRICT="strip"
BDEPEND="app-arch/unzip
	
"
S="${WORKDIR}"

pkg_setup() {
	enewgroup alloy 516
	enewuser alloy 516 -1 /var/lib/alloy alloy
}

src_compile() { :; }

src_install() {
	newbin alloy-linux-* alloy
	einstalldocs
	insinto /etc/alloy
	newins "${FILESDIR}/config.alloy" config.alloy
	newconfd "${FILESDIR}/alloy.confd" alloy
	if use systemd ; then
		systemd_dounit "${FILESDIR}/alloy.service"
	else
		newinitd "${FILESDIR}/alloy.initd" alloy
	fi
	keepdir /var/lib/alloy/data
	keepdir /var/log/"alloy"
	fowners -R alloy:alloy /var/lib/alloy /var/log/"alloy"
	fperms -R 0750 /var/lib/alloy /var/log/"alloy"
}


# vim: filetype=ebuild
