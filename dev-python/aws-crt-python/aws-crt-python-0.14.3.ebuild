# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/0478b99a3a1352a258b095400adfbf0fa9fba5a5 -> aws-crt-python-0.14.3-0478b99.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/b7923aed571eac5c880c1becc3a323f50722c592 -> aws-c-auth-0.6.16-b7923ae.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/cc43764ddef1c23c6c5ae16badecbc989e4e45c8 -> aws-c-cal-0.5.19-cc43764.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/bd417541440e2660bbf9ba33565a24abaefe7a9a -> aws-c-common-0.8.1-bd41754.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/63e1ada3d1c1b2d337e9edc5ea977b1f17450ded -> aws-c-compression-0.2.15-63e1ada.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/381e4806042e067e808f80fe409ae5121084b467 -> aws-c-event-stream-0.2.14-381e480.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/f81ee942fa9b149711d90b4a3f3af5c946151d16 -> aws-c-http-0.6.20-f81ee94.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/b76fd20c413cfff1ec088a89cccac73960ab1158 -> aws-c-io-0.13.3-b76fd20.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/cea176e7f3ec32d1465788e95ae9c652014aa135 -> aws-c-mqtt-0.7.12-cea176e.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/c1198aeda7bf4ae685f2e1fdb778f10239799774 -> aws-c-s3-0.1.46-c1198ae.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/2d9ef421f88ab9599f1a128fd4567c2ada64a6b8 -> aws-c-sdkutils-0.1.3-2d9ef42.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/48e7c0e01479232f225c8044d76c84e74192889d -> aws-checksums-0.1.13-48e7c0e.tar.gz
	https://github.com/awslabs/aws-lc/tarball/e7413d237bb60bf639e78aa43ff3c1b1783f0712 -> aws-lc-1.1.0-e7413d2.tar.gz
	https://github.com/aws/s2n-tls/tarball/12c98cd529b3bb8c779b5a45846aec6f452b9ed4 -> s2n-tls-1.3.20-12c98cd.tar.gz
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