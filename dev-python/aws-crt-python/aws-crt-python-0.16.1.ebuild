# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/c3d2b5eadc8860ba1171fc9de380a947d15f2d5c -> aws-crt-python-0.16.1-c3d2b5e.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/57b7f0db21258750af138e80823123212f0925de -> aws-c-auth-0.6.21-57b7f0d.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/ac4216b78d5323b5b8ce95a3dd4a8fc0f95e2d33 -> aws-c-cal-0.5.20-ac4216b.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/d6a6a6057afd8024cf2790a50de4a9818014cec6 -> aws-c-common-0.8.5-d6a6a60.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/b517b7decd0dac30be2162f5186c250221c53aff -> aws-c-compression-0.2.16-b517b7d.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/39bfa94a14b7126bf0c1330286ef8db452d87e66 -> aws-c-event-stream-0.2.15-39bfa94.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/5400050bff7a730f81be3f238a702bea73570e00 -> aws-c-http-0.6.28-5400050.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/453c48b02a0886407d4b5c376b5a39fa60c30f7e -> aws-c-io-0.13.11-453c48b.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/709047b9fd1b1137fdfaaefe5116710191186539 -> aws-c-mqtt-0.8.1-709047b.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/374191a730faf7e040a776c7244b5b79c5eeed76 -> aws-c-s3-0.2.1-374191a.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/208a701fa01e99c7c8cc3dcebc8317da71362972 -> aws-c-sdkutils-0.1.7-208a701.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/ad53be196a25bbefa3700a01187fdce573a7d2d0 -> aws-checksums-0.1.14-ad53be1.tar.gz
	https://github.com/awslabs/aws-lc/tarball/75a73bfabf1be384b49c7f92da6fdfd9d867069e -> aws-lc-1.3.0-75a73bf.tar.gz
	https://github.com/aws/s2n-tls/tarball/e9f4c0a4bf9c4143f846145e7e321f5e0ffd6126 -> s2n-tls-1.3.30-e9f4c0a.tar.gz
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