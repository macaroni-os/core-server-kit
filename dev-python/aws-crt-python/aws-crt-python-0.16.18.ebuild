# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/3c91fbce74ac153681ada4312199d6513f0ae39a -> aws-crt-python-0.16.18-3c91fbc.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/c3c542fe67225b81fa4bab9151c4d879f34587f4 -> aws-c-auth-0.6.28-c3c542f.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/c5f58572556bab507559d06662738220cc2f7b8a -> aws-c-cal-0.5.27-c5f5857.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/f77b55d0a48964afc7a5b8bee119d8dd38df7db1 -> aws-c-common-0.8.22-f77b55d.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/99ec79ee2970f1a045d4ced1501b97ee521f2f85 -> aws-c-compression-0.2.17-99ec79e.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/825e3188234b7d14c0e3934d88780152da412981 -> aws-c-event-stream-0.3.0-825e318.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/ac18abb489c1baeafb2fb9dec0c6d223601ad590 -> aws-c-http-0.7.8-ac18abb.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/118a57ecf0f88e047bb3e75227e08adb5782074c -> aws-c-io-0.13.22-118a57e.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/b672bff0907603987bc93dae946c4f121c80e14c -> aws-c-mqtt-0.8.12-b672bff.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/7fb4474ece6cbb26de06b2d184fee62ca625d389 -> aws-c-s3-0.3.4-7fb4474.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/812761fdbf791f77cb358212cefade9cc16974e7 -> aws-c-sdkutils-0.1.10-812761f.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/1aa903d5204ed665010204d8521e56e092932e32 -> aws-checksums-0.1.15-1aa903d.tar.gz
	https://github.com/awslabs/aws-lc/tarball/987bd7c672e2c3dd1cc76be3ce9eece93ba9bd88 -> aws-lc-1.10.0-987bd7c.tar.gz
	https://github.com/aws/s2n-tls/tarball/9b7b1f334a4ab33397174e505955231ff77b3f85 -> s2n-tls-1.3.44-9b7b1f3.tar.gz
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