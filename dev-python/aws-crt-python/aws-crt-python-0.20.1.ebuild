# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/f4a52c8f5f480fcdfe4126c00bea2c0a35eb380a -> aws-crt-python-0.20.1-f4a52c8.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/6ba7a0f8688c713dfe137716dbd5be324c2315b0 -> aws-c-auth-0.7.10-6ba7a0f.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/b52d9e8ee7af8155e6928c977ec5fde25a507ba0 -> aws-c-cal-0.6.9-b52d9e8.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/8eaa0986ad3cfd46c87432a2e4c8ab81a786085f -> aws-c-common-0.9.12-8eaa098.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/99ec79ee2970f1a045d4ced1501b97ee521f2f85 -> aws-c-compression-0.2.17-99ec79e.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/63d1e1021b04ce3c3b1fc1895078ac85e0430b24 -> aws-c-event-stream-0.4.0-63d1e10.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/6a1c157c20640a607102738909e89561a41e91e9 -> aws-c-http-0.8.0-6a1c157.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/749c87e551465ff1a3c2e8a77b1181bccff2f4b6 -> aws-c-io-0.14.0-749c87e.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/17ee24a2177fc64cf9773d430a24e6fa06a89dd0 -> aws-c-mqtt-0.10.1-17ee24a.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/1dd55be83b19a55cd9c155e2da977cdc76112a91 -> aws-c-s3-0.4.9-1dd55be.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/fd8c0ba2e233997eaaefe82fb818b8b444b956d3 -> aws-c-sdkutils-0.1.13-fd8c0ba.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/321b805559c8e911be5bddba13fcbd222a3e2d3a -> aws-checksums-0.1.17-321b805.tar.gz
	https://github.com/awslabs/aws-lc/tarball/dc4e28145ceb6d46b5475e833f2da8def6d583fe -> aws-lc-1.19.0-dc4e281.tar.gz
	https://github.com/aws/s2n-tls/tarball/a9a07a25fa0d897ba6ad2b161b4b8ea9e97b6abd -> s2n-tls-1.4.1-a9a07a2.tar.gz
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