# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/1424d91777e0563597fe8bdc34e0bb3510a36585 -> aws-crt-python-0.21.0-1424d91.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/53a31bacf2918e848e00b052d2e25cba0be069d9 -> aws-c-auth-0.7.22-53a31ba.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/71810b1ade7af4747104ae245b74240ae8e8cf77 -> aws-c-cal-0.7.1-71810b1.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/6d974f92c1d86391c1dcb1173239adf757c52b2d -> aws-c-common-0.9.23-6d974f9.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/ea1d421a421ad83a540309a94c38d50b6a5d836b -> aws-c-compression-0.2.18-ea1d421.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/1a70c50f78a6e706f1f91a4ed138478271b6d9d3 -> aws-c-event-stream-0.4.2-1a70c50.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/d83f8d70143ddce5ab4e479175fbd44ba994211b -> aws-c-http-0.8.2-d83f8d7.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/878b4fa027bda4041493f06e0562d5e98bb3deb8 -> aws-c-io-0.14.9-878b4fa.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/ed7bbd68c03d7022c915a2924740ab7992ad2311 -> aws-c-mqtt-0.10.4-ed7bbd6.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/cb431ba06b5d3db4373cd8fb55d6c16464cbf2ea -> aws-c-s3-0.6.0-cb431ba.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/8c7af71f91ed5b9d2a043d51f120495f43723f80 -> aws-c-sdkutils-0.1.16-8c7af71.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/aac442a2dbbb5e72d0a3eca8313cf65e7e1cac2f -> aws-checksums-0.1.18-aac442a.tar.gz
	https://github.com/awslabs/aws-lc/tarball/05d3bfd6303c65d7392dee1a47d6e161c36a04e5 -> aws-lc-1.31.0-05d3bfd.tar.gz
	https://github.com/aws/s2n-tls/tarball/073c7b415a17d271a7b2c8c385d0e641fc94871f -> s2n-tls-1.4.17-073c7b4.tar.gz
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