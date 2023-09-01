# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/74e0538f02d2becb45f948d869f2ffb8c116c3c7 -> aws-crt-python-0.19.1-74e0538.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/df370cabd6bdfee7ce7d550daca19b6d14eb54b4 -> aws-c-auth-0.7.3-df370ca.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/0a6beeb9fd223ac0712edb6a28f9978589b30bb8 -> aws-c-cal-0.6.2-0a6beeb.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/997380c904671f88086847e8dc839bceab3d7821 -> aws-c-common-0.9.3-997380c.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/99ec79ee2970f1a045d4ced1501b97ee521f2f85 -> aws-c-compression-0.2.17-99ec79e.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/08f24e384e5be20bcffa42b49213d24dad7881ae -> aws-c-event-stream-0.3.2-08f24e3.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/2112636b7464c2f6c3d09f6736e6c42aa29e6e02 -> aws-c-http-0.7.12-2112636.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/c4b661f44497b18201b56ffd200cc478441f6434 -> aws-c-io-0.13.32-c4b661f.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/9fc57a13bce0fbcc50d1fdb4cc52c9107d4c7dc9 -> aws-c-mqtt-0.9.5-9fc57a1.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/a0ee6a9ec81f1eff92c9880bd18824bfd3efccc3 -> aws-c-s3-0.3.16-a0ee6a9.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/a6fd80cf7c163062d31abb28f309e47330fbfc17 -> aws-c-sdkutils-0.1.12-a6fd80c.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/321b805559c8e911be5bddba13fcbd222a3e2d3a -> aws-checksums-0.1.17-321b805.tar.gz
	https://github.com/awslabs/aws-lc/tarball/aa90e509f2e940916fbe9fdd469a4c90c51824f6 -> aws-lc-1.15.0-aa90e50.tar.gz
	https://github.com/aws/s2n-tls/tarball/baf094768e90d10a1f72182a1b04160e31d54c13 -> s2n-tls-1.3.50-baf0947.tar.gz
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