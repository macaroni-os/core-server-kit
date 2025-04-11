# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/e31ff4a78ab1226aeb2f1686ccdc5fb0a634c313 -> aws-crt-python-0.26.1-e31ff4a.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/cd9d6afcd42035d49bb2d0d3bef24b9faed57773 -> aws-c-auth-0.9.0-cd9d6af.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/ff8801488d588067d021d131193681b591699477 -> aws-c-cal-0.8.9-ff88014.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/8ae8f48ebddb0ee2624d643952ac33afa5e8859e -> aws-c-common-0.12.2-8ae8f48.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/f951ab2b819fc6993b6e5e6cfef64b1a1554bfc8 -> aws-c-compression-0.3.1-f951ab2.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/9312b052583183b98526aaeb91e5c72ec3db9627 -> aws-c-event-stream-0.5.4-9312b05.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/e526ac338ca414c01d3fc037da1c418c935808bc -> aws-c-http-0.9.6-e526ac3.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/31d7361dd7517c54e697316fec6ded2ebe89fee9 -> aws-c-io-0.18.1-31d7361.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/fb651a4a59f28384fdb4938524192433492dead0 -> aws-c-mqtt-0.12.3-fb651a4.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/0770d353ce2d04af0f2b1ee3680a8f827f28263f -> aws-c-s3-0.7.15-0770d35.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/ba6a28fab7ed5d7f1b3b1d12eb672088be093824 -> aws-c-sdkutils-0.2.3-ba6a28f.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/9978ba2c33a7a259c1a6bd0f62abe26827d03b85 -> aws-checksums-0.2.6-9978ba2.tar.gz
	https://github.com/awslabs/aws-lc/tarball/b1420f27a7c95762cd11b249ece3d049f530d9e6 -> aws-lc-1.49.1-b1420f2.tar.gz
	https://github.com/aws/s2n-tls/tarball/b8a9aa4ee53661e829e011e6881d5252d794ba8c -> s2n-tls-1.5.16-b8a9aa4.tar.gz
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