# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/5a67c680c948454c18218c54f0d949d4b92ebea1 -> aws-crt-python-0.22.0-5a67c68.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/48d647bf43f8872e4dc5ec6343b0c5974195fbdd -> aws-c-auth-0.7.31-48d647b.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/2cb1d2eac925e2dbc45025eb89af82bd790c23a0 -> aws-c-cal-0.7.4-2cb1d2e.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/f8c5d8e5134fa97955351a44f16b84f96de24045 -> aws-c-common-0.9.29-f8c5d8e.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/f36d01672d61e49d96a777870d456f66fa391cd4 -> aws-c-compression-0.2.19-f36d016.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/1b3825fc9cae2e9c7ed7479ee5d354d52ebdf7a0 -> aws-c-event-stream-0.4.3-1b3825f.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/6068653e1d582bd8e7d1c9f81f86beaf10444e3d -> aws-c-http-0.8.10-6068653.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/dc41ddc498c10ebbf69aba7775afa36c8c1910bd -> aws-c-io-0.14.19-dc41ddc.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/77d6f00e89b10e3263d8a17576ec8e91c45b4606 -> aws-c-mqtt-0.10.7-77d6f00.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/ab70f742962131f1d024deb794d86f210bfa4252 -> aws-c-s3-0.6.7-ab70f74.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/4658412a61ad5749db92a8d1e0717cb5e76ada1c -> aws-c-sdkutils-0.1.19-4658412.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/ce04ab00b3ecc41912f478bfedca39f8e1919d6b -> aws-checksums-0.1.20-ce04ab0.tar.gz
	https://github.com/awslabs/aws-lc/tarball/8b2ebfcf3fc8b0656f1f4161166484a70238aeaa -> aws-lc-1.36.1-8b2ebfc.tar.gz
	https://github.com/aws/s2n-tls/tarball/ffe0bf42da8f139eff8fd2237f47fbde40b478fb -> s2n-tls-1.5.5-ffe0bf4.tar.gz
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