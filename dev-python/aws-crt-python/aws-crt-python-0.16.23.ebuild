# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/fc7074dc36eb634ccedac5cb0c92a93af71c7d41 -> aws-crt-python-0.16.23-fc7074d.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/c076002aa2bc051e81dec988aaa3e88895b242dd -> aws-c-auth-0.7.0-c076002.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/de43d69dbda4e2a048620c28767174483397f72f -> aws-c-cal-0.6.0-de43d69.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/9f36d07189435db27f746c10e39ba58511fadd0d -> aws-c-common-0.8.23-9f36d07.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/99ec79ee2970f1a045d4ced1501b97ee521f2f85 -> aws-c-compression-0.2.17-99ec79e.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/ec1716c726babd1381560aa8d28941fffc987394 -> aws-c-event-stream-0.3.1-ec1716c.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/27efc273f228306031c7345de8acaeee956db765 -> aws-c-http-0.7.10-27efc27.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/e87baa29fb621c8b42146c0206867f012f1acf23 -> aws-c-io-0.13.28-e87baa2.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/83e7abe4fbc34c0e4737c1472e585fdf47a5f4dd -> aws-c-mqtt-0.8.14-83e7abe.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/bc9c8b20030beb854b16eef05b20abbb55f15df6 -> aws-c-s3-0.3.13-bc9c8b2.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/df511a1f2518279eb5721ab5fca6bc816efc6b32 -> aws-c-sdkutils-0.1.11-df511a1.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/a5b0e7f00be4240f77d3b6e090c8bed3c9c2e536 -> aws-checksums-0.1.16-a5b0e7f.tar.gz
	https://github.com/awslabs/aws-lc/tarball/cb7712dfa896d32d55992e2cb13d5fa54fb77002 -> aws-lc-1.12.0-cb7712d.tar.gz
	https://github.com/aws/s2n-tls/tarball/e954ee5dc878c5c343d35574e7d07246a1e59314 -> s2n-tls-1.3.46-e954ee5.tar.gz
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