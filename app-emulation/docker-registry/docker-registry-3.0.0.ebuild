# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
SVCNAME=registry
inherit systemd user

DESCRIPTION="Docker Registry"
HOMEPAGE="https://distribution.github.io/distribution"
SRC_URI="https://api.github.com/repos/distribution/distribution/tarball/v3.0.0 -> docker-registry-3.0.0-9ed95e7.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="systemd"

post_src_unpack() {
	mv distribution-distribution-* ${S}
}


pkg_setup() {
	enewgroup ${SVCNAME}
	enewuser ${SVCNAME} -1 -1 /dev/null ${SVCNAME}
}
src_prepare() {
	default
	sed -i -e "s/git describe.*/echo ${PV})/"\
	  -e "s/git rev-parse.*/echo 9ed95e7365224025ee89365e12cf128e1f1bf965)/"\
	  -e "s/-s -w/-w/" Makefile || die
}
src_compile() {
	export -n GOCACHE XDG_CACHE_HOME #681072
	GOPATH="${S}" GO_BUILD_FLAGS="-v" emake binaries
}
src_install() {
	exeinto /usr/libexec/docker-registry
	doexe bin/*
	insinto /etc/docker/registry
	newins cmd/registry/config-example.yml config.yml.example
	newconfd "${FILESDIR}/${SVCNAME}.confd" "${SVCNAME}"
	if use systemd ; then
	  systemd_dounit "${FILESDIR}/${SVCNAME}.service"
	else
	  newinitd "${FILESDIR}/${SVCNAME}.initd" "${SVCNAME}"
	fi
	keepdir /var/{lib,log}/${SVCNAME}
	fowners ${SVCNAME}:${SVCNAME} /var/{lib,log}/${SVCNAME}
	insinto /etc/logrotate.d
	newins "${FILESDIR}/${SVCNAME}.logrotated" "${SVCNAME}"
}



# vim: filetype=ebuild
