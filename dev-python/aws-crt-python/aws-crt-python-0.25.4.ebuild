# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/f6316435d745943e699ab94f563fb4bba0df2687 -> aws-crt-python-0.25.4-f631643.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/cd9d6afcd42035d49bb2d0d3bef24b9faed57773 -> aws-c-auth-0.9.0-cd9d6af.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/4805a96e694b07c89889de696418c429151f647a -> aws-c-cal-0.8.8-4805a96.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/8ae8f48ebddb0ee2624d643952ac33afa5e8859e -> aws-c-common-0.12.2-8ae8f48.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/f951ab2b819fc6993b6e5e6cfef64b1a1554bfc8 -> aws-c-compression-0.3.1-f951ab2.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/9312b052583183b98526aaeb91e5c72ec3db9627 -> aws-c-event-stream-0.5.4-9312b05.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/e3a9cabc664630120df25c28ec710199b8e8b15b -> aws-c-http-0.9.5-e3a9cab.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/318f7e57e7871e5b0d48a281cc5dcb7f79ccecdd -> aws-c-io-0.17.0-318f7e5.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/f0cc34cb6f54e050275e3c859594c62776d46d83 -> aws-c-mqtt-0.12.2-f0cc34c.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/169842b7e2f81d71d0719d4a77f9c3e186512f99 -> aws-c-s3-0.7.13-169842b.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/ba6a28fab7ed5d7f1b3b1d12eb672088be093824 -> aws-c-sdkutils-0.2.3-ba6a28f.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/32e69ae689783d2a6055c63ad467534c23c54b1a -> aws-checksums-0.2.4-32e69ae.tar.gz
	https://github.com/awslabs/aws-lc/tarball/8a9ebcfdcf8bb4a685ca83646265ea0aab85c3c8 -> aws-lc-1.48.5-8a9ebcf.tar.gz
	https://github.com/aws/s2n-tls/tarball/bb9c5991877c6a749981204131e6e47845adbe3d -> s2n-tls-1.5.15-bb9c599.tar.gz
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