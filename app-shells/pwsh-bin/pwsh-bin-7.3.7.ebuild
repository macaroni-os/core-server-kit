# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="PowerShell - binary precompiled for glibc"
HOMEPAGE="https://powershell.org/"
LICENSE="MIT"
QA_PREBUILT="*"
SRC_URI="https://github.com/PowerShell/PowerShell/releases/download/v7.3.7/powershell-7.3.7-linux-x64.tar.gz -> powershell-7.3.7-linux-x64.tar.gz"
SLOT="0"
KEYWORDS="~amd64"
RDEPEND="
	app-crypt/mit-krb5:0/0
	|| ( dev-libs/openssl-compat:1.0.0 =dev-libs/openssl-1.0*:0/0 )
	sys-libs/pam:0/0
	sys-libs/zlib:0
	pwsh-symlink? ( !app-shells/pwsh )
"
IUSE="+pwsh-symlink"
REQUIRED_USE="elibc_glibc"

S=${WORKDIR}

src_install() {
	local dest=opt/pwsh broken_symlinks=(libcrypto.so.1.0.0 libssl.so.1.0.0) symlink
	dodir "${dest}"

	for symlink in "${broken_symlinks[@]}"; do
		[[ -L ${symlink} ]] && { rm "${symlink}" || die; }
	done

	mv "${S}/"* "${ED}/${dest}/" || die
	fperms 0755 "/${dest}/pwsh"

	dosym "../../${dest}/pwsh" "/usr/bin/pwsh-bin"
	use pwsh-symlink && dosym "../../${dest}/pwsh" "/usr/bin/pwsh"
}