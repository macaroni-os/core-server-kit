# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/c11a5542141c1508d259a08e1c1d1db6a0b4c0a0 -> aws-crt-python-0.20.9-c11a554.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/ef9cfa19de9ac6538dfcf40fabfbf2e77061df67 -> aws-c-auth-0.7.20-ef9cfa1.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/45f82ed8508752f01627bd08073282e427fad8c0 -> aws-c-cal-0.6.13-45f82ed.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/24e23967895201639d7781651b217c8726977d1b -> aws-c-common-0.9.18-24e2396.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/ea1d421a421ad83a540309a94c38d50b6a5d836b -> aws-c-compression-0.2.18-ea1d421.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/1a70c50f78a6e706f1f91a4ed138478271b6d9d3 -> aws-c-event-stream-0.4.2-1a70c50.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/98ec73ad0c18b78ba08d40b4e60d97abf794f24d -> aws-c-http-0.8.1-98ec73a.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/47be63c809e32c6923fd7fd80f67d86cef458d5d -> aws-c-io-0.14.8-47be63c.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/ed7bbd68c03d7022c915a2924740ab7992ad2311 -> aws-c-mqtt-0.10.4-ed7bbd6.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/cc06c419448b40417caa7b587f61bb4d8b4c08c1 -> aws-c-s3-0.5.8-cc06c41.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/8c7af71f91ed5b9d2a043d51f120495f43723f80 -> aws-c-sdkutils-0.1.16-8c7af71.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/aac442a2dbbb5e72d0a3eca8313cf65e7e1cac2f -> aws-checksums-0.1.18-aac442a.tar.gz
	https://github.com/awslabs/aws-lc/tarball/2c03113451b5f84f61c8ed283b289a6db87b3397 -> aws-lc-1.26.0-2c03113.tar.gz
	https://github.com/aws/s2n-tls/tarball/e7ba5b3ec6ee08baae8b682bcec873c0c9938434 -> s2n-tls-1.4.13-e7ba5b3.tar.gz
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