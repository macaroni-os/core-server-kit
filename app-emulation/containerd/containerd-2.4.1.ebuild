# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit go-module systemd

DESCRIPTION="An open and reliable container runtime"
HOMEPAGE="https://containerd.io"
SRC_URI="https://api.github.com/repos/containerd/containerd/tarball/v2.4.1 -> containerd-2.4.1-f255103.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="apparmor btrfs device-mapper +cri hardened +seccomp systemd"
RESTRICT="strip"
# Commons depends
CDEPEND="btrfs? ( sys-fs/btrfs-progs )
	seccomp? ( sys-libs/libseccomp )
	
"
BDEPEND="virtual/pkgconfig
	dev-go/go-md2man
	
"
RDEPEND="${CDEPEND}
	app-emulation/runc
	
"
DEPEND="${CDEPEND}
"

post_src_unpack() {
	mv containerd-containerd-* ${S}
}


src_prepare() {
	default
	sed -i \
	  -e "s/-s -w//" \
	  Makefile || die
	sed -i \
	  -e "s:/usr/local:/usr:" \
	  containerd.service || die
}
src_compile() {
	local options=(
	  $(usev apparmor)
	  $(usex btrfs "" "no_btrfs")
	  $(usex cri "" "no_cri")
	  $(usex device-mapper "" "no_devmapper")
	  $(usev seccomp)
	)
	myemakeargs=(
	  BUILDTAGS="${options[*]}"
	  LDFLAGS="$(usex hardened '-extldflags -fno-PIC' '')"
	  REVISION="f2551031d7276a770f65f98c9b52e57e7dad07e8"
	  VERSION="v2.4.1"
	)
	export GOFLAGS="-v -x -mod=vendor"
	emake "${myemakeargs[@]}" man -j1 #nowarn
	emake "${myemakeargs[@]}" all
}
src_install() {
	dobin bin/*
	doman man/*
	if use systemd ; then
	  systemd_dounit containerd.service
	else
	  newinitd "${FILESDIR}"/${PN}.initd "${PN}"
	fi
	keepdir /var/lib/containerd
	# we already installed manpages, remove markdown source
	# before installing docs directory
	rm -r docs/man || die
	local DOCS=( ADOPTERS.md README.md RELEASES.md ROADMAP.md SCOPE.md docs/. )
	einstalldocs
}



# vim: filetype=ebuild
