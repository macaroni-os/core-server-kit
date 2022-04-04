# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/6a83ec6ab4c56d2b41e1e90c8bd6e69affad7a0f -> aws-crt-python-0.13.8-6a83ec6.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/e1b95cca6f2248c28b66ddb40bcccd35a59cb8b5 -> aws-c-auth-0.6.11-e1b95cc.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/611690ff1087e7e1481480606f3d491f4914f93b -> aws-c-cal-0.5.15-611690f.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/d9031cf4f02fe4d8c24a53bb6c8df67ce8be9f0c -> aws-c-common-0.6.19-d9031cf.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/5fab8bc5ab5321d86f6d153b06062419080820ec -> aws-c-compression-0.2.14-5fab8bc.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/e87537be561d753ec82e783bc0929b1979c585f8 -> aws-c-event-stream-0.2.7-e87537b.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/3f8ffda541eab815646f739cef2b350d6e7d5406 -> aws-c-http-0.6.13-3f8ffda.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/59b4225bb87021d44d7fd2509b54d7038f11b7e7 -> aws-c-io-0.10.20-59b4225.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/6168e32bf9f745dec40df633b78baa03420b7f83 -> aws-c-mqtt-0.7.10-6168e32.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/85b791a1ce06812b24ee66825f65f0380aa5cc80 -> aws-c-s3-0.1.37-85b791a.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/e3c23f4aca31d9e66df25827645f72cbcbfb657a -> aws-c-sdkutils-0.1.2-e3c23f4.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/41df3031b92120b6d8127b7b7122391d5ac6f33f -> aws-checksums-0.1.12-41df303.tar.gz
	https://github.com/awslabs/aws-lc/tarball/11b50d39cf2378703a4ca6b6fee9d76a2e9852d1 -> aws-lc-1.0.2-11b50d3.tar.gz
	https://github.com/aws/s2n-tls/tarball/88c7ae4d3fd9b3e9e49fcecc9bee1ddb8099ae70 -> s2n-tls-1.3.10-88c7ae4.tar.gz
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