# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/2d724fdbd8d2a9679585c6c04f33c60fcfd1ef73 -> aws-crt-python-0.16.17-2d724fd.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/54f8d804120daab9e0d75a56a113a222b334d0f9 -> aws-c-auth-0.6.26-54f8d80.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/55e478b31cf50517cd359c1ef2e79ef6c2a1f9d0 -> aws-c-cal-0.5.26-55e478b.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/35a8c659d97cd29085aaa0c6bbb7b80fe88b10fe -> aws-c-common-08.14-35a8c65.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/b517b7decd0dac30be2162f5186c250221c53aff -> aws-c-compression-0.2.16-b517b7d.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/0f6eee87aee2860598084e814e0eedc0b3b9122d -> aws-c-event-stream-0.2.20-0f6eee8.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/c7350090b8712d9a6fd66a7d5d45056c87879f26 -> aws-c-http-0.7.7-c735009.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/2c4475f60d9103d90a30fc4bc38940c0477d63d9 -> aws-c-io-0.13.21-2c4475f.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/e6ea3cc88d1654515519701b060a4c21098fcc8c -> aws-c-mqtt-0.8.11-e6ea3cc.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/d28492a40d1423e69cfaafbfa57bb5f8dce438e7 -> aws-c-s3-0.3.0-d28492a.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/75fa71a861f3185c1a25594a47772c0404eed6fc -> aws-c-sdkutils-0.1.9-75fa71a.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/ad53be196a25bbefa3700a01187fdce573a7d2d0 -> aws-checksums-0.1.14-ad53be1.tar.gz
	https://github.com/awslabs/aws-lc/tarball/bf9cd886a792740df5b21eb196ecc10d7dda9b6e -> aws-lc-1.9.0-bf9cd88.tar.gz
	https://github.com/aws/s2n-tls/tarball/635893c64ef42f8ac4bb509dd195a2027174171f -> s2n-tls-1.3.43-635893c.tar.gz
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