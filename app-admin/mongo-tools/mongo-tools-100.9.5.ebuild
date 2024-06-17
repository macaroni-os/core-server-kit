# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

DESCRIPTION="A high-performance, open source, schema-free document-oriented database"
HOMEPAGE="https://www.mongodb.com"

EGO_SUM=(
	"github.com/3rf/mongo-lint v0.0.0-20140604191638-3550fdcf1f43"
	"github.com/3rf/mongo-lint v0.0.0-20140604191638-3550fdcf1f43/go.mod"
	"github.com/aws/aws-sdk-go v1.44.114/go.mod"
	"github.com/aws/aws-sdk-go v1.53.11"
	"github.com/aws/aws-sdk-go v1.53.11/go.mod"
	"github.com/cpuguy83/go-md2man/v2 v2.0.4"
	"github.com/cpuguy83/go-md2man/v2 v2.0.4/go.mod"
	"github.com/craiggwilson/goke v0.0.0-20240206162536-b1c58122d943"
	"github.com/craiggwilson/goke v0.0.0-20240206162536-b1c58122d943/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/golang/snappy v0.0.1/go.mod"
	"github.com/golang/snappy v0.0.4"
	"github.com/golang/snappy v0.0.4/go.mod"
	"github.com/google/go-cmp v0.5.2/go.mod"
	"github.com/google/go-cmp v0.6.0"
	"github.com/google/go-cmp v0.6.0/go.mod"
	"github.com/gopherjs/gopherjs v1.17.2"
	"github.com/gopherjs/gopherjs v1.17.2/go.mod"
	"github.com/jessevdk/go-flags v1.5.0"
	"github.com/jessevdk/go-flags v1.5.0/go.mod"
	"github.com/jmespath/go-jmespath v0.4.0"
	"github.com/jmespath/go-jmespath v0.4.0/go.mod"
	"github.com/jmespath/go-jmespath/internal/testify v1.5.1"
	"github.com/jmespath/go-jmespath/internal/testify v1.5.1/go.mod"
	"github.com/jtolds/gls v4.20.0+incompatible"
	"github.com/jtolds/gls v4.20.0+incompatible/go.mod"
	"github.com/klauspost/compress v1.13.6/go.mod"
	"github.com/klauspost/compress v1.17.8"
	"github.com/klauspost/compress v1.17.8/go.mod"
	"github.com/kr/pretty v0.1.0"
	"github.com/kr/pretty v0.1.0/go.mod"
	"github.com/kr/pty v1.1.1/go.mod"
	"github.com/kr/text v0.1.0"
	"github.com/kr/text v0.1.0/go.mod"
	"github.com/mattn/go-colorable v0.0.9/go.mod"
	"github.com/mattn/go-colorable v0.1.13"
	"github.com/mattn/go-colorable v0.1.13/go.mod"
	"github.com/mattn/go-isatty v0.0.4/go.mod"
	"github.com/mattn/go-isatty v0.0.16/go.mod"
	"github.com/mattn/go-isatty v0.0.20"
	"github.com/mattn/go-isatty v0.0.20/go.mod"
	"github.com/mattn/go-runewidth v0.0.9/go.mod"
	"github.com/mattn/go-runewidth v0.0.15"
	"github.com/mattn/go-runewidth v0.0.15/go.mod"
	"github.com/mgutz/ansi v0.0.0-20170206155736-9520e82c474b/go.mod"
	"github.com/mgutz/ansi v0.0.0-20200706080929-d51e80ef957d"
	"github.com/mgutz/ansi v0.0.0-20200706080929-d51e80ef957d/go.mod"
	"github.com/mitchellh/go-wordwrap v1.0.1"
	"github.com/mitchellh/go-wordwrap v1.0.1/go.mod"
	"github.com/montanaflynn/stats v0.0.0-20171201202039-1bf9dbcd8cbe/go.mod"
	"github.com/montanaflynn/stats v0.7.1"
	"github.com/montanaflynn/stats v0.7.1/go.mod"
	"github.com/nsf/termbox-go v1.1.1"
	"github.com/nsf/termbox-go v1.1.1/go.mod"
	"github.com/pkg/errors v0.9.1"
	"github.com/pkg/errors v0.9.1/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/rivo/uniseg v0.2.0/go.mod"
	"github.com/rivo/uniseg v0.4.7"
	"github.com/rivo/uniseg v0.4.7/go.mod"
	"github.com/russross/blackfriday/v2 v2.1.0"
	"github.com/russross/blackfriday/v2 v2.1.0/go.mod"
	"github.com/smarty/assertions v1.15.0"
	"github.com/smarty/assertions v1.15.0/go.mod"
	"github.com/smartystreets/goconvey v1.8.1"
	"github.com/smartystreets/goconvey v1.8.1/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.6.1/go.mod"
	"github.com/stretchr/testify v1.9.0"
	"github.com/stretchr/testify v1.9.0/go.mod"
	"github.com/tidwall/pretty v1.0.0"
	"github.com/tidwall/pretty v1.0.0/go.mod"
	"github.com/urfave/cli/v2 v2.27.2"
	"github.com/urfave/cli/v2 v2.27.2/go.mod"
	"github.com/xdg-go/pbkdf2 v1.0.0"
	"github.com/xdg-go/pbkdf2 v1.0.0/go.mod"
	"github.com/xdg-go/scram v1.1.1/go.mod"
	"github.com/xdg-go/scram v1.1.2"
	"github.com/xdg-go/scram v1.1.2/go.mod"
	"github.com/xdg-go/stringprep v1.0.3/go.mod"
	"github.com/xdg-go/stringprep v1.0.4"
	"github.com/xdg-go/stringprep v1.0.4/go.mod"
	"github.com/xrash/smetrics v0.0.0-20240521201337-686a1a2994c1"
	"github.com/xrash/smetrics v0.0.0-20240521201337-686a1a2994c1/go.mod"
	"github.com/youmark/pkcs8 v0.0.0-20181117223130-1be2e3e5546d/go.mod"
	"github.com/youmark/pkcs8 v0.0.0-20201027041543-1326539a0a0a"
	"github.com/youmark/pkcs8 v0.0.0-20201027041543-1326539a0a0a/go.mod"
	"github.com/yuin/goldmark v1.4.13/go.mod"
	"go.mongodb.org/mongo-driver v1.11.9"
	"go.mongodb.org/mongo-driver v1.11.9/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20200302210943-78000ba7a073/go.mod"
	"golang.org/x/crypto v0.0.0-20210921155107-089bfa567519/go.mod"
	"golang.org/x/crypto v0.0.0-20220622213112-05595931fe9d/go.mod"
	"golang.org/x/crypto v0.23.0"
	"golang.org/x/crypto v0.23.0/go.mod"
	"golang.org/x/exp v0.0.0-20240529005216-23cca8864a10"
	"golang.org/x/exp v0.0.0-20240529005216-23cca8864a10/go.mod"
	"golang.org/x/mod v0.6.0-dev.0.20220419223038-86c51ed26bb4/go.mod"
	"golang.org/x/mod v0.17.0"
	"golang.org/x/mod v0.17.0/go.mod"
	"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
	"golang.org/x/net v0.0.0-20190620200207-3b0461eec859/go.mod"
	"golang.org/x/net v0.0.0-20210226172049-e18ecbb05110/go.mod"
	"golang.org/x/net v0.0.0-20211112202133-69e39bad7dc2/go.mod"
	"golang.org/x/net v0.0.0-20220127200216-cd36cc0744dd/go.mod"
	"golang.org/x/net v0.0.0-20220722155237-a158d28d115b/go.mod"
	"golang.org/x/net v0.25.0"
	"golang.org/x/net v0.25.0/go.mod"
	"golang.org/x/sync v0.0.0-20190423024810-112230192c58/go.mod"
	"golang.org/x/sync v0.0.0-20210220032951-036812b2e83c/go.mod"
	"golang.org/x/sync v0.0.0-20220722155255-886fb9371eb4/go.mod"
	"golang.org/x/sync v0.7.0"
	"golang.org/x/sync v0.7.0/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/sys v0.0.0-20210320140829-1e4c9ba3b0c4/go.mod"
	"golang.org/x/sys v0.0.0-20210423082822-04245dca01da/go.mod"
	"golang.org/x/sys v0.0.0-20210615035016-665e8c7367d1/go.mod"
	"golang.org/x/sys v0.0.0-20211216021012-1d35b9e2eb4e/go.mod"
	"golang.org/x/sys v0.0.0-20220520151302-bc2c85ada10a/go.mod"
	"golang.org/x/sys v0.0.0-20220722155257-8c9f86f7a55f/go.mod"
	"golang.org/x/sys v0.0.0-20220811171246-fbc7d0a398ab/go.mod"
	"golang.org/x/sys v0.6.0/go.mod"
	"golang.org/x/sys v0.20.0"
	"golang.org/x/sys v0.20.0/go.mod"
	"golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1/go.mod"
	"golang.org/x/term v0.0.0-20210927222741-03fcf44c2211/go.mod"
	"golang.org/x/term v0.20.0"
	"golang.org/x/term v0.20.0/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.3/go.mod"
	"golang.org/x/text v0.3.6/go.mod"
	"golang.org/x/text v0.3.7/go.mod"
	"golang.org/x/text v0.3.8/go.mod"
	"golang.org/x/text v0.15.0"
	"golang.org/x/text v0.15.0/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"golang.org/x/tools v0.0.0-20191119224855-298f0cb1881e/go.mod"
	"golang.org/x/tools v0.1.12/go.mod"
	"golang.org/x/xerrors v0.0.0-20190717185122-a985d3407aa7/go.mod"
	"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/check.v1 v1.0.0-20180628173108-788fd7840127"
	"gopkg.in/check.v1 v1.0.0-20180628173108-788fd7840127/go.mod"
	"gopkg.in/tomb.v2 v2.0.0-20161208151619-d5d1b5820637"
	"gopkg.in/tomb.v2 v2.0.0-20161208151619-d5d1b5820637/go.mod"
	"gopkg.in/yaml.v2 v2.2.8/go.mod"
	"gopkg.in/yaml.v2 v2.4.0"
	"gopkg.in/yaml.v2 v2.4.0/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
)

go-module_set_globals

SRC_URI="https://github.com/mongodb/mongo-tools/tarball/90481484c1783826fe26ca18bbdcd30e933f3b88 -> mongo-tools-100.9.5-9048148.tar.gz
https://direct.funtoo.org/11/e0/6f/11e06f44be2768a681512cf8239dc5e0284ad3bf3e550a0534e6967a71cb1c8cac8097c7c7ee1f6d5fa7acf0a705d1c62c5dab12f06dc79548ec50930eadb4c6 -> mongo-tools-100.9.5-funtoo-go-bundle-59709876335349a9119f5037cdd3f90c3bf451ce465496997954ac42b6a692317f75fca17969a691234678578fd23bd6c0ebf85226cbd782ac4489fca480a60b.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="sasl ssl"
S="${WORKDIR}/mongodb-mongo-tools-9048148"

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
			-ldflags "-X main.VersionStr=${PV} -X main.GitCommit=" \
			-buildmode=pie \
			--tags "${myconf[*]}" \
			./"${bin_path}" || die "compile failed"
	done
}

src_install() {
	dobin bin/*
}