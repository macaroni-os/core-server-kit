# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit user systemd go-module

DESCRIPTION="Vendor-agnostic OpenTelemetry Collector distribution with programmable pipelines"
HOMEPAGE="https://grafana.com/oss/alloy/ https://github.com/grafana/alloy"
SRC_URI="https://api.github.com/repos/grafana/alloy/tarball/v1.21.3 -> alloy-1.21.3-f2108cd.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="systemd"
RESTRICT="strip network-sandbox"
BDEPEND="dev-lang/go
	
"
RDEPEND="!app-metrics/alloy-bin
	
"

pkg_setup() {
	enewgroup alloy 516
	enewuser alloy 516 -1 /var/lib/alloy alloy
}

post_src_unpack() {
	mv grafana-alloy-* "${S}"
}

post_src_prepare() {
	# go-module toolchain override only sees the root go.mod at ${S}; alloy
	# builds from collector/, which replaces sibling local modules (../syntax
	# and others), each carrying its own go directive - mirror the override
	# across every module in the tree (macaroni-os/mark-issues#848).
	local gotoolchain_local=$(go env GOVERSION | sed -e 's|go||g')
	local gomod gotoolchain_pkg
	for gomod in $(find "${S}" -name go.mod -not -path '*/vendor/*'); do
		gotoolchain_pkg=$(grep '^go ' "${gomod}" | sed -e 's|go ||g')
		if [ -n "${gotoolchain_pkg}" ] && [ "${gotoolchain_pkg}" != "${gotoolchain_local}" ] ; then
			ewarn "Module ${gomod#${S}/} needs go ${gotoolchain_pkg}. Forcing local version ${gotoolchain_local}."
			sed -i -e "s|^go .*|go ${gotoolchain_local}|g" "${gomod}"
		fi
	done
}

src_compile() {
	# main package is collector's; the root module is wired via replace ../
	cd collector || die
	go build -mod=mod -trimpath \
		-ldflags "-X github.com/grafana/alloy/internal/build.Version=1.21.3-f2108cd" \
		-o ../bin/alloy . || die
}

src_install() {
	dobin bin/alloy
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
