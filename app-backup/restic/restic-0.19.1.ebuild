# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit go-module bash-completion-r1

DESCRIPTION="Fast, secure, efficient backup program"
HOMEPAGE="https://restic.net"
SRC_URI="
https://api.github.com/repos/restic/restic/tarball/v0.19.1 -> restic-0.19.1-6aa3a51.tar.gz
mirror://macaroni/restic-0.19.1-mark-go-bundle-6aa3a51.tar.xz -> restic-0.19.1-mark-go-bundle-6aa3a51.tar.xz"
LICENSE="BSD-2-Clause"
SLOT="0"
KEYWORDS="*"
# Commons depends
CDEPEND="sys-fs/fuse:0
	
"
BDEPEND="dev-lang/go
"
RDEPEND="${CDEPEND}
"
DEPEND="${CDEPEND}
"

post_src_unpack() {
	mv restic-restic-* ${S}
}


src_compile() {
	go build -ldflags '-X main.version=0.19.1' \
	  -asmflags "-trimpath=${S}" \
	  -gcflags "-trimpath=${S}" \
	  -o restic ./cmd/restic
}
src_install() {
	dobin restic
	 newbashcomp doc/bash-completion.sh "restic"
	 insinto /usr/share/zsh/site-functions
	newins doc/zsh-completion.zsh _restic
	 insinto /usr/share/fish/vendor_completions.d/
	newins doc/fish-completion.fish "restic"
	 doman doc/man/*
	dodoc doc/*.rst
}



# vim: filetype=ebuild
