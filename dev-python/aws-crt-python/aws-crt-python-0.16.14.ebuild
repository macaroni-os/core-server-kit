# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/2fa5fd8e2c6553a6156ade683607f7c6bf7b3e2d -> aws-crt-python-0.16.14-2fa5fd8.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/54f8d804120daab9e0d75a56a113a222b334d0f9 -> aws-c-auth-0.6.26-54f8d80.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/2b92354eeba73f773a90c22167339dc5939bb84f -> aws-c-cal-0.5.24-2b92354.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/06f82769dca0ff322e34985f7c36b34d6662424d -> aws-c-common-0.8.17-06f8276.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/b517b7decd0dac30be2162f5186c250221c53aff -> aws-c-compression-0.2.16-b517b7d.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/0f6eee87aee2860598084e814e0eedc0b3b9122d -> aws-c-event-stream-0.2.20-0f6eee8.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/c7350090b8712d9a6fd66a7d5d45056c87879f26 -> aws-c-http-0.7.7-c735009.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/2c4475f60d9103d90a30fc4bc38940c0477d63d9 -> aws-c-io-0.13.21-2c4475f.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/815fc9731b77c7a21308a1be9ac11378c053b515 -> aws-c-mqtt-0.8.10-815fc97.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/ae6c6cc7dd301044dd6d81d24b005d2463a23de9 -> aws-c-s3-0.2.8-ae6c6cc.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/9de59230f025df2745b098feda3611f9667e5a35 -> aws-c-sdkutils-0.1.8-9de5923.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/ad53be196a25bbefa3700a01187fdce573a7d2d0 -> aws-checksums-0.1.14-ad53be1.tar.gz
	https://github.com/awslabs/aws-lc/tarball/8668d2dbe3342d4f304382cf5b5a82f63a6adc75 -> aws-lc-1.8.0-8668d2d.tar.gz
	https://github.com/aws/s2n-tls/tarball/92b571ae3c71ad3a69511fae65982a93cb9a271b -> s2n-tls-1.3.42-92b571a.tar.gz
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