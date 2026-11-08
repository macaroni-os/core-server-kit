# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit user systemd go-module

DESCRIPTION="Loki: like Prometheus, but for logs"
HOMEPAGE="https://grafana.com/oss/loki/ https://github.com/grafana/loki"
SRC_URI="https://api.github.com/repos/grafana/loki/tarball/v3.7.9 -> loki-3.7.9-d3b4a2f.tar.gz"
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
RDEPEND="!app-metrics/loki-bin
	
"

pkg_setup() {
	enewgroup loki 513
	enewuser loki 513 -1 /var/lib/loki loki
}

post_src_unpack() {
	mv grafana-loki-* "${S}"
}

src_compile() {
	local ldflags="-X github.com/grafana/loki/v3/pkg/util/build.Version=3.7.9-d3b4a2f"
	for c in loki logcli lokitool loki-canary ; do
		go build -mod=vendor -trimpath -ldflags "${ldflags}" -o bin/"${c}" ./cmd/"${c}" || die
	done
}

src_install() {
	dobin bin/loki bin/logcli bin/lokitool bin/loki-canary
	einstalldocs
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
