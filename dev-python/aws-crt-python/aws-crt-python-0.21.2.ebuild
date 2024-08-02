# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/436d58ca1db672a0c8997d5a135ee18b266d1d5e -> aws-crt-python-0.21.2-436d58c.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/d7895252915259d037f10be223369eb99e837471 -> aws-c-auth-0.7.24-d789525.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/bc0d71b66deea9e1a2d3a073c9f1ece9286b9e60 -> aws-c-cal-0.7.2-bc0d71b.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/67601bbbce6ea1c26191f235afc50007a4e796c5 -> aws-c-common-0.9.24-67601bb.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/ea1d421a421ad83a540309a94c38d50b6a5d836b -> aws-c-compression-0.2.18-ea1d421.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/1a70c50f78a6e706f1f91a4ed138478271b6d9d3 -> aws-c-event-stream-0.4.2-1a70c50.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/a2fb16c431152bd677093f9910f405a37533ad5a -> aws-c-http-0.8.5-a2fb16c.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/e5fe40e11d97221c25b3b40ad2949822b3422993 -> aws-c-io-0.14.16-e5fe40e.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/ed7bbd68c03d7022c915a2924740ab7992ad2311 -> aws-c-mqtt-0.10.4-ed7bbd6.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/0ab4d58ef0bd97970d43828cb6b57a3de5747343 -> aws-c-s3-0.6.4-0ab4d58.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/ac3ac9d384fb563d0fccff14e5223469b650487c -> aws-c-sdkutils-0.1.17-ac3ac9d.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/aac442a2dbbb5e72d0a3eca8313cf65e7e1cac2f -> aws-checksums-0.1.18-aac442a.tar.gz
	https://github.com/awslabs/aws-lc/tarball/05747780676652f41d0b9c570a495e4bb6608560 -> aws-lc-1.33.0-0574778.tar.gz
	https://github.com/aws/s2n-tls/tarball/138e3ece9e457c2f824a85b63095737f30d624a9 -> s2n-tls-1.4.18-138e3ec.tar.gz
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