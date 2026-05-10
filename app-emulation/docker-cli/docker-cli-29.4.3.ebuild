# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit bash-completion-r1

DESCRIPTION="The command-line interface for Docker"
HOMEPAGE="https://github.com/docker/cli"
SRC_URI="https://api.github.com/repos/docker/cli/tarball/refs/tags/v29.4.3 -> docker-cli-29.4.3-055a478.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="hardened"
RESTRICT="strip"
BDEPEND="dev-go/go-md2man
	
"
PDEPEND="app-emulation/docker-buildx
	
"

post_src_unpack() {
	mv docker-cli-* ${S}
}


src_prepare() {
	default
	sed -i 's@dockerd\?\.exe@@g' contrib/completion/bash/docker || die
	ln -s vendor.mod go.mod
	ln -s vendor.sum go.sum
}
src_compile() {
	export DISABLE_WARN_OUTSIDE_CONTAINER=1
	export GOPATH="${WORKDIR}/${P}"
	export CGO_CFLAGS="-I${ESYSROOT}/usr/include"
	export CGO_LDFLAGS="-L${ESYSROOT}/usr/$(get_libdir)"
	export GOFLAGS="-v -x -mod=vendor"
	emake \
	LDFLAGS="$(usex hardened '-extldflags -fno-PIC' '')" \
	VERSION="29.4.3-macaroni" \
	GITCOMMIT="055a478" \
	dynbinary manpages
}
src_install() {
	dobin build/docker
	doman man/man*/*
	dobashcomp contrib/completion/bash/*
	bashcomp_alias docker dockerd
	insinto /usr/share/fish/vendor_completions.d/
	doins contrib/completion/fish/docker.fish
	insinto /usr/share/zsh/site-functions
	doins contrib/completion/zsh/_*
}



# vim: filetype=ebuild
