# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7

DESCRIPTION="CD image containing guest additions for VirtualBox"
HOMEPAGE="https://www.virtualbox.org/"
SRC_URI="https://download.virtualbox.org/virtualbox/7.2.16/VBoxGuestAdditions_7.2.16.iso -> virtualbox-additions-7.2.16.iso"
LICENSE="GPL-2+ LGPL-2.1+ MIT SGI-B-2.0 CDDL"
SLOT="0"
KEYWORDS="*"
S=""${WORKDIR}""
src_unpack() {
	:;
}
src_install() {
	insinto /usr/share/virtualbox
	newins "${DISTDIR}"/virtualbox-additions-7.2.16.iso VBoxGuestAdditions.iso
}


# vim: filetype=ebuild
