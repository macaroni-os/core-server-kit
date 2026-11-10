# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
EGO_OVERRIDE_GOMOD=0
inherit go-module systemd user

DESCRIPTION="Kubernetes controller manager running the control-plane controllers"
HOMEPAGE="https://kubernetes.io"
SRC_URI="https://api.github.com/repos/kubernetes/kubernetes/tarball/v1.37.2 -> kube-controller-manager-1.37.2-c50e539.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="hardened systemd"
RESTRICT="test"
BDEPEND=">=dev-lang/go-1.21
	
"
DEPEND="!sys-cluster/kubernetes
	
"

post_src_unpack() {
	mv kubernetes-kubernetes-* ${S}
}


post_src_prepare() {
	# The go-module toolchain override only rewrites the root go.mod,
	# which breaks the go.work consistency checks of the kubernetes
	# workspace (and its staging/src/k8s.io/* member modules). Replay
	# it in the same spirit, but across the whole workspace and only
	# when the local toolchain is older than the source requires.
	local gotoolchain_local
	local gotoolchain_pkg
	gotoolchain_local=$(go env GOVERSION | sed -e 's|go||g')
	gotoolchain_pkg=$(grep '^go ' go.mod | sed -e 's|go ||g')
	local newest
	newest=$(printf '%s\n%s\n' "${gotoolchain_local}" "${gotoolchain_pkg}" | sort -V | tail -1)
	if [ "${newest}" != "${gotoolchain_local}" ] ; then
	  ewarn "Package needs go ${gotoolchain_pkg}. Forcing local version ${gotoolchain_local}."
	  find "${S}" -name go.mod -not -path '*/vendor/*' -exec sed -i -e "s|^go .*|go ${gotoolchain_local}|" -e '/^toolchain /d' {} + || die
	  find "${S}" -name go.work -exec sed -i -e "s|^go .*|go ${gotoolchain_local}|" -e '/^toolchain /d' {} + || die
	fi
}

src_compile() {
	CGO_LDFLAGS="$(usex hardened '-fno-PIC ' '')" \
	  FORCE_HOST_GO=yes \
	  emake -j1 GOFLAGS="" GOLDFLAGS="" LDFLAGS="" WHAT=cmd/kube-controller-manager
}

src_install() {
	dobin _output/bin/kube-controller-manager
	if use systemd ; then
	  systemd_dounit "${FILESDIR}"/kube-controller-manager.service
	else
	  newconfd "${FILESDIR}"/kube-controller-manager.confd kube-controller-manager
	  newinitd "${FILESDIR}"/kube-controller-manager.initd kube-controller-manager
	fi
	keepdir /var/lib/kube-controller-manager
	fowners kube-controller-manager:kube-controller-manager /var/lib/kube-controller-manager
	fperms 0700 /var/lib/kube-controller-manager
}

pkg_setup() {
	# Static ids from macaroni-commons packages/entities/groups.yaml
	# The daemon itself runs as root, as on every real node: the
	# account owns its state directory, not the process.
	enewgroup kube-controller-manager 433
	enewuser kube-controller-manager 433 -1 /dev/null kube-controller-manager
}



# vim: filetype=ebuild
