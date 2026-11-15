# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit bash-completion-r1 go-module

DESCRIPTION="CLI to install, manage and troubleshoot Kubernetes clusters running Cilium"
HOMEPAGE="https://cilium.io"
SRC_URI="https://api.github.com/repos/cilium/cilium-cli/tarball/v0.20.2 -> cilium-cli-0.20.2-1ac7fa6.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
RESTRICT="test"
BDEPEND=">=dev-lang/go-1.21
	
"

post_src_unpack() {
	mv cilium-cilium-cli-* ${S}
}


src_compile() {
	# The tarball has no .git for the Makefile's git describe, so the
	# CLI version is stamped explicitly the way upstream release builds
	# do (the binary prints the value verbatim in `cilium version`).
	export GOFLAGS="-v -x -mod=vendor"
	emake CLI_VERSION=v0.20.2
}

src_install() {
	# Upstream ships a single binary named cilium (PN is cilium-cli).
	newbin cilium cilium
	./cilium completion bash > cilium.bash || die
	./cilium completion zsh > cilium.zsh || die
	newbashcomp cilium.bash cilium
	insinto /usr/share/zsh/site-functions
	newins cilium.zsh _cilium
}



# vim: filetype=ebuild
