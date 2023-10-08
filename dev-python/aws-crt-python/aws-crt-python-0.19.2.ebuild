# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/cf9b73f362dd39db4574251cd6882842cfc192cb -> aws-crt-python-0.19.2-cf9b73f.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/c75e00804da02fef8275b29509bd7180cb7e4667 -> aws-c-auth-0.7.4-c75e008.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/0a6beeb9fd223ac0712edb6a28f9978589b30bb8 -> aws-c-cal-0.6.2-0a6beeb.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/4c0a9f579d3064f086b42a2d39aaea721e7e71ca -> aws-c-common-0.9.4-4c0a9f5.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/99ec79ee2970f1a045d4ced1501b97ee521f2f85 -> aws-c-compression-0.2.17-99ec79e.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/08f24e384e5be20bcffa42b49213d24dad7881ae -> aws-c-event-stream-0.3.2-08f24e3.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/d777859b6da179b9098f87a2077fbf2129b574dc -> aws-c-http-0.7.13-d777859.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/c4b661f44497b18201b56ffd200cc478441f6434 -> aws-c-io-0.13.32-c4b661f.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/7c467e4f242920875cf68aed60deafc54bcb177e -> aws-c-mqtt-0.9.6-7c467e4.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/1fe34646f6bb2282491077b1d2407c724c0d5471 -> aws-c-s3-0.3.17-1fe3464.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/a6fd80cf7c163062d31abb28f309e47330fbfc17 -> aws-c-sdkutils-0.1.12-a6fd80c.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/321b805559c8e911be5bddba13fcbd222a3e2d3a -> aws-checksums-0.1.17-321b805.tar.gz
	https://github.com/awslabs/aws-lc/tarball/e42a4ef2270c4873e98101098edd1f0aaece966d -> aws-lc-1.16.0-e42a4ef.tar.gz
	https://github.com/aws/s2n-tls/tarball/4654fecb05cd5aacbda262654eb95a3876183698 -> s2n-tls-1.3.54-4654fec.tar.gz
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