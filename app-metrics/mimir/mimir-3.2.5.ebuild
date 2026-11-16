# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit user systemd go-module

DESCRIPTION="Grafana Mimir horizontally-scalable, highly-available, multi-tenant compatible Prometheus as a Service"
HOMEPAGE="https://grafana.com/oss/mimir/ https://github.com/grafana/mimir"
SRC_URI="https://api.github.com/repos/grafana/mimir/tarball/mimir-3.2.5 -> mimir-3.2.5.tar.gz"
LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="*"
DOCS=(
	CHANGELOG.md
	LICENSE
	README.md
)
IUSE="systemd"
RESTRICT="strip"
BDEPEND="dev-lang/go
	
"
RDEPEND="!app-metrics/mimir-bin
	
"

pkg_setup() {
	enewgroup mimir 515
	enewuser mimir 515 -1 /var/lib/mimir mimir
}

post_src_unpack() {
	mv grafana-mimir-* "${S}"
}

src_compile() {
	local ldflags="-X github.com/grafana/mimir/pkg/util/version.Version=3.2.5"
	for c in mimir mimirtool query-tee metaconvert ; do
		go build -mod=vendor -trimpath -ldflags "${ldflags}" -o bin/"${c}" ./cmd/"${c}" || die
	done
}

src_install() {
	dobin bin/mimir bin/mimirtool bin/query-tee bin/metaconvert
	einstalldocs
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
