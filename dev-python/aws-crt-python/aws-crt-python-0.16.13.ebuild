# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/87840f2451493ce497aa857814b4727340809092 -> aws-crt-python-0.16.13-87840f2.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/54f8d804120daab9e0d75a56a113a222b334d0f9 -> aws-c-auth-0.6.26-54f8d80.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/de2f0f2e86a7e7b85b28cc027b8cf620945d8825 -> aws-c-cal-0.5.21-de2f0f2.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/21d478b14465bfa52608d4040d9084e955180fa7 -> aws-c-common-0.8.15-21d478b.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/b517b7decd0dac30be2162f5186c250221c53aff -> aws-c-compression-0.2.16-b517b7d.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/0f6eee87aee2860598084e814e0eedc0b3b9122d -> aws-c-event-stream-0.2.20-0f6eee8.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/0600662610aa871a11aebe6ed67a11997317cbef -> aws-c-http-0.7.6-0600662.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/8f2ccc5e5a55e27fe866cc210dbcb0df16a5e70e -> aws-c-io-0.13.19-8f2ccc5.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/7e384c9d989f7936c7d403115b7983fa2b0727a0 -> aws-c-mqtt-0.8.8-7e384c9.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/89b6303122e6f491e219223d678f858da702dc5a -> aws-c-s3-0.2.7-89b6303.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/9de59230f025df2745b098feda3611f9667e5a35 -> aws-c-sdkutils-0.1.8-9de5923.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/ad53be196a25bbefa3700a01187fdce573a7d2d0 -> aws-checksums-0.1.14-ad53be1.tar.gz
	https://github.com/awslabs/aws-lc/tarball/af783fdbd76512215c81d5d1b1eacf313287be8c -> aws-lc-1.7.0-af783fd.tar.gz
	https://github.com/aws/s2n-tls/tarball/92b571ae3c71ad3a69511fae65982a93cb9a271b -> s2n-tls-1.3.42-92b571a.tar.gz
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