# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/7431e2d562f622a782b89c4ef8f22de5e710e236 -> aws-crt-python-0.16.20-7431e2d.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/c3c542fe67225b81fa4bab9151c4d879f34587f4 -> aws-c-auth-0.6.28-c3c542f.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/c5f58572556bab507559d06662738220cc2f7b8a -> aws-c-cal-0.5.27-c5f5857.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/9f36d07189435db27f746c10e39ba58511fadd0d -> aws-c-common-0.8.23-9f36d07.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/99ec79ee2970f1a045d4ced1501b97ee521f2f85 -> aws-c-compression-0.2.17-99ec79e.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/825e3188234b7d14c0e3934d88780152da412981 -> aws-c-event-stream-0.3.0-825e318.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/27efc273f228306031c7345de8acaeee956db765 -> aws-c-http-0.7.10-27efc27.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/c3f95ebf3d6d1608e1656bb08eca05e303cc4fd3 -> aws-c-io-0.13.26-c3f95eb.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/8e40355e03b456bb7b4bf0cd37c5d878afa2476f -> aws-c-mqtt-0.8.13-8e40355.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/9263f9b2e1b38d2c19ad2ba3d82e0d77b99f602f -> aws-c-s3-0.3.8-9263f9b.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/df511a1f2518279eb5721ab5fca6bc816efc6b32 -> aws-c-sdkutils-0.1.11-df511a1.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/a5b0e7f00be4240f77d3b6e090c8bed3c9c2e536 -> aws-checksums-0.1.16-a5b0e7f.tar.gz
	https://github.com/awslabs/aws-lc/tarball/987bd7c672e2c3dd1cc76be3ce9eece93ba9bd88 -> aws-lc-1.10.0-987bd7c.tar.gz
	https://github.com/aws/s2n-tls/tarball/b9c4d60de49193cea31f0acfbddc47cc66d41d2c -> s2n-tls-1.3.45-b9c4d60.tar.gz
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