# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic systemd toolchain-funcs tmpfiles user

DESCRIPTION="A persistent caching system, key-value and data structures database"
HOMEPAGE="https://redis.io"
SRC_URI="https://github.com/redis/redis/tarball/8e73f9d34821a937165884f13a2981883f44a074 -> redis-7.0.12-8e73f9d.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="*"

IUSE="+jemalloc ssl split-conf systemd tcmalloc test"
RESTRICT="!test? ( test )"

COMMON_DEPEND="
	ssl? ( dev-libs/openssl:0= )
	systemd? ( sys-apps/systemd:= )
	tcmalloc? ( dev-util/google-perftools )
"

RDEPEND="${COMMON_DEPEND}"
BDEPEND="
	${COMMON_DEPEND}
	virtual/pkgconfig
"

# Tcl is only needed in the CHOST test env
DEPEND="
	${COMMON_DEPEND}
	test? (
		dev-lang/tcl:0=
		ssl? ( dev-tcltk/tls )
	)"

REQUIRED_USE="?? ( jemalloc tcmalloc )"

post_src_unpack() {
	if [ ! -d "${S}" ]; then
		mv ${WORKDIR}/redis-redis* ${S} || die
	fi
}

src_prepare() {
	default
	sed -i \
		-e '/^pidfile /c\pidfile /run/redis/redis.pid' \
		-e '/^logfile /c\logfile /var/log/redis/redis.log' \
		-e '/^dir /c\dir /var/lib/redis/' \
		-e '/^# maxmemory /c\maxmemory 64MB' \
	redis.conf || die "config tweaks fail"

	sed -i \
		-e '/^pidfile /c\pidfile /run/redis/redis-sentinel.pid' \
		-e '/^logfile /c\logfile /var/log/redis/sentinel.log' \
	sentinel.conf || die "sentinel config tweaks fail"

}

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /dev/null ${PN}
}

src_configure() {
	return
}

src_compile() {
	local myconf=""
	if use jemalloc; then
		myconf+="MALLOC=jemalloc"
	elif use tcmalloc; then
		myconf+="MALLOC=tcmalloc"
	else
		myconf+="MALLOC=libc"
	fi

	if use ssl; then
		myconf+=" BUILD_TLS=yes"
	fi
	export USE_SYSTEMD=$(usex systemd)
	export CFLAGS
	emake V=1 ${myconf}
}

src_test() {
	# Known to fail with FEATURES=usersandbox
	if has usersandbox ${FEATURES}; then
		ewarn "You are emerging ${P} with 'usersandbox' enabled." \
			"Expect some test failures or emerge with 'FEATURES=-usersandbox'!"
	fi

	if use ssl; then
		./utils/gen-test-certs.sh
		./runtest --tls
	else
		./runtest
	fi
}

src_install() {
	insinto /etc/redis
	doins redis.conf sentinel.conf
	use prefix || fowners -R redis:redis /etc/redis /etc/redis/{redis,sentinel}.conf
	fperms 0750 /etc/redis
	fperms 0644 /etc/redis/{redis,sentinel}.conf

	if use split-conf; then
		( cd $D/etc/redis; ${FILESDIR}/split.sh )
	fi

	newconfd "${FILESDIR}/redis.confd" redis
	newinitd "${FILESDIR}/redis.initd" redis

	systemd_newunit "${FILESDIR}/redis.service" redis.service
	newtmpfiles "${FILESDIR}/redis.tmpfiles" redis.conf

	newconfd "${FILESDIR}/redis-sentinel.confd" redis-sentinel
	newinitd "${FILESDIR}/redis-sentinel.initd" redis-sentinel

	insinto /etc/logrotate.d/
	newins "${FILESDIR}/${PN}.logrotate" ${PN}

	for doc in 00-RELEASENOTES* BUGS* CONTRIBUTING.md MANIFESTO* README.md; do
		if [ -e $doc ]; then
			dodoc $doc
		else
			ewarn "Documentation $doc doesn't seem to exist anymore -- might need to revise docs."
		fi
	done

	dobin src/redis-cli
	dosbin src/redis-benchmark src/redis-server src/redis-check-aof src/redis-check-rdb
	fperms 0750 /usr/sbin/redis-benchmark
	dosym redis-server /usr/sbin/redis-sentinel

	if use prefix; then
		diropts -m0750
	else
		diropts -m0750 -o redis -g redis
	fi
	keepdir /var/{log,lib}/redis
}

pkg_postinst() {
	tmpfiles_process redis.conf

	ewarn "The default redis configuration file location changed to:"
	ewarn "  /etc/redis/{redis,sentinel}.conf"
	ewarn "Please apply your changes to the new configuration files."
}