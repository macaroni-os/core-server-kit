# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit user systemd

DESCRIPTION="Grafana Mimir horizontally-scalable, highly-available, multi-tenant compatible Prometheus as a Service"
HOMEPAGE="https://grafana.com/oss/mimir/ https://github.com/grafana/mimir"
SRC_URI="
amd64? ( https://github.com/grafana/mimir/releases/download/mimir-3.2.4/mimir-linux-amd64 -> mimir-3.2.4-linux-amd64 )
amd64? ( https://github.com/grafana/mimir/releases/download/mimir-3.2.4/mimirtool-linux-amd64 -> mimirtool-3.2.4-linux-amd64 )
amd64? ( https://github.com/grafana/mimir/releases/download/mimir-3.2.4/query-tee-linux-amd64 -> query-tee-3.2.4-linux-amd64 )
amd64? ( https://github.com/grafana/mimir/releases/download/mimir-3.2.4/metaconvert-linux-amd64 -> metaconvert-3.2.4-linux-amd64 )
arm64? ( https://github.com/grafana/mimir/releases/download/mimir-3.2.4/mimir-linux-arm64 -> mimir-3.2.4-linux-arm64 )
arm64? ( https://github.com/grafana/mimir/releases/download/mimir-3.2.4/mimirtool-linux-arm64 -> mimirtool-3.2.4-linux-arm64 )
arm64? ( https://github.com/grafana/mimir/releases/download/mimir-3.2.4/query-tee-linux-arm64 -> query-tee-3.2.4-linux-arm64 )
arm64? ( https://github.com/grafana/mimir/releases/download/mimir-3.2.4/metaconvert-linux-arm64 -> metaconvert-3.2.4-linux-arm64 )"
LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="*"
IUSE="amd64 arm64 systemd"
RESTRICT="strip"
RDEPEND="!app-metrics/mimir
	
"

pkg_setup() {
	enewgroup mimir 515
	enewuser mimir 515 -1 /var/lib/mimir mimir
}

src_unpack() {
	mkdir "${S}" || die
}

src_prepare() {
	default
	local arch=amd64
	use arm64 && arch=arm64
	cp "${DISTDIR}/mimir-${PV}-linux-${arch}" "${S}/mimir" || die
	cp "${DISTDIR}/mimirtool-${PV}-linux-${arch}" "${S}/mimirtool" || die
	cp "${DISTDIR}/query-tee-${PV}-linux-${arch}" "${S}/query-tee" || die
	cp "${DISTDIR}/metaconvert-${PV}-linux-${arch}" "${S}/metaconvert" || die
}

src_install() {
	dobin mimir mimirtool query-tee metaconvert
	insinto /etc/mimir
	newins "${FILESDIR}/config.yaml" config.yaml
	newconfd "${FILESDIR}/mimir.confd" mimir
	if use systemd ; then
		systemd_dounit "${FILESDIR}/mimir.service"
	else
		newinitd "${FILESDIR}/mimir.initd" mimir
	fi
	keepdir /var/{lib,log}/mimir
	fowners mimir:mimir /var/{lib,log}/mimir
	fperms 0750 /var/{lib,log}/mimir
}


# vim: filetype=ebuild
