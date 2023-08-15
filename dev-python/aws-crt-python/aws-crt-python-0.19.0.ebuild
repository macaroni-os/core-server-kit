# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/4ba26faa0d72ad4b56891e6fa6d8821a589cee18 -> aws-crt-python-0.19.0-4ba26fa.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/df370cabd6bdfee7ce7d550daca19b6d14eb54b4 -> aws-c-auth-0.7.3-df370ca.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/29578cdcb3c046efc6680f6baea572dec9bdbc2e -> aws-c-cal-0.6.1-29578cd.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/5c736d5c39a7e7ce8b5feb88d051084b41a8c7ea -> aws-c-common-0.9.0-5c736d5.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/99ec79ee2970f1a045d4ced1501b97ee521f2f85 -> aws-c-compression-0.2.17-99ec79e.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/ec1716c726babd1381560aa8d28941fffc987394 -> aws-c-event-stream-0.3.1-ec1716c.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/f800427e2e2878cf8b36f602583758769a7b3b4a -> aws-c-http-0.7.11-f800427.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/c4b661f44497b18201b56ffd200cc478441f6434 -> aws-c-io-0.13.32-c4b661f.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/a2ee9a321fcafa19b0473b88a54e0ae8dde5fddf -> aws-c-mqtt-0.9.3-a2ee9a3.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/231188147a8c08c9ed709100a2380be42bad6350 -> aws-c-s3-0.3.14-2311881.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/a6fd80cf7c163062d31abb28f309e47330fbfc17 -> aws-c-sdkutils-0.1.12-a6fd80c.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/321b805559c8e911be5bddba13fcbd222a3e2d3a -> aws-checksums-0.1.17-321b805.tar.gz
	https://github.com/awslabs/aws-lc/tarball/9b323d575d6ad4771592e77083169416275b793d -> aws-lc-1.14.0-9b323d5.tar.gz
	https://github.com/aws/s2n-tls/tarball/cb32a54dd95e38088b3873d4cc9b05bc4e8d77e3 -> s2n-tls-1.3.49-cb32a54.tar.gz
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