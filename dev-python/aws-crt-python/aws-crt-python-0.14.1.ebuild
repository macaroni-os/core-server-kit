# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/4d0581e1d4642c5ab00009335599a2aeda2777ae -> aws-crt-python-0.14.1-4d0581e.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/831fa583b83574db29cbae139b42e0d7a1d1ebb8 -> aws-c-auth-0.6.15-831fa58.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/1458c70a26877345ca28e333a092096afd410774 -> aws-c-cal-0.5.18-1458c70.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/be35e65a6c67ae2ffd126516c9783ac1dd2e8910 -> aws-c-common-0.8.0-be35e65.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/5fab8bc5ab5321d86f6d153b06062419080820ec -> aws-c-compression-0.2.14-5fab8bc.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/3251031d6c9d3b9ea670fc59cf74151a15d8d2e3 -> aws-c-event-stream-0.2.13-3251031.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/30230bede737dda19dc5ed2b15bb37b70aeb71e1 -> aws-c-http-0.6.19-30230be.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/4e462a0687d00d18cfdece3cd7a427d8a9b2e13d -> aws-c-io-0.13.1-4e462a0.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/cea176e7f3ec32d1465788e95ae9c652014aa135 -> aws-c-mqtt-0.7.12-cea176e.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/b93780769953f661bcae294cd26fef76562aabe8 -> aws-c-s3-0.1.45-b937807.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/e3c23f4aca31d9e66df25827645f72cbcbfb657a -> aws-c-sdkutils-0.1.2-e3c23f4.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/41df3031b92120b6d8127b7b7122391d5ac6f33f -> aws-checksums-0.1.12-41df303.tar.gz
	https://github.com/awslabs/aws-lc/tarball/e7413d237bb60bf639e78aa43ff3c1b1783f0712 -> aws-lc-1.1.0-e7413d2.tar.gz
	https://github.com/aws/s2n-tls/tarball/12c98cd529b3bb8c779b5a45846aec6f452b9ed4 -> s2n-tls-1.3.20-12c98cd.tar.gz
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