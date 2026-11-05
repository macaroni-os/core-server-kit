# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit user systemd go-module

DESCRIPTION="Grafana Tempo distributed tracing backend"
HOMEPAGE="https://grafana.com/oss/tempo/ https://github.com/grafana/tempo"
SRC_URI="https://api.github.com/repos/grafana/tempo/tarball/v3.1.1 -> tempo-3.1.1-9db7df7.tar.gz"
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
RDEPEND="!app-metrics/tempo-bin
	
"

pkg_setup() {
	enewgroup tempo 514
	enewuser tempo 514 -1 /var/lib/tempo tempo
}

post_src_unpack() {
	mv grafana-tempo-* "${S}"
}

src_compile() {
	local ldflags="-X main.Version=3.1.1-9db7df7"
	for c in tempo tempo-query tempo-cli ; do
		go build -mod=vendor -trimpath -ldflags "${ldflags}" -o bin/"${c}" ./cmd/"${c}" || die
	done
}

src_install() {
	dobin bin/tempo bin/tempo-query bin/tempo-cli
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
