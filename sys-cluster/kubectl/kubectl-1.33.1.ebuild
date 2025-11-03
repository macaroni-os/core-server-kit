# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit bash-completion-r1 go-module

DESCRIPTION="CLI to run commands against Kubernetes clusters"
HOMEPAGE="https://kubernetes.io"
SRC_URI="https://github.com/kubernetes/kubernetes/tarball/bf83b67fe6685e22a5750d3a82ca50b984842b4a -> kubernetes-1.33.1-bf83b67.tar.gz
https://distfiles.macaronios.org/7b/77/1b/7b771ba553d013d0cfad2696a539c74f0f026d9b126a4c281919642b2e33f9980ff9f06a1f910a94b53814eb41a9521df7cfa5931a5454847d2f7c814da86c42 -> kubectl-1.33.1-funtoo-go-bundle-6d80ab83d4b29f8cd2cb34b1559aee2366d2045f27c2488d031911868c8c5ab13f9589ccbd879ed64577dd305bbe9eb90b43aedb5dc476afa1bb6ec4e431de7c.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="hardened"

DEPEND="!sys-cluster/kubernetes"
BDEPEND=">=dev-lang/go-1.21"

RESTRICT+=" test"

src_unpack() {
	default
	rm -rf ${S}
	mv ${WORKDIR}/kubernetes-kubernetes-* ${S} || die
}

src_compile() {
	CGO_LDFLAGS="$(usex hardened '-fno-PIC ' '')" \
	FORCE_HOST_GO=yes \
		emake -j1 GOFLAGS="" GOLDFLAGS="" LDFLAGS="" WHAT=cmd/${PN}
}

src_install() {
	dobin _output/bin/${PN}
	_output/bin/${PN} completion bash > ${PN}.bash || die
	_output/bin/${PN} completion zsh > ${PN}.zsh || die
	newbashcomp ${PN}.bash ${PN}
	insinto /usr/share/zsh/site-functions
	newins ${PN}.zsh _${PN}
}