# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_SUM=(
	"github.com/!burnt!sushi/toml v1.5.0"
	"github.com/!burnt!sushi/toml v1.5.0/go.mod"
	"github.com/mattn/go-isatty v0.0.20"
	"github.com/mattn/go-isatty v0.0.20/go.mod"
	"golang.org/x/mod v0.24.0"
	"golang.org/x/mod v0.24.0/go.mod"
	"golang.org/x/sys v0.6.0/go.mod"
	"golang.org/x/sys v0.30.0"
	"golang.org/x/sys v0.30.0/go.mod"
)

go-module_set_globals

DESCRIPTION="Direnv is an environment switcher for the shell"
HOMEPAGE="https://direnv.net"
SRC_URI="https://github.com/direnv/direnv/tarball/afa992bd1bbcd3b38efa85e62e03a9f8964ff251 -> direnv-2.36.0-afa992b.tar.gz
https://distfiles.macaronios.org/23/61/7b/23617b52c5d9ea3f17ae0fd0bd60cd238244fc22820989c62829a76fdb178c534674585e2b38165ebc352edda9fcfa6fc09b09c8a93d169ccb7551e0c5265298 -> direnv-2.36.0-funtoo-go-bundle-31ed1dd2884caf732ea1a993289b6da0706189975c3b80cba884def0fe4e4a8abd4d4fb0b9bedbf905798447c9c121108460a91c421d7b99a17b6fe666e0b1cd.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

DEPEND="dev-lang/go"

# depends on golangci-lint which we do not have an ebuild for
RESTRICT="test"

post_src_unpack() {
	mv "${WORKDIR}"/direnv-direnv-* "${S}" || die
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
	einstalldocs
}