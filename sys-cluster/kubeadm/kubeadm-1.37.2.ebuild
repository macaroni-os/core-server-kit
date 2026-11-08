# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
EGO_OVERRIDE_GOMOD=0
inherit bash-completion-r1 go-module

DESCRIPTION="Kubernetes tool for bootstrapping and maintaining clusters"
HOMEPAGE="https://kubernetes.io"
SRC_URI="https://api.github.com/repos/kubernetes/kubernetes/tarball/v1.37.2 -> kubeadm-1.37.2-c50e539.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="hardened"
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
	  emake -j1 GOFLAGS="" GOLDFLAGS="" LDFLAGS="" WHAT=cmd/kubeadm
}

src_install() {
	dobin _output/bin/kubeadm
	_output/bin/kubeadm completion bash > kubeadm.bash || die
	_output/bin/kubeadm completion zsh > kubeadm.zsh || die
	newbashcomp kubeadm.bash kubeadm
	insinto /usr/share/zsh/site-functions
	newins kubeadm.zsh _kubeadm
}



# vim: filetype=ebuild
