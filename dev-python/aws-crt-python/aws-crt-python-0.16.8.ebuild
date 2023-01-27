# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/172cbbecc30c1b2fed08b69ca031a12bce8edf7a -> aws-crt-python-0.16.8-172cbbe.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/bad1066f0a93f3a7df86c94cc03076fa6b901bd2 -> aws-c-auth-0.6.22-bad1066.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/ac4216b78d5323b5b8ce95a3dd4a8fc0f95e2d33 -> aws-c-cal-0.5.20-ac4216b.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/5e64b039356c72d17fcf1fb0bfc7637f8c2270f7 -> aws-c-common-0.8.9-5e64b03.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/b517b7decd0dac30be2162f5186c250221c53aff -> aws-c-compression-0.2.16-b517b7d.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/2f9b60c42f90840ec11822acda3d8cdfa97a773d -> aws-c-event-stream-0.2.18-2f9b60c.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/dd34461987947672444d0bc872c5a733dfdb9711 -> aws-c-http-0.7.3-dd34461.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/b52181af655c090713fe01f14d7ccb95aab8dec5 -> aws-c-io-0.13.14-b52181a.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/33c3455cec82b16feb940e12006cefd7b3ef4194 -> aws-c-mqtt-0.8.6-33c3455.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/d7bfe602d6925948f1fff95784e3613cca6a3900 -> aws-c-s3-0.2.3-d7bfe60.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/208a701fa01e99c7c8cc3dcebc8317da71362972 -> aws-c-sdkutils-0.1.7-208a701.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/ad53be196a25bbefa3700a01187fdce573a7d2d0 -> aws-checksums-0.1.14-ad53be1.tar.gz
	https://github.com/awslabs/aws-lc/tarball/75a73bfabf1be384b49c7f92da6fdfd9d867069e -> aws-lc-1.3.0-75a73bf.tar.gz
	https://github.com/aws/s2n-tls/tarball/7c395a069c0ad59ce510813ff60d268c1fe13e31 -> s2n-tls-1.3.34-7c395a0.tar.gz
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