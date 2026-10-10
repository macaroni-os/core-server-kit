# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
EGO_BUNDLE_POSTFIX="mark-go-bundle"
inherit go-module systemd tmpfiles user

DESCRIPTION="GitLab Runner for executing CI jobs locally"
HOMEPAGE="https://gitlab.com/gitlab-org/gitlab-runner"
SRC_URI="
https://gitlab.com/gitlab-org/gitlab-runner/-/archive/v19.3.1/gitlab-runner-v19.3.1.tar.bz2 -> gitlab-runner-19.3.1.tar.bz2
mirror://macaroni/gitlab-runner-19.3.1-mark-go-bundle.tar.xz -> gitlab-runner-19.3.1-mark-go-bundle.tar.xz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
DOCS=(
	docs
	CHANGELOG.md
	README.md
)
IUSE="systemd"
RESTRICT="strip"
RDEPEND="systemd? ( sys-apps/systemd )
	!dev-util/gitlab-runner-bin
	
"
S="${WORKDIR}/gitlab-runner-v19.3.1"
pkg_setup() {
	enewgroup gitlab 548
	enewuser gitlab-runner 548 -1 -1 gitlab
}
src_compile() {
	emake \
		BUILT="$(date -u '+%Y-%m-%dT%H:%M:%S%:z')" \
		REVISION="" \
		VERSION=19.3.1 \
		runner-and-helper-bin-host
}
src_install() {
	exeinto /usr/sbin
	newbin out/binaries/gitlab-runner-linux-* gitlab-runner
	newbin out/binaries/gitlab-runner-helper/gitlab-runner-helper.linux-* gitlab-runner-helper
	einstalldocs
	if use systemd; then
		systemd_dounit "${FILESDIR}"/gitlab-runner.service
		newtmpfiles "${FILESDIR}"/gitlab-runner.tmpfile gitlab-runner.conf
	else
		newconfd "${FILESDIR}"/gitlab-runner.confd gitlab-runner
		newinitd "${FILESDIR}"/gitlab-runner.initd gitlab-runner
	fi
	insopts -o gitlab-runner -g gitlab -m0600
	diropts -o gitlab-runner -g gitlab -m0750
	insinto /etc/gitlab-runner
	keepdir /etc/gitlab-runner /var/lib/gitlab-runner
	fowners gitlab-runner:gitlab /etc/gitlab-runner
}

pkg_postinst() {
	if use systemd; then
		tmpfiles_process gitlab-runner.conf
	fi
	einfo "Create a runner at Gitlab via Build -> Runners in the menu."
	einfo "Copy the token that appears on the final page."
	einfo
	einfo "Register the runner as root using"
	einfo "\t$ gitlab-runner register --token <paste runner token>\n"
	einfo
	einfo "The config will be saved in /etc/gitlab-runner/config.toml"
}


# vim: filetype=ebuild
