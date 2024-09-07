# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/2dae492d57b40c68839f2ecd7867bea34e6f9f1a -> aws-crt-python-0.21.5-2dae492.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/e930f1a64cb3d6b13dbd89c5c9badc5d9d3de1c3 -> aws-c-auth-0.7.29-e930f1a.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/2cb1d2eac925e2dbc45025eb89af82bd790c23a0 -> aws-c-cal-0.7.4-2cb1d2e.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/b9959f5922a4b969beab8f0b99aa0b34bc9ee55c -> aws-c-common-0.9.28-b9959f5.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/f36d01672d61e49d96a777870d456f66fa391cd4 -> aws-c-compression-0.2.19-f36d016.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/1b3825fc9cae2e9c7ed7479ee5d354d52ebdf7a0 -> aws-c-event-stream-0.4.3-1b3825f.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/4e74ab1e3702763e0b87bd1752f5a37c2f0400ac -> aws-c-http-0.8.8-4e74ab1.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/c345d77274db83c0c2e30331814093e7c84c45e2 -> aws-c-io-0.14.18-c345d77.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/ed7bbd68c03d7022c915a2924740ab7992ad2311 -> aws-c-mqtt-0.10.4-ed7bbd6.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/502cd6249c6523583c19b122c65e02cf74301b3e -> aws-c-s3-0.6.5-502cd62.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/4658412a61ad5749db92a8d1e0717cb5e76ada1c -> aws-c-sdkutils-0.1.19-4658412.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/779b5f350eed7fb784bb3c6700b7532e3fdd84ff -> aws-checksums-0.1.19-779b5f3.tar.gz
	https://github.com/awslabs/aws-lc/tarball/2f1879759b2e0fc70592665bdf10087b64f44b7d -> aws-lc-1.34.2-2f18797.tar.gz
	https://github.com/aws/s2n-tls/tarball/08d413a0b9b3226e775a38f04e3cf02230cc97c4 -> s2n-tls-1.5.2-08d413a.tar.gz
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