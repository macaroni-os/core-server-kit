# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/f2f9b6cdefafe205dd96529f062b647fb0a2173b -> aws-crt-python-0.23.8-f2f9b6c.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/b513db4bf82429a1134fecbd6d12e5fda45255a6 -> aws-c-auth-0.8.4-b513db4.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/7299c6ab9244595b140d604475cdd6c6921be8ae -> aws-c-cal-0.8.3-7299c6a.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/0e7637fa852a472bd4c37fc07a325a09c942a5fc -> aws-c-common-0.11.0-0e7637f.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/f951ab2b819fc6993b6e5e6cfef64b1a1554bfc8 -> aws-c-compression-0.3.1-f951ab2.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/9422ef78aac566414d1bebb1a5431a4c53a7547c -> aws-c-event-stream-0.5.1-9422ef7.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/590c7b597f87e5edc080b8b77418690c30319832 -> aws-c-http-0.9.3-590c7b5.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/3041dabfc13fe9bc9a0467e15aa1d5a09c7fc06f -> aws-c-io-0.15.4-3041dab.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/83247bde8268905018327891fcf0147f3e438a80 -> aws-c-mqtt-0.12.1-83247bd.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/6eb8be530b100fed5c6d24ca48a57ee2e6098fbf -> aws-c-s3-0.7.11-6eb8be5.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/ba6a28fab7ed5d7f1b3b1d12eb672088be093824 -> aws-c-sdkutils-0.2.3-ba6a28f.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/fb8bd0b8cff00c8c24a35d601fce1b4c611df6da -> aws-checksums-0.2.3-fb8bd0b.tar.gz
	https://github.com/awslabs/aws-lc/tarball/ffd6fb71b1e1582a620149337b77706f2391578d -> aws-lc-1.43.0-ffd6fb7.tar.gz
	https://github.com/aws/s2n-tls/tarball/6cc9f53d7ab5f0427ae5f838891fff57844a9e3f -> s2n-tls-1.5.11-6cc9f53.tar.gz
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