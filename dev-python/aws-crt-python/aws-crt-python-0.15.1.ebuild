# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/a989a07ff90676ef5ce4e912a0cf7e67167ae45a -> aws-crt-python-0.15.1-a989a07.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/d56e18d8acd94d7e237ff27fce2f66632988d1cf -> aws-c-auth-0.6.18-d56e18d.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/ac4216b78d5323b5b8ce95a3dd4a8fc0f95e2d33 -> aws-c-cal-0.5.20-ac4216b.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/716b0615c344748d605c2c604d76da42da95f988 -> aws-c-common-0.8.4-716b061.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/63e1ada3d1c1b2d337e9edc5ea977b1f17450ded -> aws-c-compression-0.2.15-63e1ada.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/39bfa94a14b7126bf0c1330286ef8db452d87e66 -> aws-c-event-stream-0.2.15-39bfa94.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/dcbc111fa59b3663d07b5cf2558b86a5d4ac3cb8 -> aws-c-http-0.6.23-dcbc111.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/0440595f2dfc7c3ee592b5a865ba887c612cccc0 -> aws-c-io-0.13.6-0440595.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/cea176e7f3ec32d1465788e95ae9c652014aa135 -> aws-c-mqtt-0.7.12-cea176e.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/a41255ece72a7c887bba7f9d998ca3e14f4c8a1b -> aws-c-s3-0.1.51-a41255e.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/662905efb2cc9a3437e1f85287158a284e762988 -> aws-c-sdkutils-0.1.4-662905e.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/48e7c0e01479232f225c8044d76c84e74192889d -> aws-checksums-0.1.13-48e7c0e.tar.gz
	https://github.com/awslabs/aws-lc/tarball/75a73bfabf1be384b49c7f92da6fdfd9d867069e -> aws-lc-1.3.0-75a73bf.tar.gz
	https://github.com/aws/s2n-tls/tarball/72a3a37f0f807fe53cd2d56f08c27a7416dbecff -> s2n-tls-1.3.26-72a3a37.tar.gz
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