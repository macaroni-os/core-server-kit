# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/f2f9b6cdefafe205dd96529f062b647fb0a2173b -> aws-crt-python-0.23.8-f2f9b6c.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/274a1d21330731cc51bb742794adc70ada5f4380 -> aws-c-auth-0.8.3-274a1d2.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/fbbe2612a3385d1ded02a52d20ad7fd2da4501f4 -> aws-c-cal-0.8.1-fbbe261.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/5e6c08186fa5d8c7679acf95b86ada4119ca23b8 -> aws-c-common-0.10.9-5e6c081.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/c6c1191e525e5aa6ead9e1afc392e35d3b50331e -> aws-c-compression-0.3.0-c6c1191.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/d2dcc9344dae24de320866045d85166d8a91a0d1 -> aws-c-event-stream-0.5.0-d2dcc93.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/fc3eded2465c37d07fd9cc15e9b5b011224c9c9a -> aws-c-http-0.9.2-fc3eded.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/fcb38c804364dd627c335da752a99a125a88f6e9 -> aws-c-io-0.15.3-fcb38c8.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/627c3334e52021aa8d5772b6ca076884610f3219 -> aws-c-mqtt-0.11.0-627c333.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/aef075b7db620cd32fbe1ec19a819c1b0acd2e79 -> aws-c-s3-0.7.10-aef075b.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/1ae8664f90cb5ab5e23b161a31e021c6d3a28e72 -> aws-c-sdkutils-0.2.2-1ae8664.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/3e4101b9f85a2c090774d27ae2131fca1082f522 -> aws-checksums-0.2.2-3e4101b.tar.gz
	https://github.com/awslabs/aws-lc/tarball/ffd6fb71b1e1582a620149337b77706f2391578d -> aws-lc-1.43.0-ffd6fb7.tar.gz
	https://github.com/aws/s2n-tls/tarball/6cc9f53d7ab5f0427ae5f838891fff57844a9e3f -> s2n-tls-1.5.11-6cc9f53.tar.gz
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