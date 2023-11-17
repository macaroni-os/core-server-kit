# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/c99844773c56d85301b71ea099f47be2110d04c7 -> aws-crt-python-0.19.13-c998447.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/50f3e0d1ce28e39d914818048d84e3f5a11afe43 -> aws-c-auth-0.7.7-50f3e0d.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/b52d9e8ee7af8155e6928c977ec5fde25a507ba0 -> aws-c-cal-0.6.9-b52d9e8.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/80f21b3cac5ac51c6b8a62c7d2a5ef58a75195ee -> aws-c-common-0.9.10-80f21b3.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/99ec79ee2970f1a045d4ced1501b97ee521f2f85 -> aws-c-compression-0.2.17-99ec79e.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/08f24e384e5be20bcffa42b49213d24dad7881ae -> aws-c-event-stream-0.3.2-08f24e3.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/a082f8a2067e4a31db73f1d4ffd702a8dc0f7089 -> aws-c-http-0.7.14-a082f8a.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/c9cb77747d3fd2809cf3d9c43be7d5decc17e4b3 -> aws-c-io-0.13.35-c9cb777.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/5d198cf2d09b19bb18bf03e4425831a246d0a391 -> aws-c-mqtt-0.9.9-5d198cf.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/83008e577804643bc632ae4e603f36ab96219b9b -> aws-c-s3-0.3.24-83008e5.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/a6fd80cf7c163062d31abb28f309e47330fbfc17 -> aws-c-sdkutils-0.1.12-a6fd80c.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/321b805559c8e911be5bddba13fcbd222a3e2d3a -> aws-checksums-0.1.17-321b805.tar.gz
	https://github.com/awslabs/aws-lc/tarball/a8d06de79e405692ac06fe17163626eaab515e4e -> aws-lc-1.17.3-a8d06de.tar.gz
	https://github.com/aws/s2n-tls/tarball/95753f0c528b59025343e8799cb25d3e9df89e21 -> s2n-tls-1.3.56-95753f0.tar.gz
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