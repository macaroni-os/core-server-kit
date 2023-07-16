# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/3bc469ea77b2b26d04c1c8034758e4379a27c5a5 -> aws-crt-python-0.16.24-3bc469e.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/c076002aa2bc051e81dec988aaa3e88895b242dd -> aws-c-auth-0.7.0-c076002.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/de43d69dbda4e2a048620c28767174483397f72f -> aws-c-cal-0.6.0-de43d69.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/9f36d07189435db27f746c10e39ba58511fadd0d -> aws-c-common-0.8.23-9f36d07.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/99ec79ee2970f1a045d4ced1501b97ee521f2f85 -> aws-c-compression-0.2.17-99ec79e.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/ec1716c726babd1381560aa8d28941fffc987394 -> aws-c-event-stream-0.3.1-ec1716c.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/f800427e2e2878cf8b36f602583758769a7b3b4a -> aws-c-http-0.7.11-f800427.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/0642c68425f126e833fcf91bdc53dfc32366d0ba -> aws-c-io-0.13.29-0642c68.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/83e7abe4fbc34c0e4737c1472e585fdf47a5f4dd -> aws-c-mqtt-0.8.14-83e7abe.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/bc9c8b20030beb854b16eef05b20abbb55f15df6 -> aws-c-s3-0.3.13-bc9c8b2.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/df511a1f2518279eb5721ab5fca6bc816efc6b32 -> aws-c-sdkutils-0.1.11-df511a1.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/321b805559c8e911be5bddba13fcbd222a3e2d3a -> aws-checksums-0.1.17-321b805.tar.gz
	https://github.com/awslabs/aws-lc/tarball/1dd5cf92e96edd4092bc307b14969dae5eaaa507 -> aws-lc-1.12.1-1dd5cf9.tar.gz
	https://github.com/aws/s2n-tls/tarball/de987864288ce361707774e5af17d0458966c898 -> s2n-tls-1.3.47-de98786.tar.gz
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