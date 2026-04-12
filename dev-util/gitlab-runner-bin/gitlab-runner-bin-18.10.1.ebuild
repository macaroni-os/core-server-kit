# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit systemd tmpfiles user

DESCRIPTION="GitLab Runner for executing CI jobs locally (pre-compiled)"
HOMEPAGE="https://gitlab.com/gitlab-org/gitlab-runner"
SRC_URI="https://s3.dualstack.us-east-1.amazonaws.com/gitlab-runner-downloads/v18.10.1/binaries/gitlab-runner-linux-amd64 -> gitlab-runner-bin-18.10.1"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE="systemd"
RESTRICT="strip"
RDEPEND="systemd? ( sys-apps/systemd )
	!dev-util/gitlab-runner
	
"
src_unpack() {
	mkdir "${S}"
}

src_prepare() {
	default
	cp ${DISTDIR}/${A} ${S}/gitlab-runner || die
}

pkg_setup() {
	enewgroup gitlab 548
	enewuser gitlab-runner 548 -1 -1 gitlab
}

src_install() {
	einstalldocs
	exeinto /usr/sbin
	doexe gitlab-runner
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
