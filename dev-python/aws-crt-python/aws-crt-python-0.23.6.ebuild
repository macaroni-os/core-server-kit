# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/2abf5680c4aada7486dac9e57d669168f4805893 -> aws-crt-python-0.23.6-2abf568.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/3982bd75fea74efd8f9b462b27fedd4599db4f53 -> aws-c-auth-0.8.0-3982bd7.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/fbbe2612a3385d1ded02a52d20ad7fd2da4501f4 -> aws-c-cal-0.8.1-fbbe261.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/7a6f5df201cb4b1910932ea3221de83edaa39880 -> aws-c-common-0.10.6-7a6f5df.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/c6c1191e525e5aa6ead9e1afc392e35d3b50331e -> aws-c-compression-0.3.0-c6c1191.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/d2dcc9344dae24de320866045d85166d8a91a0d1 -> aws-c-event-stream-0.5.0-d2dcc93.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/fc3eded2465c37d07fd9cc15e9b5b011224c9c9a -> aws-c-http-0.9.2-fc3eded.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/fcb38c804364dd627c335da752a99a125a88f6e9 -> aws-c-io-0.15.3-fcb38c8.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/627c3334e52021aa8d5772b6ca076884610f3219 -> aws-c-mqtt-0.11.0-627c333.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/a3b401bfb53c28c88a930d496b481311dd76a4f5 -> aws-c-s3-0.7.9-a3b401b.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/1ae8664f90cb5ab5e23b161a31e021c6d3a28e72 -> aws-c-sdkutils-0.2.2-1ae8664.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/3e4101b9f85a2c090774d27ae2131fca1082f522 -> aws-checksums-0.2.2-3e4101b.tar.gz
	https://github.com/awslabs/aws-lc/tarball/697acc6616736ad07539fda1e0726cc043e1097a -> aws-lc-1.42.0-697acc6.tar.gz
	https://github.com/aws/s2n-tls/tarball/2e79e7efeb26f06eb59a1d4f3444ea63fc3e20c3 -> s2n-tls-1.5.10-2e79e7e.tar.gz
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