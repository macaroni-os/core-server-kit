# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/e683fa62909d9f77f8334e1d9453b3584b15b9ba -> aws-crt-python-0.14.7-e683fa6.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/d56e18d8acd94d7e237ff27fce2f66632988d1cf -> aws-c-auth-0.6.18-d56e18d.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/ac4216b78d5323b5b8ce95a3dd4a8fc0f95e2d33 -> aws-c-cal-0.5.20-ac4216b.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/c4fd34c0d553c5c79b5eb3316ce480b73368eb9e -> aws-c-common-0.8.3-c4fd34c.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/63e1ada3d1c1b2d337e9edc5ea977b1f17450ded -> aws-c-compression-0.2.15-63e1ada.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/39bfa94a14b7126bf0c1330286ef8db452d87e66 -> aws-c-event-stream-0.2.15-39bfa94.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/82fb7edcb3834f830da15c68b3325dd6f8fa9d4a -> aws-c-http-0.6.22-82fb7ed.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/cd0241349d58a096a27d66e56485e5befe3c9eb5 -> aws-c-io-0.13.5-cd02413.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/cea176e7f3ec32d1465788e95ae9c652014aa135 -> aws-c-mqtt-0.7.12-cea176e.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/185068198ee6e3bc2146643d82a9cf798aa63e8e -> aws-c-s3-0.1.50-1850681.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/2d9ef421f88ab9599f1a128fd4567c2ada64a6b8 -> aws-c-sdkutils-0.1.3-2d9ef42.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/48e7c0e01479232f225c8044d76c84e74192889d -> aws-checksums-0.1.13-48e7c0e.tar.gz
	https://github.com/awslabs/aws-lc/tarball/75a73bfabf1be384b49c7f92da6fdfd9d867069e -> aws-lc-1.3.0-75a73bf.tar.gz
	https://github.com/aws/s2n-tls/tarball/72a3a37f0f807fe53cd2d56f08c27a7416dbecff -> s2n-tls-1.3.26-72a3a37.tar.gz
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