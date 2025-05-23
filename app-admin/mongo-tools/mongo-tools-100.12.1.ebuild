# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

DESCRIPTION="A high-performance, open source, schema-free document-oriented database"
HOMEPAGE="https://www.mongodb.com"

EGO_SUM=(
	"github.com/!azure/azure-sdk-for-go/sdk/azcore v1.17.0"
	"github.com/!azure/azure-sdk-for-go/sdk/azcore v1.17.0/go.mod"
	"github.com/!azure/azure-sdk-for-go/sdk/azidentity v1.8.0"
	"github.com/!azure/azure-sdk-for-go/sdk/azidentity v1.8.0/go.mod"
	"github.com/!azure/azure-sdk-for-go/sdk/azidentity/cache v0.3.0"
	"github.com/!azure/azure-sdk-for-go/sdk/azidentity/cache v0.3.0/go.mod"
	"github.com/!azure/azure-sdk-for-go/sdk/internal v1.10.0"
	"github.com/!azure/azure-sdk-for-go/sdk/internal v1.10.0/go.mod"
	"github.com/!azure!a!d/microsoft-authentication-extensions-for-go/cache v0.1.1"
	"github.com/!azure!a!d/microsoft-authentication-extensions-for-go/cache v0.1.1/go.mod"
	"github.com/!azure!a!d/microsoft-authentication-library-for-go v1.3.2"
	"github.com/!azure!a!d/microsoft-authentication-library-for-go v1.3.2/go.mod"
	"github.com/aws/aws-sdk-go v1.44.114/go.mod"
	"github.com/aws/aws-sdk-go v1.53.11"
	"github.com/aws/aws-sdk-go v1.53.11/go.mod"
	"github.com/cespare/xxhash/v2 v2.3.0"
	"github.com/cespare/xxhash/v2 v2.3.0/go.mod"
	"github.com/cpuguy83/go-md2man/v2 v2.0.4"
	"github.com/cpuguy83/go-md2man/v2 v2.0.4/go.mod"
	"github.com/craiggwilson/goke v0.0.0-20240206162536-b1c58122d943"
	"github.com/craiggwilson/goke v0.0.0-20240206162536-b1c58122d943/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/deckarep/golang-set/v2 v2.6.0"
	"github.com/deckarep/golang-set/v2 v2.6.0/go.mod"
	"github.com/dgryski/go-rendezvous v0.0.0-20200823014737-9f7001d12a5f"
	"github.com/dgryski/go-rendezvous v0.0.0-20200823014737-9f7001d12a5f/go.mod"
	"github.com/golang-jwt/jwt/v5 v5.2.2"
	"github.com/golang-jwt/jwt/v5 v5.2.2/go.mod"
	"github.com/golang/snappy v0.0.4"
	"github.com/golang/snappy v0.0.4/go.mod"
	"github.com/google/go-cmp v0.6.0"
	"github.com/google/go-cmp v0.6.0/go.mod"
	"github.com/google/uuid v1.6.0"
	"github.com/google/uuid v1.6.0/go.mod"
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
	"github.com/keybase/go-keychain v0.0.0-20231219164618-57a3676c3af6"
	"github.com/keybase/go-keychain v0.0.0-20231219164618-57a3676c3af6/go.mod"
	"github.com/klauspost/compress v1.17.8"
	"github.com/klauspost/compress v1.17.8/go.mod"
	"github.com/kr/pretty v0.3.1"
	"github.com/kr/pretty v0.3.1/go.mod"
	"github.com/kr/text v0.2.0"
	"github.com/kr/text v0.2.0/go.mod"
	"github.com/kylelemons/godebug v1.1.0"
	"github.com/kylelemons/godebug v1.1.0/go.mod"
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
	"github.com/montanaflynn/stats v0.7.1"
	"github.com/montanaflynn/stats v0.7.1/go.mod"
	"github.com/nsf/termbox-go v1.1.1"
	"github.com/nsf/termbox-go v1.1.1/go.mod"
	"github.com/pkg/browser v0.0.0-20240102092130-5ac0b6a4141c"
	"github.com/pkg/browser v0.0.0-20240102092130-5ac0b6a4141c/go.mod"
	"github.com/pkg/errors v0.9.1"
	"github.com/pkg/errors v0.9.1/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/redis/go-redis/v9 v9.6.1"
	"github.com/redis/go-redis/v9 v9.6.1/go.mod"
	"github.com/rivo/uniseg v0.2.0/go.mod"
	"github.com/rivo/uniseg v0.4.7"
	"github.com/rivo/uniseg v0.4.7/go.mod"
	"github.com/rogpeppe/go-internal v1.12.0"
	"github.com/rogpeppe/go-internal v1.12.0/go.mod"
	"github.com/russross/blackfriday/v2 v2.1.0"
	"github.com/russross/blackfriday/v2 v2.1.0/go.mod"
	"github.com/samber/lo v1.49.1"
	"github.com/samber/lo v1.49.1/go.mod"
	"github.com/smarty/assertions v1.15.0"
	"github.com/smarty/assertions v1.15.0/go.mod"
	"github.com/smartystreets/goconvey v1.8.1"
	"github.com/smartystreets/goconvey v1.8.1/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.10.0"
	"github.com/stretchr/testify v1.10.0/go.mod"
	"github.com/urfave/cli/v2 v2.27.2"
	"github.com/urfave/cli/v2 v2.27.2/go.mod"
	"github.com/xdg-go/pbkdf2 v1.0.0"
	"github.com/xdg-go/pbkdf2 v1.0.0/go.mod"
	"github.com/xdg-go/scram v1.1.2"
	"github.com/xdg-go/scram v1.1.2/go.mod"
	"github.com/xdg-go/stringprep v1.0.4"
	"github.com/xdg-go/stringprep v1.0.4/go.mod"
	"github.com/xrash/smetrics v0.0.0-20240521201337-686a1a2994c1"
	"github.com/xrash/smetrics v0.0.0-20240521201337-686a1a2994c1/go.mod"
	"github.com/youmark/pkcs8 v0.0.0-20240726163527-a2c0da244d78"
	"github.com/youmark/pkcs8 v0.0.0-20240726163527-a2c0da244d78/go.mod"
	"github.com/yuin/goldmark v1.4.13/go.mod"
	"go.mongodb.org/mongo-driver v1.17.3"
	"go.mongodb.org/mongo-driver v1.17.3/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20210921155107-089bfa567519/go.mod"
	"golang.org/x/crypto v0.38.0"
	"golang.org/x/crypto v0.38.0/go.mod"
	"golang.org/x/exp v0.0.0-20250128182459-e0ece0dbea4c"
	"golang.org/x/exp v0.0.0-20250128182459-e0ece0dbea4c/go.mod"
	"golang.org/x/mod v0.6.0-dev.0.20220419223038-86c51ed26bb4/go.mod"
	"golang.org/x/mod v0.22.0"
	"golang.org/x/mod v0.22.0/go.mod"
	"golang.org/x/net v0.0.0-20190620200207-3b0461eec859/go.mod"
	"golang.org/x/net v0.0.0-20210226172049-e18ecbb05110/go.mod"
	"golang.org/x/net v0.0.0-20220127200216-cd36cc0744dd/go.mod"
	"golang.org/x/net v0.0.0-20220722155237-a158d28d115b/go.mod"
	"golang.org/x/net v0.40.0"
	"golang.org/x/net v0.40.0/go.mod"
	"golang.org/x/sync v0.0.0-20190423024810-112230192c58/go.mod"
	"golang.org/x/sync v0.0.0-20220722155255-886fb9371eb4/go.mod"
	"golang.org/x/sync v0.14.0"
	"golang.org/x/sync v0.14.0/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/sys v0.0.0-20210320140829-1e4c9ba3b0c4/go.mod"
	"golang.org/x/sys v0.0.0-20210615035016-665e8c7367d1/go.mod"
	"golang.org/x/sys v0.0.0-20211216021012-1d35b9e2eb4e/go.mod"
	"golang.org/x/sys v0.0.0-20220520151302-bc2c85ada10a/go.mod"
	"golang.org/x/sys v0.0.0-20220722155257-8c9f86f7a55f/go.mod"
	"golang.org/x/sys v0.0.0-20220811171246-fbc7d0a398ab/go.mod"
	"golang.org/x/sys v0.1.0/go.mod"
	"golang.org/x/sys v0.6.0/go.mod"
	"golang.org/x/sys v0.33.0"
	"golang.org/x/sys v0.33.0/go.mod"
	"golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1/go.mod"
	"golang.org/x/term v0.0.0-20210927222741-03fcf44c2211/go.mod"
	"golang.org/x/term v0.32.0"
	"golang.org/x/term v0.32.0/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.3/go.mod"
	"golang.org/x/text v0.3.7/go.mod"
	"golang.org/x/text v0.3.8/go.mod"
	"golang.org/x/text v0.25.0"
	"golang.org/x/text v0.25.0/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"golang.org/x/tools v0.0.0-20191119224855-298f0cb1881e/go.mod"
	"golang.org/x/tools v0.1.12/go.mod"
	"golang.org/x/xerrors v0.0.0-20190717185122-a985d3407aa7/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/check.v1 v1.0.0-20201130134442-10cb98267c6c"
	"gopkg.in/check.v1 v1.0.0-20201130134442-10cb98267c6c/go.mod"
	"gopkg.in/tomb.v2 v2.0.0-20161208151619-d5d1b5820637"
	"gopkg.in/tomb.v2 v2.0.0-20161208151619-d5d1b5820637/go.mod"
	"gopkg.in/yaml.v2 v2.2.8/go.mod"
	"gopkg.in/yaml.v2 v2.4.0"
	"gopkg.in/yaml.v2 v2.4.0/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
)

go-module_set_globals

SRC_URI="https://github.com/mongodb/mongo-tools/tarball/6ed2d84211f54467fd6495a381a3e7102f48ba42 -> mongo-tools-100.12.1-6ed2d84.tar.gz
https://distfiles.macaronios.org/18/a4/7b/18a47bdd6c37741b01c03b275d994a18b603d4cabd7ba42adcd0af65448ec9f0f0b963e698e85b534fd821b0a5960e6c6c37acd33d713da90bbef1ea6bff0f8e -> mongo-tools-100.12.1-funtoo-go-bundle-e7c0b0144871a8fa375f9b31aceaeab1ceefa196f3b9c86f251f179c911a6e4d535cf5fe4e0b6fbe5a2feac97d98eeee6b48f11fbccdadde493092694095f83d.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="sasl ssl"
S="${WORKDIR}/mongodb-mongo-tools-6ed2d84"

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