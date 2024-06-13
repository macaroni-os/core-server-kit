# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/e88cce2674ab8cc39ed2104d10bdb90cb2f30b77 -> aws-crt-python-0.20.12-e88cce2.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/53a31bacf2918e848e00b052d2e25cba0be069d9 -> aws-c-auth-0.7.22-53a31ba.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/96c47e339d030d1fa4eaca201be948bc4442510d -> aws-c-cal-0.6.15-96c47e3.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/4f874cea50a70bc6ebcd85c6ce1c6c0016b5aff4 -> aws-c-common-0.9.21-4f874ce.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/ea1d421a421ad83a540309a94c38d50b6a5d836b -> aws-c-compression-0.2.18-ea1d421.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/1a70c50f78a6e706f1f91a4ed138478271b6d9d3 -> aws-c-event-stream-0.4.2-1a70c50.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/d83f8d70143ddce5ab4e479175fbd44ba994211b -> aws-c-http-0.8.2-d83f8d7.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/878b4fa027bda4041493f06e0562d5e98bb3deb8 -> aws-c-io-0.14.9-878b4fa.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/ed7bbd68c03d7022c915a2924740ab7992ad2311 -> aws-c-mqtt-0.10.4-ed7bbd6.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/6588f9a714ee7a8be1bddd63ea5ea1ea224d00b4 -> aws-c-s3-0.5.10-6588f9a.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/8c7af71f91ed5b9d2a043d51f120495f43723f80 -> aws-c-sdkutils-0.1.16-8c7af71.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/aac442a2dbbb5e72d0a3eca8313cf65e7e1cac2f -> aws-checksums-0.1.18-aac442a.tar.gz
	https://github.com/awslabs/aws-lc/tarball/4e54dd8363396f257d7a2317c48101e18170e6fb -> aws-lc-1.29.0-4e54dd8.tar.gz
	https://github.com/aws/s2n-tls/tarball/114ccab0ff2cde491203ac841837d0d39b767412 -> s2n-tls-1.4.16-114ccab.tar.gz
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