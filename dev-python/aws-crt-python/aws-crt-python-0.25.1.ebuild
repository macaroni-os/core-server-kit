# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/68b2c082186c6f0bbca2b6dcb392502944efcc61 -> aws-crt-python-0.25.1-68b2c08.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/e0bd58d172cdc78d62eff5728437790d06fcce50 -> aws-c-auth-0.8.7-e0bd58d.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/d59c198db17c42a48e3ee105d12357f5a9efecf3 -> aws-c-cal-0.8.7-d59c198.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/d80b00560f0ebb441538b3ab40192a242afeaa80 -> aws-c-common-0.12.1-d80b005.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/f951ab2b819fc6993b6e5e6cfef64b1a1554bfc8 -> aws-c-compression-0.3.1-f951ab2.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/9312b052583183b98526aaeb91e5c72ec3db9627 -> aws-c-event-stream-0.5.4-9312b05.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/e3a9cabc664630120df25c28ec710199b8e8b15b -> aws-c-http-0.9.5-e3a9cab.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/318f7e57e7871e5b0d48a281cc5dcb7f79ccecdd -> aws-c-io-0.17.0-318f7e5.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/f0cc34cb6f54e050275e3c859594c62776d46d83 -> aws-c-mqtt-0.12.2-f0cc34c.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/169842b7e2f81d71d0719d4a77f9c3e186512f99 -> aws-c-s3-0.7.13-169842b.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/ba6a28fab7ed5d7f1b3b1d12eb672088be093824 -> aws-c-sdkutils-0.2.3-ba6a28f.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/fb8bd0b8cff00c8c24a35d601fce1b4c611df6da -> aws-checksums-0.2.3-fb8bd0b.tar.gz
	https://github.com/awslabs/aws-lc/tarball/8a9ebcfdcf8bb4a685ca83646265ea0aab85c3c8 -> aws-lc-1.48.5-8a9ebcf.tar.gz
	https://github.com/aws/s2n-tls/tarball/4ed4f1a658b70559ec4a18e91d1319daa14b0610 -> s2n-tls-1.5.14-4ed4f1a.tar.gz
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