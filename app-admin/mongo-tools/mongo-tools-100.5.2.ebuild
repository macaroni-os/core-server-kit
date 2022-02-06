# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

DESCRIPTION="A high-performance, open source, schema-free document-oriented database"
HOMEPAGE="https://www.mongodb.com"

EGO_SUM=(
	"github.com/3rf/mongo-lint v0.0.0-20140604191638-3550fdcf1f43"
	"github.com/3rf/mongo-lint v0.0.0-20140604191638-3550fdcf1f43/go.mod"
	"github.com/!burnt!sushi/toml v0.3.1/go.mod"
	"github.com/aws/aws-sdk-go v1.22.1/go.mod"
	"github.com/aws/aws-sdk-go v1.34.28"
	"github.com/aws/aws-sdk-go v1.34.28/go.mod"
	"github.com/craiggwilson/goke v0.0.0-20200309222237-69a77cdfe646"
	"github.com/craiggwilson/goke v0.0.0-20200309222237-69a77cdfe646/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/go-sql-driver/mysql v1.5.0/go.mod"
	"github.com/go-stack/stack v1.8.0"
	"github.com/go-stack/stack v1.8.0/go.mod"
	"github.com/gobuffalo/attrs v0.0.0-20190224210810-a9411de4debd/go.mod"
	"github.com/gobuffalo/depgen v0.0.0-20190329151759-d478694a28d3/go.mod"
	"github.com/gobuffalo/depgen v0.1.0/go.mod"
	"github.com/gobuffalo/envy v1.6.15/go.mod"
	"github.com/gobuffalo/envy v1.7.0/go.mod"
	"github.com/gobuffalo/flect v0.1.0/go.mod"
	"github.com/gobuffalo/flect v0.1.1/go.mod"
	"github.com/gobuffalo/flect v0.1.3/go.mod"
	"github.com/gobuffalo/genny v0.0.0-20190329151137-27723ad26ef9/go.mod"
	"github.com/gobuffalo/genny v0.0.0-20190403191548-3ca520ef0d9e/go.mod"
	"github.com/gobuffalo/genny v0.1.0/go.mod"
	"github.com/gobuffalo/genny v0.1.1/go.mod"
	"github.com/gobuffalo/gitgen v0.0.0-20190315122116-cc086187d211/go.mod"
	"github.com/gobuffalo/gogen v0.0.0-20190315121717-8f38393713f5/go.mod"
	"github.com/gobuffalo/gogen v0.1.0/go.mod"
	"github.com/gobuffalo/gogen v0.1.1/go.mod"
	"github.com/gobuffalo/logger v0.0.0-20190315122211-86e12af44bc2/go.mod"
	"github.com/gobuffalo/mapi v1.0.1/go.mod"
	"github.com/gobuffalo/mapi v1.0.2/go.mod"
	"github.com/gobuffalo/packd v0.0.0-20190315124812-a385830c7fc0/go.mod"
	"github.com/gobuffalo/packd v0.1.0/go.mod"
	"github.com/gobuffalo/packr/v2 v2.0.9/go.mod"
	"github.com/gobuffalo/packr/v2 v2.2.0/go.mod"
	"github.com/gobuffalo/syncx v0.0.0-20190224160051-33c29581e754/go.mod"
	"github.com/golang/snappy v0.0.1"
	"github.com/golang/snappy v0.0.1/go.mod"
	"github.com/google/go-cmp v0.5.2"
	"github.com/google/go-cmp v0.5.2/go.mod"
	"github.com/gopherjs/gopherjs v0.0.0-20181017120253-0766667cb4d1/go.mod"
	"github.com/gopherjs/gopherjs v0.0.0-20190430165422-3e4dfb77656c"
	"github.com/gopherjs/gopherjs v0.0.0-20190430165422-3e4dfb77656c/go.mod"
	"github.com/inconshreveable/mousetrap v1.0.0/go.mod"
	"github.com/jessevdk/go-flags v1.4.0"
	"github.com/jessevdk/go-flags v1.4.0/go.mod"
	"github.com/jmespath/go-jmespath v0.0.0-20180206201540-c2b33e8439af/go.mod"
	"github.com/jmespath/go-jmespath v0.4.0"
	"github.com/jmespath/go-jmespath v0.4.0/go.mod"
	"github.com/jmespath/go-jmespath/internal/testify v1.5.1"
	"github.com/jmespath/go-jmespath/internal/testify v1.5.1/go.mod"
	"github.com/joho/godotenv v1.3.0/go.mod"
	"github.com/jtolds/gls v4.20.0+incompatible"
	"github.com/jtolds/gls v4.20.0+incompatible/go.mod"
	"github.com/karrick/godirwalk v1.8.0/go.mod"
	"github.com/karrick/godirwalk v1.10.3/go.mod"
	"github.com/klauspost/compress v1.9.5/go.mod"
	"github.com/klauspost/compress v1.10.1"
	"github.com/klauspost/compress v1.10.1/go.mod"
	"github.com/konsorten/go-windows-terminal-sequences v1.0.1/go.mod"
	"github.com/konsorten/go-windows-terminal-sequences v1.0.2/go.mod"
	"github.com/kr/pretty v0.1.0"
	"github.com/kr/pretty v0.1.0/go.mod"
	"github.com/kr/pty v1.1.1/go.mod"
	"github.com/kr/text v0.1.0"
	"github.com/kr/text v0.1.0/go.mod"
	"github.com/markbates/oncer v0.0.0-20181203154359-bf2de49a0be2/go.mod"
	"github.com/markbates/safe v1.0.1/go.mod"
	"github.com/mattn/go-colorable v0.0.9/go.mod"
	"github.com/mattn/go-colorable v0.1.7"
	"github.com/mattn/go-colorable v0.1.7/go.mod"
	"github.com/mattn/go-isatty v0.0.4/go.mod"
	"github.com/mattn/go-isatty v0.0.12"
	"github.com/mattn/go-isatty v0.0.12/go.mod"
	"github.com/mattn/go-runewidth v0.0.4"
	"github.com/mattn/go-runewidth v0.0.4/go.mod"
	"github.com/mgutz/ansi v0.0.0-20170206155736-9520e82c474b/go.mod"
	"github.com/mgutz/ansi v0.0.0-20200706080929-d51e80ef957d"
	"github.com/mgutz/ansi v0.0.0-20200706080929-d51e80ef957d/go.mod"
	"github.com/montanaflynn/stats v0.0.0-20171201202039-1bf9dbcd8cbe/go.mod"
	"github.com/nsf/termbox-go v0.0.0-20160718140619-0723e7c3d0a3"
	"github.com/nsf/termbox-go v0.0.0-20160718140619-0723e7c3d0a3/go.mod"
	"github.com/pelletier/go-toml v1.7.0/go.mod"
	"github.com/pkg/errors v0.8.0/go.mod"
	"github.com/pkg/errors v0.8.1/go.mod"
	"github.com/pkg/errors v0.9.1"
	"github.com/pkg/errors v0.9.1/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/rogpeppe/go-internal v1.1.0/go.mod"
	"github.com/rogpeppe/go-internal v1.2.2/go.mod"
	"github.com/rogpeppe/go-internal v1.3.0/go.mod"
	"github.com/sirupsen/logrus v1.4.0/go.mod"
	"github.com/sirupsen/logrus v1.4.1/go.mod"
	"github.com/sirupsen/logrus v1.4.2/go.mod"
	"github.com/smartystreets/assertions v0.0.0-20180927180507-b2de0cb4f26d"
	"github.com/smartystreets/assertions v0.0.0-20180927180507-b2de0cb4f26d/go.mod"
	"github.com/smartystreets/goconvey v1.6.4"
	"github.com/smartystreets/goconvey v1.6.4/go.mod"
	"github.com/spf13/cobra v0.0.3/go.mod"
	"github.com/spf13/pflag v1.0.3/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/objx v0.1.1/go.mod"
	"github.com/stretchr/testify v1.2.2/go.mod"
	"github.com/stretchr/testify v1.3.0/go.mod"
	"github.com/stretchr/testify v1.4.0/go.mod"
	"github.com/stretchr/testify v1.6.1"
	"github.com/stretchr/testify v1.6.1/go.mod"
	"github.com/tidwall/pretty v1.0.0"
	"github.com/tidwall/pretty v1.0.0/go.mod"
	"github.com/xdg-go/pbkdf2 v1.0.0"
	"github.com/xdg-go/pbkdf2 v1.0.0/go.mod"
	"github.com/xdg-go/scram v1.0.2"
	"github.com/xdg-go/scram v1.0.2/go.mod"
	"github.com/xdg-go/stringprep v1.0.2"
	"github.com/xdg-go/stringprep v1.0.2/go.mod"
	"github.com/youmark/pkcs8 v0.0.0-20181117223130-1be2e3e5546d"
	"github.com/youmark/pkcs8 v0.0.0-20181117223130-1be2e3e5546d/go.mod"
	"go.mongodb.org/mongo-driver v1.7.1"
	"go.mongodb.org/mongo-driver v1.7.1/go.mod"
	"golang.org/x/crypto v0.0.0-20180904163835-0709b304e793/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20190422162423-af44ce270edf/go.mod"
	"golang.org/x/crypto v0.0.0-20200302210943-78000ba7a073"
	"golang.org/x/crypto v0.0.0-20200302210943-78000ba7a073/go.mod"
	"golang.org/x/net v0.0.0-20190311183353-d8887717615a/go.mod"
	"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
	"golang.org/x/net v0.0.0-20190724013045-ca1201d0de80/go.mod"
	"golang.org/x/net v0.0.0-20200202094626-16171245cfb2"
	"golang.org/x/net v0.0.0-20200202094626-16171245cfb2/go.mod"
	"golang.org/x/sync v0.0.0-20190227155943-e225da77a7e6/go.mod"
	"golang.org/x/sync v0.0.0-20190412183630-56d357773e84/go.mod"
	"golang.org/x/sync v0.0.0-20190423024810-112230192c58/go.mod"
	"golang.org/x/sync v0.0.0-20190911185100-cd5d95a43a6e"
	"golang.org/x/sync v0.0.0-20190911185100-cd5d95a43a6e/go.mod"
	"golang.org/x/sys v0.0.0-20180905080454-ebe1bf3edb33/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190403152447-81d4e9dc473e/go.mod"
	"golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod"
	"golang.org/x/sys v0.0.0-20190419153524-e8e3143a4f4a/go.mod"
	"golang.org/x/sys v0.0.0-20190422165155-953cdadca894/go.mod"
	"golang.org/x/sys v0.0.0-20190531175056-4c3a928424d2/go.mod"
	"golang.org/x/sys v0.0.0-20190804053845-51ab0e2deafa/go.mod"
	"golang.org/x/sys v0.0.0-20200116001909-b77594299b42/go.mod"
	"golang.org/x/sys v0.0.0-20200223170610-d5e6a3e2c0ae/go.mod"
	"golang.org/x/sys v0.0.0-20200302150141-5c8b2ff67527"
	"golang.org/x/sys v0.0.0-20200302150141-5c8b2ff67527/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.5"
	"golang.org/x/text v0.3.5/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"golang.org/x/tools v0.0.0-20190328211700-ab21143f2384/go.mod"
	"golang.org/x/tools v0.0.0-20190329151228-23e29df326fe/go.mod"
	"golang.org/x/tools v0.0.0-20190416151739-9c9e1878f421/go.mod"
	"golang.org/x/tools v0.0.0-20190420181800-aa740d480789/go.mod"
	"golang.org/x/tools v0.0.0-20190531172133-b3315ee88b7d/go.mod"
	"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543"
	"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/check.v1 v1.0.0-20180628173108-788fd7840127"
	"gopkg.in/check.v1 v1.0.0-20180628173108-788fd7840127/go.mod"
	"gopkg.in/errgo.v2 v2.1.0/go.mod"
	"gopkg.in/tomb.v2 v2.0.0-20140626144623-14b3d72120e8"
	"gopkg.in/tomb.v2 v2.0.0-20140626144623-14b3d72120e8/go.mod"
	"gopkg.in/yaml.v2 v2.2.2/go.mod"
	"gopkg.in/yaml.v2 v2.2.8/go.mod"
	"gopkg.in/yaml.v2 v2.4.0"
	"gopkg.in/yaml.v2 v2.4.0/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
)

go-module_set_globals

SRC_URI="https://github.com/mongodb/mongo-tools/archive/87a3bfaaa773dbe7c3cc448a10fa309f3d0826d5.tar.gz -> mongo-tools-100.5.2-87a3bfaa.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="sasl ssl"

RDEPEND="
	net-libs/libpcap
	sasl? ( dev-libs/cyrus-sasl )
	ssl? ( dev-libs/openssl:0= )
"

post_src_unpack() {
	mv "${WORKDIR}"/mongo-tools-* "${S}" || die
}

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
			-ldflags "-X main.VersionStr=${PV} -X main.GitCommit=87a3bfaaa773dbe7c3cc448a10fa309f3d0826d5" \
			-buildmode=pie \
			--tags "${myconf[*]}" \
			./"${bin_path}" || die "compile failed"
	done
}

src_install() {
	dobin bin/*
}