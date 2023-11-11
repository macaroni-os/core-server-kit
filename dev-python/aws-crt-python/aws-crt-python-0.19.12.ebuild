# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/b8a0468fa2e5a3e1614d1435805a0aa71b2b3fb6 -> aws-crt-python-0.19.12-b8a0468.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/71bad382fe0a61e4426987c1abe6aca2fe1c1953 -> aws-c-auth-0.7.6-71bad38.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/b52d9e8ee7af8155e6928c977ec5fde25a507ba0 -> aws-c-cal-0.6.9-b52d9e8.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/fefbf4bdca1b3bada588baefec059849c268e73e -> aws-c-common-0.9.9-fefbf4b.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/99ec79ee2970f1a045d4ced1501b97ee521f2f85 -> aws-c-compression-0.2.17-99ec79e.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/08f24e384e5be20bcffa42b49213d24dad7881ae -> aws-c-event-stream-0.3.2-08f24e3.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/a082f8a2067e4a31db73f1d4ffd702a8dc0f7089 -> aws-c-http-0.7.14-a082f8a.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/c9cb77747d3fd2809cf3d9c43be7d5decc17e4b3 -> aws-c-io-0.13.35-c9cb777.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/5d198cf2d09b19bb18bf03e4425831a246d0a391 -> aws-c-mqtt-0.9.9-5d198cf.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/89791b135926473c3fdd37099ab69d5161e144c1 -> aws-c-s3-0.3.23-89791b1.tar.gz
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