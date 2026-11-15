# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
EGO_OVERRIDE_GOMOD=0
inherit bash-completion-r1 go-module systemd user

DESCRIPTION="Kubernetes network proxy running on every node"
HOMEPAGE="https://kubernetes.io"
SRC_URI="https://api.github.com/repos/kubernetes/kubernetes/tarball/v1.37.2 -> kube-proxy-1.37.2-c50e539.tar.gz"
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
	  emake -j1 GOFLAGS="" GOLDFLAGS="" LDFLAGS="" WHAT=cmd/kube-proxy
}

src_install() {
	dobin _output/bin/kube-proxy
	_output/bin/kube-proxy completion bash > kube-proxy.bash || die
	_output/bin/kube-proxy completion zsh > kube-proxy.zsh || die
	newbashcomp kube-proxy.bash kube-proxy
	insinto /usr/share/zsh/site-functions
	newins kube-proxy.zsh _kube-proxy
	if use systemd ; then
	  systemd_dounit "${FILESDIR}"/kube-proxy.service
	else
	  newconfd "${FILESDIR}"/kube-proxy.confd kube-proxy
	  newinitd "${FILESDIR}"/kube-proxy.initd kube-proxy
	fi
	keepdir /var/lib/kube-proxy
	fowners kube-proxy:kube-proxy /var/lib/kube-proxy
	fperms 0700 /var/lib/kube-proxy
}

pkg_setup() {
	# Static ids from macaroni-commons packages/entities/groups.yaml
	# (the kube-proxy entity is added by macaroni-os/macaroni-commons#5).
	# The daemon itself runs as root, as on every real node: the
	# account owns its state directory, not the process.
	enewgroup kube-proxy 518
	enewuser kube-proxy 518 -1 /dev/null kube-proxy
}



# vim: filetype=ebuild
