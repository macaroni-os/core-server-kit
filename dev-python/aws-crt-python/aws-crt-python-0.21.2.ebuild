# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/436d58ca1db672a0c8997d5a135ee18b266d1d5e -> aws-crt-python-0.21.2-436d58c.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/52bf591613d1a001c43ec99af7376f871759c5fe -> aws-c-auth-0.7.25-52bf591.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/77ca3aea879bc768082fe7ec715adcde8e98c332 -> aws-c-cal-0.7.3-77ca3ae.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/672cc0032eb28d69fbdd22c9463253c89d7a6f30 -> aws-c-common-0.9.27-672cc00.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/ea1d421a421ad83a540309a94c38d50b6a5d836b -> aws-c-compression-0.2.18-ea1d421.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/1b3825fc9cae2e9c7ed7479ee5d354d52ebdf7a0 -> aws-c-event-stream-0.4.3-1b3825f.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/4e74ab1e3702763e0b87bd1752f5a37c2f0400ac -> aws-c-http-0.8.8-4e74ab1.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/c345d77274db83c0c2e30331814093e7c84c45e2 -> aws-c-io-0.14.18-c345d77.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/ed7bbd68c03d7022c915a2924740ab7992ad2311 -> aws-c-mqtt-0.10.4-ed7bbd6.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/0ab4d58ef0bd97970d43828cb6b57a3de5747343 -> aws-c-s3-0.6.4-0ab4d58.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/4658412a61ad5749db92a8d1e0717cb5e76ada1c -> aws-c-sdkutils-0.1.19-4658412.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/aac442a2dbbb5e72d0a3eca8313cf65e7e1cac2f -> aws-checksums-0.1.18-aac442a.tar.gz
	https://github.com/awslabs/aws-lc/tarball/05747780676652f41d0b9c570a495e4bb6608560 -> aws-lc-1.33.0-0574778.tar.gz
	https://github.com/aws/s2n-tls/tarball/79c0f1b434742d9f1152c48d3781433649f6f8fe -> s2n-tls-1.5.0-79c0f1b.tar.gz
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