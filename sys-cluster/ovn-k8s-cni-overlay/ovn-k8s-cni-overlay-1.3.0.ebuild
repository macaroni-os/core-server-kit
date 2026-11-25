# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
EGO_OVERRIDE_GOMOD=0
inherit go-module

DESCRIPTION="CNI plugin binary of OVN-Kubernetes for Kubernetes worker nodes"
HOMEPAGE="https://ovn-kubernetes.io"
SRC_URI="https://api.github.com/repos/ovn-kubernetes/ovn-kubernetes/tarball/v1.3.0 -> ovn-k8s-cni-overlay-1.3.0-251895c.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
RESTRICT="test"
BDEPEND=">=dev-lang/go-1.26.0
	<dev-lang/go-1.27.0
	
"

post_src_unpack() {
	mv ovn-kubernetes-ovn-kubernetes-* ${S}
}


src_compile() {
	# The Go module of the tree is the go-controller subdirectory.
	cd "${S}/go-controller" || die
	export GOTOOLCHAIN=local
	# Mirrors upstream go-controller/hack/build-go.sh (see the header):
	# CGO_ENABLED=0, -mod vendor, and the -X stamps of pkg/config. The
	# stamp prefix is the module path read from go.mod itself, so it is
	# correct on both import paths (ovn-org on 1.2/1.3, ovn-kubernetes
	# on 1.4); BuildUser and BuildDate are the build-machine values as
	# the upstream script produces them.
	local gopkg
	gopkg=$(grep -m1 '^module ' go.mod | cut -f2 -d' ')
	local clientgo_version
	clientgo_version=$(grep 'k8s.io/client-go' go.mod | head -1 | cut -f2 -d' ')
	local goldflags="-X ${gopkg}/pkg/config.Commit=251895cd534fcdc797a9fdbb7f289a95b63ea4af -X ${gopkg}/pkg/config.Branch=unknown -X ${gopkg}/pkg/config.BuildUser=$(whoami) -X ${gopkg}/pkg/config.BuildDate=$(date +%Y-%m-%d) -X k8s.io/client-go/pkg/version.gitVersion=${clientgo_version}"
	# The worker CNI plugin, the single binary of this flavour.
	env CGO_ENABLED=0 go build -v -mod vendor -ldflags "${goldflags}" -o ovn-k8s-cni-overlay ./cmd/ovn-k8s-cni-overlay || die
}

src_install() {
	cd "${S}/go-controller" || die
	# CNI plugin binary into /opt/cni/bin — the house convention proven
	# for net-misc/cni-plugins in the macaroni-os/kit-fixups#553 body.
	exeinto /opt/cni/bin
	doexe ovn-k8s-cni-overlay
}



# vim: filetype=ebuild
