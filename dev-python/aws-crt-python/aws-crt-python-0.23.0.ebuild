# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/22daf3c3f8bf4f4624e6ae6b4983c4a5df8fe464 -> aws-crt-python-0.23.0-22daf3c.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/3982bd75fea74efd8f9b462b27fedd4599db4f53 -> aws-c-auth-0.8.0-3982bd7.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/656762aefbee2bc8f509cb23cd107abff20a72bb -> aws-c-cal-0.8.0-656762a.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/f41b772f0de9454a4e7a65750b58c2379533bbf1 -> aws-c-common-0.10.0-f41b772.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/c6c1191e525e5aa6ead9e1afc392e35d3b50331e -> aws-c-compression-0.3.0-c6c1191.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/d2dcc9344dae24de320866045d85166d8a91a0d1 -> aws-c-event-stream-0.5.0-d2dcc93.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/74b3a0dd1396b72f701c8bdf24e5c6f41e52cf87 -> aws-c-http-0.9.0-74b3a0d.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/fe93d0afcc1cede32ac9569abd8669ed011b1b8c -> aws-c-io-0.15.0-fe93d0a.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/627c3334e52021aa8d5772b6ca076884610f3219 -> aws-c-mqtt-0.11.0-627c333.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/8c1969bce5bfe0e063cbc719182dbe344342b880 -> aws-c-s3-0.7.0-8c1969b.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/0818f28ee436b892f09fbe8e3a6ae37ff40e9436 -> aws-c-sdkutils-0.2.0-0818f28.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/0d2f5521f61215f38f791d106ae304402208112d -> aws-checksums-0.2.0-0d2f552.tar.gz
	https://github.com/awslabs/aws-lc/tarball/8ffe277c21915ca82dc78a3bdc6a92e10c284b92 -> aws-lc-1.37.0-8ffe277.tar.gz
	https://github.com/aws/s2n-tls/tarball/ae74eb53ddee12a4cbf6348a27cfb1376b80909d -> s2n-tls-1.5.6-ae74eb5.tar.gz
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