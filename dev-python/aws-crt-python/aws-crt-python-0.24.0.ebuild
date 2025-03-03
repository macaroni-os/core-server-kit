# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/a49892ada6a52c1a2ad8ab5cd25d18773b57f395 -> aws-crt-python-0.24.0-a49892a.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/2d85beff96bee7ee4734c21c7fc6b15e9d07b85e -> aws-c-auth-0.8.5-2d85bef.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/7299c6ab9244595b140d604475cdd6c6921be8ae -> aws-c-cal-0.8.3-7299c6a.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/6401c830ffcd82ee9c9e26255f2fadf7092c7321 -> aws-c-common-0.11.1-6401c83.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/f951ab2b819fc6993b6e5e6cfef64b1a1554bfc8 -> aws-c-compression-0.3.1-f951ab2.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/4bd476bd0c629e8fab4ec0ace92830efc6a79e6c -> aws-c-event-stream-0.5.2-4bd476b.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/590c7b597f87e5edc080b8b77418690c30319832 -> aws-c-http-0.9.3-590c7b5.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/318f7e57e7871e5b0d48a281cc5dcb7f79ccecdd -> aws-c-io-0.17.0-318f7e5.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/f0cc34cb6f54e050275e3c859594c62776d46d83 -> aws-c-mqtt-0.12.2-f0cc34c.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/6eb8be530b100fed5c6d24ca48a57ee2e6098fbf -> aws-c-s3-0.7.11-6eb8be5.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/ba6a28fab7ed5d7f1b3b1d12eb672088be093824 -> aws-c-sdkutils-0.2.3-ba6a28f.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/fb8bd0b8cff00c8c24a35d601fce1b4c611df6da -> aws-checksums-0.2.3-fb8bd0b.tar.gz
	https://github.com/awslabs/aws-lc/tarball/b596787531313454fd538f7d207a63d34b072963 -> aws-lc-1.47.0-b596787.tar.gz
	https://github.com/aws/s2n-tls/tarball/21cefc1091b3953ef543c9e72b932b6431fadc6e -> s2n-tls-1.5.13-21cefc1.tar.gz
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