# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/46966074b5abc551a0e6a8ed9ae3a50a0a7f4e0e -> aws-crt-python-0.27.0-4696607.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/cd9d6afcd42035d49bb2d0d3bef24b9faed57773 -> aws-c-auth-0.9.0-cd9d6af.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/fa108de5280afd71018e0a0534edb36b33f030f6 -> aws-c-cal-0.9.0-fa108de.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/8ae8f48ebddb0ee2624d643952ac33afa5e8859e -> aws-c-common-0.12.2-8ae8f48.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/f951ab2b819fc6993b6e5e6cfef64b1a1554bfc8 -> aws-c-compression-0.3.1-f951ab2.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/9312b052583183b98526aaeb91e5c72ec3db9627 -> aws-c-event-stream-0.5.4-9312b05.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/ca7e0e291933ad9dac855e1477c558254363ff6a -> aws-c-http-0.10.0-ca7e0e2.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/8286c781b95b426ca2f0783b6c1fe49ff519c4e7 -> aws-c-io-0.19.0-8286c78.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/9fc2f573c0fb608c052230d4f2495725d7252285 -> aws-c-mqtt-0.13.0-9fc2f57.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/5eac79fb577b05cc83e39ae3b01412c3d66ab69e -> aws-c-s3-0.7.16-5eac79f.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/ba6a28fab7ed5d7f1b3b1d12eb672088be093824 -> aws-c-sdkutils-0.2.3-ba6a28f.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/9978ba2c33a7a259c1a6bd0f62abe26827d03b85 -> aws-checksums-0.2.7-9978ba2.tar.gz
	https://github.com/awslabs/aws-lc/tarball/7d9cbf39f0fbf78ee47a71046c6a231f04b91e8d -> aws-lc-1.50.1-7d9cbf3.tar.gz
	https://github.com/aws/s2n-tls/tarball/1c5798b82442067bace943f748f4f24ae1770bed -> s2n-tls-1.5.18-1c5798b.tar.gz
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