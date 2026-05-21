# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit bash-completion-r1 go-module

DESCRIPTION="Docker CLI plugin for extended build capabilities with BuildKit"
HOMEPAGE="https://github.com/docker/buildx"
SRC_URI="https://api.github.com/repos/docker/buildx/tarball/v0.34.1 -> docker-buildx-0.34.1-e0b0e77.tar.gz"
LICENSE="Apache-2.0"
SLOT="2"
KEYWORDS="*"

post_src_unpack() {
	mv docker-buildx-* ${S}
}


src_prepare() {
	default
	# do not strip
	sed -i -e 's/-s -w//' Makefile || die
}
src_compile() {
	local _buildx_r='github.com/docker/buildx'
	go build -o docker-buildx \
	  -v -x -mod=vendor \
	  -ldflags "-linkmode=external \
	  -X $_buildx_r/version.Version=0.34.1 \
	  -X $_buildx_r/version.Revision=e0b0e77d18d3379bc1e0d55f3b37de288d36fe47 \
	  -X $_buildx_r/version.Package=$_buildx_r" \
	  ./cmd/buildx
}
src_install() {
	exeinto /usr/libexec/docker/cli-plugins
	doexe docker-buildx
	dodoc README.md
}



# vim: filetype=ebuild
