# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/c1c25ca3e6f028d83c1fb29ca0ce5dbcf7665023 -> aws-crt-python-0.16.2-c1c25ca.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/57b7f0db21258750af138e80823123212f0925de -> aws-c-auth-0.6.21-57b7f0d.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/ac4216b78d5323b5b8ce95a3dd4a8fc0f95e2d33 -> aws-c-cal-0.5.20-ac4216b.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/d6a6a6057afd8024cf2790a50de4a9818014cec6 -> aws-c-common-0.8.5-d6a6a60.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/b517b7decd0dac30be2162f5186c250221c53aff -> aws-c-compression-0.2.16-b517b7d.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/e812dd4df0fcc350ad7b5b7babe82cfe5664f4a4 -> aws-c-event-stream-0.2.17-e812dd4.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/4e82c1e5022d3dd4d6eda4b8fa9cdba6e6def050 -> aws-c-http-0.6.29-4e82c1e.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/6c19e25f55fa060d4e42010756967b979361dc66 -> aws-c-io-0.13.12-6c19e25.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/c2bc31060984dc3eb89b016c9ea0a525d259fc7d -> aws-c-mqtt-0.8.2-c2bc310.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/374191a730faf7e040a776c7244b5b79c5eeed76 -> aws-c-s3-0.2.1-374191a.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/208a701fa01e99c7c8cc3dcebc8317da71362972 -> aws-c-sdkutils-0.1.7-208a701.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/ad53be196a25bbefa3700a01187fdce573a7d2d0 -> aws-checksums-0.1.14-ad53be1.tar.gz
	https://github.com/awslabs/aws-lc/tarball/75a73bfabf1be384b49c7f92da6fdfd9d867069e -> aws-lc-1.3.0-75a73bf.tar.gz
	https://github.com/aws/s2n-tls/tarball/f2faa0e25b1d68cd36173ae44df58be3218b6ca1 -> s2n-tls-1.3.31-f2faa0e.tar.gz
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