# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/9f0cf1d1b3754d2f2d428b4e92f64b01885b8bae -> aws-crt-python-0.13.1-9f0cf1d.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/e1b95cca6f2248c28b66ddb40bcccd35a59cb8b5 -> aws-c-auth-0.6.11-e1b95cc.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/9ab6f96e5aba10b2e337c51e62d9400f001cfe0c -> aws-c-cal-0.5.14-9ab6f96.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/d9031cf4f02fe4d8c24a53bb6c8df67ce8be9f0c -> aws-c-common-0.6.19-d9031cf.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/5fab8bc5ab5321d86f6d153b06062419080820ec -> aws-c-compression-0.2.14-5fab8bc.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/e87537be561d753ec82e783bc0929b1979c585f8 -> aws-c-event-stream-0.2.7-e87537b.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/f686b89d8c3f500387db10a7f1614eadebf0b0ff -> aws-c-http-0.6.12-f686b89.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/6e695d26115a799a000608167df74a6cd3b0b717 -> aws-c-io-0.10.19-6e695d2.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/6168e32bf9f745dec40df633b78baa03420b7f83 -> aws-c-mqtt-0.7.10-6168e32.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/303d62cfc05cfb2807cacf7fe1b3721dfe8ad216 -> aws-c-s3-0.1.36-303d62c.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/e3c23f4aca31d9e66df25827645f72cbcbfb657a -> aws-c-sdkutils-0.1.2-e3c23f4.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/41df3031b92120b6d8127b7b7122391d5ac6f33f -> aws-checksums-0.1.12-41df303.tar.gz
	https://github.com/awslabs/aws-lc/tarball/b40498737348fee436a65e2a4badfb392acca36d -> aws-lc-1.0.1-b404987.tar.gz
	https://github.com/aws/s2n-tls/tarball/df0429a28db247235b9a0f66fa3a9be191c9d365 -> s2n-tls-1.3.9-df0429a.tar.gz
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