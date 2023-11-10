# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

DESCRIPTION="A high-performance, open source, schema-free document-oriented database"
HOMEPAGE="https://www.mongodb.com"

EGO_SUM=(
	"github.com/3rf/mongo-lint v0.0.0-20140604191638-3550fdcf1f43"
	"github.com/3rf/mongo-lint v0.0.0-20140604191638-3550fdcf1f43/go.mod"
	"github.com/aws/aws-sdk-go v1.22.1/go.mod"
	"github.com/aws/aws-sdk-go v1.44.317"
	"github.com/aws/aws-sdk-go v1.44.317/go.mod"
	"github.com/cpuguy83/go-md2man/v2 v2.0.2"
	"github.com/cpuguy83/go-md2man/v2 v2.0.2/go.mod"
	"github.com/craiggwilson/goke v0.0.0-20220110201909-adb8bfb05d58"
	"github.com/craiggwilson/goke v0.0.0-20220110201909-adb8bfb05d58/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/golang/snappy v0.0.1/go.mod"
	"github.com/golang/snappy v0.0.4"
	"github.com/golang/snappy v0.0.4/go.mod"
	"github.com/google/go-cmp v0.5.2/go.mod"
	"github.com/google/go-cmp v0.5.9"
	"github.com/google/go-cmp v0.5.9/go.mod"
	"github.com/gopherjs/gopherjs v0.0.0-20181017120253-0766667cb4d1/go.mod"
	"github.com/gopherjs/gopherjs v1.17.2"
	"github.com/gopherjs/gopherjs v1.17.2/go.mod"
	"github.com/jessevdk/go-flags v1.5.0"
	"github.com/jessevdk/go-flags v1.5.0/go.mod"
	"github.com/jmespath/go-jmespath v0.0.0-20180206201540-c2b33e8439af/go.mod"
	"github.com/jmespath/go-jmespath v0.4.0"
	"github.com/jmespath/go-jmespath v0.4.0/go.mod"
	"github.com/jmespath/go-jmespath/internal/testify v1.5.1"
	"github.com/jmespath/go-jmespath/internal/testify v1.5.1/go.mod"
	"github.com/jtolds/gls v4.20.0+incompatible"
	"github.com/jtolds/gls v4.20.0+incompatible/go.mod"
	"github.com/klauspost/compress v1.13.6"
	"github.com/klauspost/compress v1.13.6/go.mod"
	"github.com/kr/pretty v0.1.0"
	"github.com/kr/pretty v0.1.0/go.mod"
	"github.com/kr/pty v1.1.1/go.mod"
	"github.com/kr/text v0.1.0"
	"github.com/kr/text v0.1.0/go.mod"
	"github.com/mattn/go-colorable v0.0.9/go.mod"
	"github.com/mattn/go-colorable v0.1.13"
	"github.com/mattn/go-colorable v0.1.13/go.mod"
	"github.com/mattn/go-isatty v0.0.4/go.mod"
	"github.com/mattn/go-isatty v0.0.16"
	"github.com/mattn/go-isatty v0.0.16/go.mod"
	"github.com/mattn/go-runewidth v0.0.9/go.mod"
	"github.com/mattn/go-runewidth v0.0.14"
	"github.com/mattn/go-runewidth v0.0.14/go.mod"
	"github.com/mgutz/ansi v0.0.0-20170206155736-9520e82c474b/go.mod"
	"github.com/mgutz/ansi v0.0.0-20200706080929-d51e80ef957d"
	"github.com/mgutz/ansi v0.0.0-20200706080929-d51e80ef957d/go.mod"
	"github.com/mitchellh/go-wordwrap v1.0.1"
	"github.com/mitchellh/go-wordwrap v1.0.1/go.mod"
	"github.com/montanaflynn/stats v0.0.0-20171201202039-1bf9dbcd8cbe/go.mod"
	"github.com/montanaflynn/stats v0.6.6"
	"github.com/montanaflynn/stats v0.6.6/go.mod"
	"github.com/nsf/termbox-go v1.1.1"
	"github.com/nsf/termbox-go v1.1.1/go.mod"
	"github.com/pkg/errors v0.9.1"
	"github.com/pkg/errors v0.9.1/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/rivo/uniseg v0.2.0"
	"github.com/rivo/uniseg v0.2.0/go.mod"
	"github.com/russross/blackfriday/v2 v2.1.0"
	"github.com/russross/blackfriday/v2 v2.1.0/go.mod"
	"github.com/smartystreets/assertions v0.0.0-20180927180507-b2de0cb4f26d"
	"github.com/smartystreets/assertions v0.0.0-20180927180507-b2de0cb4f26d/go.mod"
	"github.com/smartystreets/goconvey v1.6.4"
	"github.com/smartystreets/goconvey v1.6.4/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.4.0/go.mod"
	"github.com/stretchr/testify v1.6.1/go.mod"
	"github.com/stretchr/testify v1.8.4"
	"github.com/stretchr/testify v1.8.4/go.mod"
	"github.com/tidwall/pretty v1.0.0"
	"github.com/tidwall/pretty v1.0.0/go.mod"
	"github.com/urfave/cli/v2 v2.25.7"
	"github.com/urfave/cli/v2 v2.25.7/go.mod"
	"github.com/xdg-go/pbkdf2 v1.0.0"
	"github.com/xdg-go/pbkdf2 v1.0.0/go.mod"
	"github.com/xdg-go/scram v1.1.1"
	"github.com/xdg-go/scram v1.1.1/go.mod"
	"github.com/xdg-go/stringprep v1.0.3"
	"github.com/xdg-go/stringprep v1.0.3/go.mod"
	"github.com/xrash/smetrics v0.0.0-20201216005158-039620a65673"
	"github.com/xrash/smetrics v0.0.0-20201216005158-039620a65673/go.mod"
	"github.com/youmark/pkcs8 v0.0.0-20181117223130-1be2e3e5546d/go.mod"
	"github.com/youmark/pkcs8 v0.0.0-20201027041543-1326539a0a0a"
	"github.com/youmark/pkcs8 v0.0.0-20201027041543-1326539a0a0a/go.mod"
	"github.com/yuin/goldmark v1.4.13/go.mod"
	"go.mongodb.org/mongo-driver v1.10.3"
	"go.mongodb.org/mongo-driver v1.10.3/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20200302210943-78000ba7a073/go.mod"
	"golang.org/x/crypto v0.0.0-20210921155107-089bfa567519/go.mod"
	"golang.org/x/crypto v0.0.0-20220622213112-05595931fe9d/go.mod"
	"golang.org/x/crypto v0.14.0"
	"golang.org/x/crypto v0.14.0/go.mod"
	"golang.org/x/exp v0.0.0-20230321023759-10a507213a29"
	"golang.org/x/exp v0.0.0-20230321023759-10a507213a29/go.mod"
	"golang.org/x/mod v0.6.0-dev.0.20220419223038-86c51ed26bb4/go.mod"
	"golang.org/x/mod v0.12.0"
	"golang.org/x/mod v0.12.0/go.mod"
	"golang.org/x/net v0.0.0-20190311183353-d8887717615a/go.mod"
	"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
	"golang.org/x/net v0.0.0-20190620200207-3b0461eec859/go.mod"
	"golang.org/x/net v0.0.0-20190724013045-ca1201d0de80/go.mod"
	"golang.org/x/net v0.0.0-20210226172049-e18ecbb05110/go.mod"
	"golang.org/x/net v0.0.0-20211112202133-69e39bad7dc2/go.mod"
	"golang.org/x/net v0.0.0-20220722155237-a158d28d115b/go.mod"
	"golang.org/x/net v0.1.0/go.mod"
	"golang.org/x/net v0.17.0"
	"golang.org/x/net v0.17.0/go.mod"
	"golang.org/x/sync v0.0.0-20190423024810-112230192c58/go.mod"
	"golang.org/x/sync v0.0.0-20210220032951-036812b2e83c/go.mod"
	"golang.org/x/sync v0.0.0-20220722155255-886fb9371eb4/go.mod"
	"golang.org/x/sync v0.1.0"
	"golang.org/x/sync v0.1.0/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod"
	"golang.org/x/sys v0.0.0-20190804053845-51ab0e2deafa/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/sys v0.0.0-20210320140829-1e4c9ba3b0c4/go.mod"
	"golang.org/x/sys v0.0.0-20210423082822-04245dca01da/go.mod"
	"golang.org/x/sys v0.0.0-20210615035016-665e8c7367d1/go.mod"
	"golang.org/x/sys v0.0.0-20220520151302-bc2c85ada10a/go.mod"
	"golang.org/x/sys v0.0.0-20220722155257-8c9f86f7a55f/go.mod"
	"golang.org/x/sys v0.0.0-20220811171246-fbc7d0a398ab/go.mod"
	"golang.org/x/sys v0.1.0/go.mod"
	"golang.org/x/sys v0.13.0"
	"golang.org/x/sys v0.13.0/go.mod"
	"golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1/go.mod"
	"golang.org/x/term v0.0.0-20210927222741-03fcf44c2211/go.mod"
	"golang.org/x/term v0.1.0/go.mod"
	"golang.org/x/term v0.13.0"
	"golang.org/x/term v0.13.0/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.3/go.mod"
	"golang.org/x/text v0.3.6/go.mod"
	"golang.org/x/text v0.3.7/go.mod"
	"golang.org/x/text v0.4.0/go.mod"
	"golang.org/x/text v0.13.0"
	"golang.org/x/text v0.13.0/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"golang.org/x/tools v0.0.0-20190328211700-ab21143f2384/go.mod"
	"golang.org/x/tools v0.0.0-20191119224855-298f0cb1881e/go.mod"
	"golang.org/x/tools v0.1.12/go.mod"
	"golang.org/x/xerrors v0.0.0-20190717185122-a985d3407aa7/go.mod"
	"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/check.v1 v1.0.0-20180628173108-788fd7840127"
	"gopkg.in/check.v1 v1.0.0-20180628173108-788fd7840127/go.mod"
	"gopkg.in/tomb.v2 v2.0.0-20161208151619-d5d1b5820637"
	"gopkg.in/tomb.v2 v2.0.0-20161208151619-d5d1b5820637/go.mod"
	"gopkg.in/yaml.v2 v2.2.2/go.mod"
	"gopkg.in/yaml.v2 v2.2.8/go.mod"
	"gopkg.in/yaml.v2 v2.4.0"
	"gopkg.in/yaml.v2 v2.4.0/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
)

go-module_set_globals

SRC_URI="https://github.com/mongodb/mongo-tools/archive/c1f27fa35d2a8574d2e6b77bca5623e6046e2e46.tar.gz -> mongo-tools-100.9.1-c1f27fa3.tar.gz
https://direct.funtoo.org/6a/8c/e1/6a8ce163747c743ebc24ca1127e91e251ea642cc65db45e70f278d937e956bbba75caa0aef802ce3920d38f52a568784d1dc949f58da149314b455ddc1b068b4 -> mongo-tools-100.9.1-funtoo-go-bundle-cb3d7de3b2e6d1ab467a413e54921983d524dfc9a4a2bbe69b456997ff75e2c9d632196860e5462b2a61f3f3400f93c20dcf889ed08b853d8aa4b6e987db2a36.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="sasl ssl"
S="${WORKDIR}/mongo-tools-c1f27fa35d2a8574d2e6b77bca5623e6046e2e46"

RDEPEND="
	net-libs/libpcap
	sasl? ( dev-libs/cyrus-sasl )
	ssl? ( dev-libs/openssl:0= )
"

src_compile() {
	local myconf=()

	if use sasl; then
		myconf+=(sasl)
	fi

	if use ssl; then
		myconf+=(ssl)
	fi

	for bin_path in */main; do
		bin_name=$(dirname ${bin_path})

		go build -mod=mod \
			-o bin/"${bin_name}" \
			-ldflags "-X main.VersionStr=${PV} -X main.GitCommit=c1f27fa35d2a8574d2e6b77bca5623e6046e2e46" \
			-buildmode=pie \
			--tags "${myconf[*]}" \
			./"${bin_path}" || die "compile failed"
	done
}

src_install() {
	dobin bin/*
}