# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/1a20c4ef3b2b14f27238f91e5bcae3436b058646 -> aws-crt-python-0.21.6-1a20c4e.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/48d647bf43f8872e4dc5ec6343b0c5974195fbdd -> aws-c-auth-0.7.31-48d647b.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/2cb1d2eac925e2dbc45025eb89af82bd790c23a0 -> aws-c-cal-0.7.4-2cb1d2e.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/b9959f5922a4b969beab8f0b99aa0b34bc9ee55c -> aws-c-common-0.9.28-b9959f5.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/f36d01672d61e49d96a777870d456f66fa391cd4 -> aws-c-compression-0.2.19-f36d016.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/1b3825fc9cae2e9c7ed7479ee5d354d52ebdf7a0 -> aws-c-event-stream-0.4.3-1b3825f.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/6068653e1d582bd8e7d1c9f81f86beaf10444e3d -> aws-c-http-0.8.10-6068653.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/c345d77274db83c0c2e30331814093e7c84c45e2 -> aws-c-io-0.14.18-c345d77.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/c43232c1bc378344bb7245d7fcb167410f3fe931 -> aws-c-mqtt-0.10.5-c43232c.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/502cd6249c6523583c19b122c65e02cf74301b3e -> aws-c-s3-0.6.5-502cd62.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/4658412a61ad5749db92a8d1e0717cb5e76ada1c -> aws-c-sdkutils-0.1.19-4658412.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/ce04ab00b3ecc41912f478bfedca39f8e1919d6b -> aws-checksums-0.1.20-ce04ab0.tar.gz
	https://github.com/awslabs/aws-lc/tarball/d3a598c1b419d49b5b08f0677add4581572e2edc -> aws-lc-1.35.0-d3a598c.tar.gz
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