# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/4e02ae720bffecbb1120f24dde98cd06183f2ad3 -> aws-crt-python-0.20.0-4e02ae7.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/baeffa791d9d1cf61460662a6d9ac2186aaf05df -> aws-c-auth-0.7.8-baeffa7.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/b52d9e8ee7af8155e6928c977ec5fde25a507ba0 -> aws-c-cal-0.6.9-b52d9e8.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/80f21b3cac5ac51c6b8a62c7d2a5ef58a75195ee -> aws-c-common-0.9.10-80f21b3.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/99ec79ee2970f1a045d4ced1501b97ee521f2f85 -> aws-c-compression-0.2.17-99ec79e.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/08f24e384e5be20bcffa42b49213d24dad7881ae -> aws-c-event-stream-0.3.2-08f24e3.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/18352c8e065c29e3451fb6161ebc246364e12cf6 -> aws-c-http-0.7.15-18352c8.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/df64f57feb63ab1a489ded86a87b756a48c46f35 -> aws-c-io-0.13.36-df64f57.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/eac4be396ec7499bd520724dcd91c4d5df3b729f -> aws-c-mqtt-0.10.0-eac4be3.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/c91f4c3c3bbee8dcd4a49cff0713825aef33e7cb -> aws-c-s3-0.4.6-c91f4c3.tar.gz
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