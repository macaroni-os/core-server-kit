# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd tmpfiles user

DESCRIPTION="Free and Open, Distributed, RESTful Search Engine"
HOMEPAGE="https://www.elastic.co/elasticsearch/"
SRC_URI="
	amd64? ( https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.6.2-linux-x86_64.tar.gz -> elasticsearch-8.6.2-linux-x86_64.tar.gz )

	arm64? ( https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.6.2-linux-aarch64.tar.gz -> elasticsearch-8.6.2-linux-aarch64.tar.gz )
"

LICENSE="Apache-2.0 BSD-2 Elastic-2.0 LGPL-3 MIT public-domain"
SLOT="0"
KEYWORDS="-* amd64 arm64"

RDEPEND="virtual/jre"


QA_PRESTRIPPED="usr/share/elasticsearch/modules/x-pack-ml/platform/linux-x86_64/\(bin\|lib\)/.*"

pkg_setup() {
	enewuser ${PN}
	enewgroup ${PN}
}

src_prepare() {
	default

	rm LICENSE.txt NOTICE.txt  || die
	rmdir logs || die
}

src_install() {
	keepdir /etc/${PN}
	keepdir /etc/${PN}/scripts

	insinto /etc/${PN}
	doins -r config/.
	rm -r config || die

	fowners root:${PN} /etc/${PN}
	fperms 2750 /etc/${PN}

	insinto /usr/share/${PN}
	doins -r .

	exeinto /usr/share/${PN}/bin
	doexe "${REPODIR}/www-apps/elastic/files/${PN}/elasticsearch-systemd-pre-exec"

	fperms -R +x /usr/share/${PN}/bin
	fperms -R +x /usr/share/${PN}/modules/x-pack-ml/platform/linux-x86_64/bin

	keepdir /var/{lib,log}/${PN}
	fowners ${PN}:${PN} /var/{lib,log}/${PN}
	fperms 0750 /var/{lib,log}/${PN}
	dodir /usr/share/${PN}/plugins

	insinto /etc/sysctl.d
	newins "${REPODIR}/www-apps/elastic/files/${PN}/${PN}.sysctl.d" ${PN}.conf

	newconfd "${REPODIR}/www-apps/elastic/files/${PN}/${PN}.conf.4" ${PN}
	newinitd "${REPODIR}/www-apps/elastic/files/${PN}/${PN}.init.8" ${PN}

	systemd_install_serviced "${REPODIR}/www-apps/elastic/files/${PN}/${PN}.service.conf"
	newtmpfiles "${REPODIR}/www-apps/elastic/files/${PN}/${PN}.tmpfiles.d" ${PN}.conf
	systemd_newunit "${REPODIR}/www-apps/elastic/files/${PN}"/${PN}.service.3 ${PN}.service
}

pkg_postinst() {
	tmpfiles_process /usr/lib/tmpfiles.d/${PN}.conf

	elog
	elog "You may create multiple instances of ${PN} by"
	elog "symlinking the init script:"
	elog "ln -sf /etc/init.d/${PN} /etc/init.d/${PN}.instance"
	elog
	elog "Please make sure you put elasticsearch.yml, log4j2.properties and scripts"
	elog "from /etc/${PN} into the configuration directory of the instance:"
	elog "/etc/${PN}/instance"
	elog
	ewarn "Please make sure you have proper permissions on /etc/${PN}"
	ewarn "prior to keystore generation or you may experience startup fails."
	ewarn "chown root:${PN} /etc/${PN} && chmod 2750 /etc/${PN}"
	ewarn "chown root:${PN} /etc/${PN}/${PN}.keystore && chmod 0660 /etc/${PN}/${PN}.keystore"
}