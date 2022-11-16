# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/191b52d307793ac105d7389b0bce646917857ed1 -> aws-crt-python-0.15.3-191b52d.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/92038d9bdd7b2448230dc3954d8dba28f67fc7e1 -> aws-c-auth-0.6.20-92038d9.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/ac4216b78d5323b5b8ce95a3dd4a8fc0f95e2d33 -> aws-c-cal-0.5.20-ac4216b.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/d6a6a6057afd8024cf2790a50de4a9818014cec6 -> aws-c-common-0.8.5-d6a6a60.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/b517b7decd0dac30be2162f5186c250221c53aff -> aws-c-compression-0.2.16-b517b7d.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/39bfa94a14b7126bf0c1330286ef8db452d87e66 -> aws-c-event-stream-0.2.15-39bfa94.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/0c7b8b5f30b521584b8d432fd88e0bce9fe619c7 -> aws-c-http-0.6.27-0c7b8b5.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/d353ffde788b70f39e7da889784262e4d4eb5101 -> aws-c-io-0.13.10-d353ffd.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/882c689561a3db1466330ccfe3b63637e0a575d3 -> aws-c-mqtt-0.7.13-882c689.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/a41255ece72a7c887bba7f9d998ca3e14f4c8a1b -> aws-c-s3-0.1.51-a41255e.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/25bf5cf225f977c3accc6a05a0a7a181ef2a4a30 -> aws-c-sdkutils-0.1.6-25bf5cf.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/48e7c0e01479232f225c8044d76c84e74192889d -> aws-checksums-0.1.13-48e7c0e.tar.gz
	https://github.com/awslabs/aws-lc/tarball/75a73bfabf1be384b49c7f92da6fdfd9d867069e -> aws-lc-1.3.0-75a73bf.tar.gz
	https://github.com/aws/s2n-tls/tarball/6b0c1c8190b1856a0bdae02f7670d362c0d6c647 -> s2n-tls-1.3.28-6b0c1c8.tar.gz
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE=""

DEPEND="dev-util/cmake"
RDEPEND=""
BDEPEND=""

AWS_C_MODULES=( 
	aws-c-auth
	aws-c-cal
	aws-c-common
	aws-c-compression
	aws-c-event-stream
	aws-c-http
	aws-c-io
	aws-c-mqtt
	aws-c-s3
	aws-c-sdkutils
	aws-checksums
	aws-lc
	s2n
)


post_src_unpack() {
	if [ ! -d "${S}" ] ; then
		mv "${WORKDIR}"/awslabs-aws-crt-python-* "${S}" || die
	fi

	for module in "${AWS_C_MODULES[@]}"; do
		rmdir ${S}/crt/${module} || die
		einfo "Moving ${module} into source tree"
		mv ${WORKDIR}/*${module}* ${S}/crt/${module} || die
	done
}