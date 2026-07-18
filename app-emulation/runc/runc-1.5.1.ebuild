# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit go-module

DESCRIPTION="CLI tool for spawning and running containers according to the OCI specification"
HOMEPAGE="https://www.opencontainers.org/"
SRC_URI="https://api.github.com/repos/opencontainers/runc/tarball/v1.5.1 -> runc-1.5.1-8f2685a.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="apparmor hardened +kmem +seccomp"
BDEPEND="dev-go/go-md2man
	virtual/pkgconfig
	
"
RDEPEND="seccomp? ( sys-libs/libseccomp )
	apparmor? ( sys-libs/libapparmor )
	
"
DEPEND="${RDEPEND}
"

post_src_unpack() {
	mv opencontainers-runc-* ${S}
}


src_compile() {
	local options=(
	  $(usev apparmor)
	  $(usev seccomp)
	  $(usex kmem '' 'nokmem')
	)
	myemakeargs=(
	  BUILDTAGS="${options[*]}"
	  COMMIT="8f2685a471d3347a686ad3909783d8aafc6bb208"
	)
	export GOFLAGS="-v -x -mod=vendor"
	emake "${myemakeargs[@]}" runc man
}
src_install() {
	myemakeargs+=(
	  PREFIX="${ED}/usr"
	  BINDIR="${ED}/usr/bin"
	  MANDIR="${ED}/usr/share/man"
	)
	export GOFLAGS="-v -x -mod=vendor"
	emake "${myemakeargs[@]}" install install-man install-bash
	local DOCS=( README.md PRINCIPLES.md docs/. )
	einstalldocs
}



# vim: filetype=ebuild
