# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

DESCRIPTION="A high-performance, open source, schema-free document-oriented database"
HOMEPAGE="https://www.mongodb.com"

EGO_SUM=(
	"github.com/3rf/mongo-lint v0.0.0-20140604191638-3550fdcf1f43"
	"github.com/3rf/mongo-lint v0.0.0-20140604191638-3550fdcf1f43/go.mod"
	"github.com/aws/aws-sdk-go v1.22.1/go.mod"
	"github.com/aws/aws-sdk-go v1.34.28"
	"github.com/aws/aws-sdk-go v1.34.28/go.mod"
	"github.com/craiggwilson/goke v0.0.0-20200309222237-69a77cdfe646"
	"github.com/craiggwilson/goke v0.0.0-20200309222237-69a77cdfe646/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/go-sql-driver/mysql v1.5.0/go.mod"
	"github.com/golang/snappy v0.0.1"
	"github.com/golang/snappy v0.0.1/go.mod"
	"github.com/google/go-cmp v0.5.2"
	"github.com/google/go-cmp v0.5.2/go.mod"
	"github.com/gopherjs/gopherjs v0.0.0-20181017120253-0766667cb4d1/go.mod"
	"github.com/gopherjs/gopherjs v0.0.0-20190430165422-3e4dfb77656c"
	"github.com/gopherjs/gopherjs v0.0.0-20190430165422-3e4dfb77656c/go.mod"
	"github.com/jessevdk/go-flags v1.4.0"
	"github.com/jessevdk/go-flags v1.4.0/go.mod"
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
	"github.com/montanaflynn/stats v0.0.0-20171201202039-1bf9dbcd8cbe"
	"github.com/montanaflynn/stats v0.0.0-20171201202039-1bf9dbcd8cbe/go.mod"
	"github.com/nsf/termbox-go v0.0.0-20160718140619-0723e7c3d0a3"
	"github.com/nsf/termbox-go v0.0.0-20160718140619-0723e7c3d0a3/go.mod"
	"github.com/pkg/errors v0.9.1"
	"github.com/pkg/errors v0.9.1/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/smartystreets/assertions v0.0.0-20180927180507-b2de0cb4f26d"
	"github.com/smartystreets/assertions v0.0.0-20180927180507-b2de0cb4f26d/go.mod"
	"github.com/smartystreets/goconvey v1.6.4"
	"github.com/smartystreets/goconvey v1.6.4/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.4.0/go.mod"
	"github.com/stretchr/testify v1.6.1/go.mod"
	"github.com/stretchr/testify v1.7.1"
	"github.com/stretchr/testify v1.7.1/go.mod"
	"github.com/tidwall/pretty v1.0.0"
	"github.com/tidwall/pretty v1.0.0/go.mod"
	"github.com/xdg-go/pbkdf2 v1.0.0"
	"github.com/xdg-go/pbkdf2 v1.0.0/go.mod"
	"github.com/xdg-go/scram v1.1.1"
	"github.com/xdg-go/scram v1.1.1/go.mod"
	"github.com/xdg-go/stringprep v1.0.3"
	"github.com/xdg-go/stringprep v1.0.3/go.mod"
	"github.com/youmark/pkcs8 v0.0.0-20181117223130-1be2e3e5546d"
	"github.com/youmark/pkcs8 v0.0.0-20181117223130-1be2e3e5546d/go.mod"
	"go.mongodb.org/mongo-driver v1.10.0"
	"go.mongodb.org/mongo-driver v1.10.0/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20220622213112-05595931fe9d"
	"golang.org/x/crypto v0.0.0-20220622213112-05595931fe9d/go.mod"
	"golang.org/x/net v0.0.0-20190311183353-d8887717615a/go.mod"
	"golang.org/x/net v0.0.0-20190724013045-ca1201d0de80/go.mod"
	"golang.org/x/net v0.0.0-20200202094626-16171245cfb2/go.mod"
	"golang.org/x/net v0.0.0-20211112202133-69e39bad7dc2"
	"golang.org/x/net v0.0.0-20211112202133-69e39bad7dc2/go.mod"
	"golang.org/x/sync v0.0.0-20210220032951-036812b2e83c"
	"golang.org/x/sync v0.0.0-20210220032951-036812b2e83c/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190804053845-51ab0e2deafa/go.mod"
	"golang.org/x/sys v0.0.0-20200116001909-b77594299b42/go.mod"
	"golang.org/x/sys v0.0.0-20200223170610-d5e6a3e2c0ae/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/sys v0.0.0-20210423082822-04245dca01da/go.mod"
	"golang.org/x/sys v0.0.0-20210615035016-665e8c7367d1/go.mod"
	"golang.org/x/sys v0.0.0-20220520151302-bc2c85ada10a"
	"golang.org/x/sys v0.0.0-20220520151302-bc2c85ada10a/go.mod"
	"golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1"
	"golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.6/go.mod"
	"golang.org/x/text v0.3.7"
	"golang.org/x/text v0.3.7/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"golang.org/x/tools v0.0.0-20190328211700-ab21143f2384/go.mod"
	"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543"
	"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/check.v1 v1.0.0-20180628173108-788fd7840127"
	"gopkg.in/check.v1 v1.0.0-20180628173108-788fd7840127/go.mod"
	"gopkg.in/tomb.v2 v2.0.0-20140626144623-14b3d72120e8"
	"gopkg.in/tomb.v2 v2.0.0-20140626144623-14b3d72120e8/go.mod"
	"gopkg.in/yaml.v2 v2.2.2/go.mod"
	"gopkg.in/yaml.v2 v2.2.8/go.mod"
	"gopkg.in/yaml.v2 v2.4.0"
	"gopkg.in/yaml.v2 v2.4.0/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
)

go-module_set_globals

SRC_URI="https://github.com/mongodb/mongo-tools/archive/11f4f743a18c5ec3bfce4dff86810c59264342a6.tar.gz -> mongo-tools-100.6.0-11f4f743.tar.gz
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
			-ldflags "-X main.VersionStr=${PV} -X main.GitCommit=11f4f743a18c5ec3bfce4dff86810c59264342a6" \
			-buildmode=pie \
			--tags "${myconf[*]}" \
			./"${bin_path}" || die "compile failed"
	done
}

src_install() {
	dobin bin/*
}