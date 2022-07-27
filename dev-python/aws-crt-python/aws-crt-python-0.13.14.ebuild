# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/fcb1b2d526127c46cb0621671d91732432941ba8 -> aws-crt-python-0.13.14-fcb1b2d.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/59556cd46e684e5bfa27aa074caa77795ce3869f -> aws-c-auth-0.6.14-59556cd.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/7eb1d7360ea205ff275d2acc6cce2682063b643f -> aws-c-cal-0.5.17-7eb1d73.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/6e5931817bdd8d94efbaa286ae8175241a3ce10c -> aws-c-common-0.7.5-6e59318.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/5fab8bc5ab5321d86f6d153b06062419080820ec -> aws-c-compression-0.2.14-5fab8bc.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/158d8e9c0c4684a218c0309ffe80f7ff765c3f1e -> aws-c-event-stream-0.2.12-158d8e9.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/30230bede737dda19dc5ed2b15bb37b70aeb71e1 -> aws-c-http-0.6.19-30230be.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/c1c97db6cfab078271796583c43db7e0bd6a4c43 -> aws-c-io-0.12.0-c1c97db.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/936b788b477fc7f3227bef2d86037bbfa462316a -> aws-c-mqtt-0.7.11-936b788.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/4ff8318321636c66a1156d372de4d8fe53a78860 -> aws-c-s3-0.1.44-4ff8318.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/e3c23f4aca31d9e66df25827645f72cbcbfb657a -> aws-c-sdkutils-0.1.2-e3c23f4.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/41df3031b92120b6d8127b7b7122391d5ac6f33f -> aws-checksums-0.1.12-41df303.tar.gz
	https://github.com/awslabs/aws-lc/tarball/e7413d237bb60bf639e78aa43ff3c1b1783f0712 -> aws-lc-1.1.0-e7413d2.tar.gz
	https://github.com/aws/s2n-tls/tarball/9b0078adb44650f1618df1a087e24d3f031b8194 -> s2n-tls-1.3.18-9b0078a.tar.gz
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