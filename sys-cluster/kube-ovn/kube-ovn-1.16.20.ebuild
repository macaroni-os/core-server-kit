# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit go-module

DESCRIPTION="A container networking solution for Kubernetes based on OVN"
HOMEPAGE="https://kube-ovn.io"
SRC_URI="
https://api.github.com/repos/kubeovn/kube-ovn/tarball/v1.16.20 -> kube-ovn-1.16.20-fca3416.tar.gz
mirror://macaroni/kube-ovn-1.16.20-mark-go-bundle-fca3416.tar.xz -> kube-ovn-1.16.20-mark-go-bundle-fca3416.tar.xz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="helpers"
RESTRICT="test"
BDEPEND="dev-lang/go
"

post_src_unpack() {
	mv kubeovn-kube-ovn-* ${S}
}


src_compile() {
	# Upstream build-go flags, mirrored per binary
	# (makefiles/build.mk): -trimpath plus -w -s -extldflags '-z now'
	# and the versions stamping for every binary, CGO_ENABLED=0
	# throughout, -buildmode=pie exactly for the binaries upstream
	# builds PIE (everything except the kube-ovn CNI plugin,
	# kubectl-ko, tproxy and ipsec). GOFLAGS comes from the go-module
	# eclass (-mod=readonly against the mark-go-bundle proxy).
	local goldflags="-extldflags '-z now' -X github.com/kubeovn/kube-ovn/versions.COMMIT=fca3416ffc311875f3872bd4eb098d4b9c3f6a19 -X github.com/kubeovn/kube-ovn/versions.VERSION=v1.16.20"
	export GOTOOLCHAIN=local
	# Core: the controller, the node daemon, the CNI plugin and the
	# kube-ovn-cmd dispatcher (webhook/leader-checker/monitor).
	CGO_ENABLED=0 go build -trimpath -ldflags "-w -s ${goldflags}" -o kube-ovn ./cmd/cni || die
	CGO_ENABLED=0 go build -trimpath -buildmode=pie -ldflags "-w -s ${goldflags}" -o kube-ovn-cmd ./cmd || die
	CGO_ENABLED=0 go build -trimpath -buildmode=pie -ldflags "-w -s ${goldflags}" -o kube-ovn-daemon ./cmd/daemon || die
	CGO_ENABLED=0 go build -trimpath -buildmode=pie -ldflags "-w -s ${goldflags}" -o kube-ovn-controller ./cmd/controller || die
	if use helpers ; then
	  # Build what the track has: the 1.16/1.15 lines lack the Go
	  # kubectl-ko, ko-helper, tproxy and ipsec commands, 1.15 also
	  # the vpc-egress-gateway-observer.
	  if [ -d cmd/bfdd_supervisor ] ; then
	    CGO_ENABLED=0 go build -trimpath -buildmode=pie -ldflags "-w -s ${goldflags}" -o kube-ovn-bfdd-supervisor ./cmd/bfdd_supervisor || die
	  fi
	  if [ -d cmd/vpc-egress-gateway-observer ] ; then
	    CGO_ENABLED=0 go build -trimpath -buildmode=pie -ldflags "-w -s ${goldflags}" -o vpc-egress-gateway-observer ./cmd/vpc-egress-gateway-observer || die
	  fi
	  if [ -d cmd/tproxy ] ; then
	    CGO_ENABLED=0 go build -trimpath -ldflags "-w -s ${goldflags}" -o kube-ovn-tproxy ./cmd/tproxy || die
	  fi
	  if [ -d cmd/ipsec ] ; then
	    # Upstream name kube-ovn-ipsec, not ipsec: avoids the
	    # strongswan /usr/bin/ipsec collision.
	    CGO_ENABLED=0 go build -trimpath -ldflags "-w -s ${goldflags}" -o kube-ovn-ipsec ./cmd/ipsec || die
	  fi
	  if [ -d cmd/kubectl-ko ] ; then
	    # 1.17: the kubectl plugin became a Go command.
	    CGO_ENABLED=0 go build -trimpath -ldflags "-w -s ${goldflags}" -o kubectl-ko ./cmd/kubectl-ko || die
	  fi
	  if [ -d cmd/ko-helper ] ; then
	    CGO_ENABLED=0 go build -trimpath -ldflags "-w -s ${goldflags}" -o kubectl-ko-node-agent ./cmd/ko-helper || die
	  fi
	fi
}

src_install() {
	dobin kube-ovn-cmd kube-ovn-daemon kube-ovn-controller
	# argv[0]-dispatched subcommands of kube-ovn-cmd (cmd/cmdmain.go),
	# exposed as the upstream image does.
	dosym kube-ovn-cmd /usr/bin/kube-ovn-webhook
	dosym kube-ovn-cmd /usr/bin/kube-ovn-monitor
	dosym kube-ovn-cmd /usr/bin/kube-ovn-leader-checker
	# CNI plugin binary, tree convention from net-misc/cni-plugins.
	exeinto /opt/cni/bin
	doexe kube-ovn
	if use helpers ; then
	  if [ -f kubectl-ko ] ; then
	    dobin kubectl-ko
	  elif [ -f dist/images/kubectl-ko ] ; then
	    # 1.16/1.15 ship kubectl-ko as a shell script.
	    dobin dist/images/kubectl-ko
	  fi
	  if [ -f kubectl-ko-node-agent ] ; then dobin kubectl-ko-node-agent ; fi
	  if [ -f kube-ovn-tproxy ] ; then dobin kube-ovn-tproxy ; fi
	  if [ -f kube-ovn-ipsec ] ; then dobin kube-ovn-ipsec ; fi
	  if [ -f kube-ovn-bfdd-supervisor ] ; then dobin kube-ovn-bfdd-supervisor ; fi
	  if [ -f vpc-egress-gateway-observer ] ; then dobin vpc-egress-gateway-observer ; fi
	  # Dispatch symlinks of the upstream image: speaker is another
	  # kube-ovn-cmd mode, pinger a kube-ovn-controller mode (all
	  # three lines symlink it in the Dockerfile).
	  dosym kube-ovn-cmd /usr/bin/kube-ovn-speaker
	  dosym kube-ovn-controller /usr/bin/kube-ovn-pinger
	fi
}



# vim: filetype=ebuild
