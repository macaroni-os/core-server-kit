# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/c88e3f18075713d90b467ed0addb09c76dc3226c -> aws-crt-python-0.15.2-c88e3f1.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/d56e18d8acd94d7e237ff27fce2f66632988d1cf -> aws-c-auth-0.6.18-d56e18d.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/ac4216b78d5323b5b8ce95a3dd4a8fc0f95e2d33 -> aws-c-cal-0.5.20-ac4216b.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/d6a6a6057afd8024cf2790a50de4a9818014cec6 -> aws-c-common-0.8.5-d6a6a60.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/63e1ada3d1c1b2d337e9edc5ea977b1f17450ded -> aws-c-compression-0.2.15-63e1ada.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/39bfa94a14b7126bf0c1330286ef8db452d87e66 -> aws-c-event-stream-0.2.15-39bfa94.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/e80c70d75f58a5b62870ac980cc3abff1f38db1f -> aws-c-http-0.6.24-e80c70d.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/51d4a9486f354f47b172a85059aa08a925b7234c -> aws-c-io-0.13.7-51d4a94.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/882c689561a3db1466330ccfe3b63637e0a575d3 -> aws-c-mqtt-0.7.13-882c689.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/a41255ece72a7c887bba7f9d998ca3e14f4c8a1b -> aws-c-s3-0.1.51-a41255e.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/25bf5cf225f977c3accc6a05a0a7a181ef2a4a30 -> aws-c-sdkutils-0.1.6-25bf5cf.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/48e7c0e01479232f225c8044d76c84e74192889d -> aws-checksums-0.1.13-48e7c0e.tar.gz
	https://github.com/awslabs/aws-lc/tarball/75a73bfabf1be384b49c7f92da6fdfd9d867069e -> aws-lc-1.3.0-75a73bf.tar.gz
	https://github.com/aws/s2n-tls/tarball/15d534e8a9ca1eda6bacee514e37d08b4f38a526 -> s2n-tls-1.3.27-15d534e.tar.gz
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