# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/0157faf2fdb7bcb7eb2f84bcdbc7c67faff18c6a -> aws-crt-python-0.27.2-0157faf.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/cd9d6afcd42035d49bb2d0d3bef24b9faed57773 -> aws-c-auth-0.9.0-cd9d6af.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/938d0fea30d8476a7cf260278d636404682a28d4 -> aws-c-cal-0.9.1-938d0fe.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/aaa2f11ed609e3f888efd9bf745e810b45b13a38 -> aws-c-common-0.12.3-aaa2f11.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/f951ab2b819fc6993b6e5e6cfef64b1a1554bfc8 -> aws-c-compression-0.3.1-f951ab2.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/9312b052583183b98526aaeb91e5c72ec3db9627 -> aws-c-event-stream-0.5.4-9312b05.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/3eedf1ef8c6874cd941dbde794a6ab3bd979e181 -> aws-c-http-0.10.1-3eedf1e.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/689dee3cb8dbd8a6906431d154a3695f7688c056 -> aws-c-io-0.19.1-689dee3.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/3ac506507679a86677f8875dcc07589b63907863 -> aws-c-mqtt-0.13.1-3ac5065.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/52c90d39dab19a36e06d746a8c795060632619e2 -> aws-c-s3-0.8.0-52c90d3.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/f678bda9e21f7217e4bbf35e0d1ea59540687933 -> aws-c-sdkutils-0.2.4-f678bda.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/9978ba2c33a7a259c1a6bd0f62abe26827d03b85 -> aws-checksums-0.2.7-9978ba2.tar.gz
	https://github.com/awslabs/aws-lc/tarball/40ac425f8eab7233079d667dacaf63db802d1eb6 -> aws-lc-1.52.0-40ac425.tar.gz
	https://github.com/aws/s2n-tls/tarball/92f7827c8487eb2a99b443aec6ee7d1df031b1bf -> s2n-tls-1.5.19-92f7827.tar.gz
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