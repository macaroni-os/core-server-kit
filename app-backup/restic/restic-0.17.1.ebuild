# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module bash-completion-r1

EGO_SUM=(
	"cloud.google.com/go v0.26.0/go.mod"
	"cloud.google.com/go v0.115.0"
	"cloud.google.com/go v0.115.0/go.mod"
	"cloud.google.com/go/auth v0.6.1"
	"cloud.google.com/go/auth v0.6.1/go.mod"
	"cloud.google.com/go/auth/oauth2adapt v0.2.2"
	"cloud.google.com/go/auth/oauth2adapt v0.2.2/go.mod"
	"cloud.google.com/go/compute/metadata v0.3.0"
	"cloud.google.com/go/compute/metadata v0.3.0/go.mod"
	"cloud.google.com/go/iam v1.1.8"
	"cloud.google.com/go/iam v1.1.8/go.mod"
	"cloud.google.com/go/longrunning v0.5.7"
	"cloud.google.com/go/storage v1.43.0"
	"cloud.google.com/go/storage v1.43.0/go.mod"
	"github.com/!azure/azure-sdk-for-go/sdk/azcore v1.12.0"
	"github.com/!azure/azure-sdk-for-go/sdk/azcore v1.12.0/go.mod"
	"github.com/!azure/azure-sdk-for-go/sdk/azidentity v1.7.0"
	"github.com/!azure/azure-sdk-for-go/sdk/azidentity v1.7.0/go.mod"
	"github.com/!azure/azure-sdk-for-go/sdk/internal v1.9.0"
	"github.com/!azure/azure-sdk-for-go/sdk/internal v1.9.0/go.mod"
	"github.com/!azure/azure-sdk-for-go/sdk/resourcemanager/storage/armstorage v1.5.0"
	"github.com/!azure/azure-sdk-for-go/sdk/storage/azblob v1.3.2"
	"github.com/!azure/azure-sdk-for-go/sdk/storage/azblob v1.3.2/go.mod"
	"github.com/!azure!a!d/microsoft-authentication-library-for-go v1.2.2"
	"github.com/!azure!a!d/microsoft-authentication-library-for-go v1.2.2/go.mod"
	"github.com/!backblaze/blazer v0.6.1"
	"github.com/!backblaze/blazer v0.6.1/go.mod"
	"github.com/!burnt!sushi/toml v0.3.1/go.mod"
	"github.com/!julusian/godocdown v0.0.0-20170816220326-6d19f8ff2df8/go.mod"
	"github.com/anacrolix/envpprof v1.3.0"
	"github.com/anacrolix/envpprof v1.3.0/go.mod"
	"github.com/anacrolix/fuse v0.3.1"
	"github.com/anacrolix/fuse v0.3.1/go.mod"
	"github.com/anacrolix/generics v0.0.0-20230113004304-d6428d516633"
	"github.com/anacrolix/generics v0.0.0-20230113004304-d6428d516633/go.mod"
	"github.com/anacrolix/log v0.13.1/go.mod"
	"github.com/anacrolix/log v0.14.1"
	"github.com/anacrolix/log v0.14.1/go.mod"
	"github.com/cenkalti/backoff/v4 v4.3.0"
	"github.com/cenkalti/backoff/v4 v4.3.0/go.mod"
	"github.com/census-instrumentation/opencensus-proto v0.2.1/go.mod"
	"github.com/cespare/xxhash/v2 v2.3.0"
	"github.com/cespare/xxhash/v2 v2.3.0/go.mod"
	"github.com/chzyer/logex v1.1.10/go.mod"
	"github.com/chzyer/readline v0.0.0-20180603132655-2972be24d48e/go.mod"
	"github.com/chzyer/test v0.0.0-20180213035817-a1ea475d72b1/go.mod"
	"github.com/client9/misspell v0.3.4/go.mod"
	"github.com/cncf/udpa/go v0.0.0-20191209042840-269d4d468f6f/go.mod"
	"github.com/cpuguy83/go-md2man/v2 v2.0.4"
	"github.com/cpuguy83/go-md2man/v2 v2.0.4/go.mod"
	"github.com/creack/pty v1.1.9/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/dustin/go-humanize v1.0.1"
	"github.com/dustin/go-humanize v1.0.1/go.mod"
	"github.com/dvyukov/go-fuzz v0.0.0-20220726122315-1d375ef9f9f6/go.mod"
	"github.com/elazarl/go-bindata-assetfs v1.0.0/go.mod"
	"github.com/elithrar/simple-scrypt v1.3.0"
	"github.com/elithrar/simple-scrypt v1.3.0/go.mod"
	"github.com/envoyproxy/go-control-plane v0.9.0/go.mod"
	"github.com/envoyproxy/go-control-plane v0.9.1-0.20191026205805-5f8ba28d4473/go.mod"
	"github.com/envoyproxy/go-control-plane v0.9.4/go.mod"
	"github.com/envoyproxy/protoc-gen-validate v0.1.0/go.mod"
	"github.com/felixge/fgprof v0.9.3"
	"github.com/felixge/fgprof v0.9.3/go.mod"
	"github.com/felixge/httpsnoop v1.0.4"
	"github.com/felixge/httpsnoop v1.0.4/go.mod"
	"github.com/frankban/quicktest v1.14.4/go.mod"
	"github.com/go-logr/logr v1.2.2/go.mod"
	"github.com/go-logr/logr v1.4.1"
	"github.com/go-logr/logr v1.4.1/go.mod"
	"github.com/go-logr/stdr v1.2.2"
	"github.com/go-logr/stdr v1.2.2/go.mod"
	"github.com/go-ole/go-ole v1.3.0"
	"github.com/go-ole/go-ole v1.3.0/go.mod"
	"github.com/golang-jwt/jwt/v5 v5.2.1"
	"github.com/golang-jwt/jwt/v5 v5.2.1/go.mod"
	"github.com/golang/glog v0.0.0-20160126235308-23def4e6c14b/go.mod"
	"github.com/golang/groupcache v0.0.0-20200121045136-8c9f03a8e57e/go.mod"
	"github.com/golang/groupcache v0.0.0-20210331224755-41bb18bfe9da"
	"github.com/golang/groupcache v0.0.0-20210331224755-41bb18bfe9da/go.mod"
	"github.com/golang/mock v1.1.1/go.mod"
	"github.com/golang/protobuf v1.2.0/go.mod"
	"github.com/golang/protobuf v1.3.2/go.mod"
	"github.com/golang/protobuf v1.4.0-rc.1/go.mod"
	"github.com/golang/protobuf v1.4.0-rc.1.0.20200221234624-67d41d38c208/go.mod"
	"github.com/golang/protobuf v1.4.0-rc.2/go.mod"
	"github.com/golang/protobuf v1.4.0-rc.4.0.20200313231945-b860323f09d0/go.mod"
	"github.com/golang/protobuf v1.4.0/go.mod"
	"github.com/golang/protobuf v1.4.1/go.mod"
	"github.com/golang/protobuf v1.4.3/go.mod"
	"github.com/golang/protobuf v1.5.4"
	"github.com/golang/protobuf v1.5.4/go.mod"
	"github.com/google/go-cmp v0.2.0/go.mod"
	"github.com/google/go-cmp v0.3.0/go.mod"
	"github.com/google/go-cmp v0.3.1/go.mod"
	"github.com/google/go-cmp v0.4.0/go.mod"
	"github.com/google/go-cmp v0.5.0/go.mod"
	"github.com/google/go-cmp v0.5.3/go.mod"
	"github.com/google/go-cmp v0.5.9/go.mod"
	"github.com/google/go-cmp v0.6.0"
	"github.com/google/go-cmp v0.6.0/go.mod"
	"github.com/google/gofuzz v1.0.0/go.mod"
	"github.com/google/martian/v3 v3.3.3"
	"github.com/google/pprof v0.0.0-20211214055906-6f57359322fd/go.mod"
	"github.com/google/pprof v0.0.0-20230926050212-f7f687d19a98"
	"github.com/google/pprof v0.0.0-20230926050212-f7f687d19a98/go.mod"
	"github.com/google/s2a-go v0.1.7"
	"github.com/google/s2a-go v0.1.7/go.mod"
	"github.com/google/uuid v1.1.2/go.mod"
	"github.com/google/uuid v1.6.0"
	"github.com/google/uuid v1.6.0/go.mod"
	"github.com/googleapis/enterprise-certificate-proxy v0.3.2"
	"github.com/googleapis/enterprise-certificate-proxy v0.3.2/go.mod"
	"github.com/googleapis/gax-go/v2 v2.12.5"
	"github.com/googleapis/gax-go/v2 v2.12.5/go.mod"
	"github.com/hashicorp/golang-lru/v2 v2.0.7"
	"github.com/hashicorp/golang-lru/v2 v2.0.7/go.mod"
	"github.com/ianlancetaylor/demangle v0.0.0-20210905161508-09a460cdf81d/go.mod"
	"github.com/inconshreveable/mousetrap v1.1.0"
	"github.com/inconshreveable/mousetrap v1.1.0/go.mod"
	"github.com/json-iterator/go v1.1.12"
	"github.com/json-iterator/go v1.1.12/go.mod"
	"github.com/klauspost/compress v1.17.9"
	"github.com/klauspost/compress v1.17.9/go.mod"
	"github.com/klauspost/cpuid/v2 v2.0.1/go.mod"
	"github.com/klauspost/cpuid/v2 v2.2.6"
	"github.com/klauspost/cpuid/v2 v2.2.6/go.mod"
	"github.com/kr/fs v0.1.0"
	"github.com/kr/fs v0.1.0/go.mod"
	"github.com/kr/pretty v0.1.0/go.mod"
	"github.com/kr/pretty v0.3.0/go.mod"
	"github.com/kr/pretty v0.3.1"
	"github.com/kr/pretty v0.3.1/go.mod"
	"github.com/kr/pty v1.1.1/go.mod"
	"github.com/kr/text v0.1.0/go.mod"
	"github.com/kr/text v0.2.0"
	"github.com/kr/text v0.2.0/go.mod"
	"github.com/kylelemons/godebug v1.1.0"
	"github.com/kylelemons/godebug v1.1.0/go.mod"
	"github.com/miekg/dns v1.1.54/go.mod"
	"github.com/minio/md5-simd v1.1.2"
	"github.com/minio/md5-simd v1.1.2/go.mod"
	"github.com/minio/minio-go/v7 v7.0.66"
	"github.com/minio/minio-go/v7 v7.0.66/go.mod"
	"github.com/minio/sha256-simd v1.0.1"
	"github.com/minio/sha256-simd v1.0.1/go.mod"
	"github.com/modern-go/concurrent v0.0.0-20180228061459-e0a39a4cb421/go.mod"
	"github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd"
	"github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd/go.mod"
	"github.com/modern-go/reflect2 v1.0.2"
	"github.com/modern-go/reflect2 v1.0.2/go.mod"
	"github.com/ncw/swift/v2 v2.0.2"
	"github.com/ncw/swift/v2 v2.0.2/go.mod"
	"github.com/oklog/run v1.1.0/go.mod"
	"github.com/pelletier/go-toml v1.9.5/go.mod"
	"github.com/peterbourgon/ff/v3 v3.3.1/go.mod"
	"github.com/peterbourgon/unixtransport v0.0.4"
	"github.com/peterbourgon/unixtransport v0.0.4/go.mod"
	"github.com/pkg/browser v0.0.0-20240102092130-5ac0b6a4141c"
	"github.com/pkg/browser v0.0.0-20240102092130-5ac0b6a4141c/go.mod"
	"github.com/pkg/diff v0.0.0-20210226163009-20ebb0f2a09e/go.mod"
	"github.com/pkg/errors v0.9.1"
	"github.com/pkg/errors v0.9.1/go.mod"
	"github.com/pkg/profile v1.7.0"
	"github.com/pkg/profile v1.7.0/go.mod"
	"github.com/pkg/sftp v1.13.6"
	"github.com/pkg/sftp v1.13.6/go.mod"
	"github.com/pkg/xattr v0.4.10"
	"github.com/pkg/xattr v0.4.10/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/prashantv/gostub v1.1.0"
	"github.com/prometheus/client_model v0.0.0-20190812154241-14fe0d1b01d4/go.mod"
	"github.com/restic/chunker v0.4.0"
	"github.com/restic/chunker v0.4.0/go.mod"
	"github.com/robertkrimen/godocdown v0.0.0-20130622164427-0bfa04905481/go.mod"
	"github.com/rogpeppe/go-internal v1.6.1/go.mod"
	"github.com/rogpeppe/go-internal v1.8.0/go.mod"
	"github.com/rogpeppe/go-internal v1.9.0/go.mod"
	"github.com/rogpeppe/go-internal v1.12.0"
	"github.com/rs/xid v1.5.0"
	"github.com/rs/xid v1.5.0/go.mod"
	"github.com/russross/blackfriday/v2 v2.1.0"
	"github.com/russross/blackfriday/v2 v2.1.0/go.mod"
	"github.com/sirupsen/logrus v1.9.3"
	"github.com/sirupsen/logrus v1.9.3/go.mod"
	"github.com/spf13/cobra v1.8.1"
	"github.com/spf13/cobra v1.8.1/go.mod"
	"github.com/spf13/pflag v1.0.5"
	"github.com/spf13/pflag v1.0.5/go.mod"
	"github.com/stephens2424/writerset v1.0.2/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/objx v0.4.0/go.mod"
	"github.com/stretchr/objx v0.5.0/go.mod"
	"github.com/stretchr/testify v1.3.0/go.mod"
	"github.com/stretchr/testify v1.7.0/go.mod"
	"github.com/stretchr/testify v1.7.1/go.mod"
	"github.com/stretchr/testify v1.8.0/go.mod"
	"github.com/stretchr/testify v1.8.1/go.mod"
	"github.com/stretchr/testify v1.9.0"
	"github.com/tv42/httpunix v0.0.0-20191220191345-2ba4b9c3382c"
	"github.com/tv42/httpunix v0.0.0-20191220191345-2ba4b9c3382c/go.mod"
	"github.com/yuin/goldmark v1.4.1/go.mod"
	"github.com/yuin/goldmark v1.4.13/go.mod"
	"go.opencensus.io v0.24.0"
	"go.opencensus.io v0.24.0/go.mod"
	"go.opentelemetry.io/contrib/instrumentation/google.golang.org/grpc/otelgrpc v0.49.0"
	"go.opentelemetry.io/contrib/instrumentation/google.golang.org/grpc/otelgrpc v0.49.0/go.mod"
	"go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp v0.49.0"
	"go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp v0.49.0/go.mod"
	"go.opentelemetry.io/otel v1.24.0"
	"go.opentelemetry.io/otel v1.24.0/go.mod"
	"go.opentelemetry.io/otel/metric v1.24.0"
	"go.opentelemetry.io/otel/metric v1.24.0/go.mod"
	"go.opentelemetry.io/otel/sdk v1.24.0"
	"go.opentelemetry.io/otel/trace v1.24.0"
	"go.opentelemetry.io/otel/trace v1.24.0/go.mod"
	"go.uber.org/automaxprocs v1.5.3"
	"go.uber.org/automaxprocs v1.5.3/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20191011191535-87dc89f01550/go.mod"
	"golang.org/x/crypto v0.0.0-20200622213623-75b288015ac9/go.mod"
	"golang.org/x/crypto v0.0.0-20210921155107-089bfa567519/go.mod"
	"golang.org/x/crypto v0.1.0/go.mod"
	"golang.org/x/crypto v0.24.0"
	"golang.org/x/crypto v0.24.0/go.mod"
	"golang.org/x/exp v0.0.0-20190121172915-509febef88a4/go.mod"
	"golang.org/x/exp v0.0.0-20220428152302-39d4317da171"
	"golang.org/x/exp v0.0.0-20220428152302-39d4317da171/go.mod"
	"golang.org/x/lint v0.0.0-20181026193005-c67002cb31c3/go.mod"
	"golang.org/x/lint v0.0.0-20190227174305-5b3e6a55c961/go.mod"
	"golang.org/x/lint v0.0.0-20190313153728-d0100b6bd8b3/go.mod"
	"golang.org/x/mod v0.5.1/go.mod"
	"golang.org/x/mod v0.6.0-dev.0.20211013180041-c96bc1413d57/go.mod"
	"golang.org/x/mod v0.6.0-dev.0.20220419223038-86c51ed26bb4/go.mod"
	"golang.org/x/mod v0.7.0/go.mod"
	"golang.org/x/net v0.0.0-20180724234803-3673e40ba225/go.mod"
	"golang.org/x/net v0.0.0-20180826012351-8a410e7b638d/go.mod"
	"golang.org/x/net v0.0.0-20190213061140-3a22650c66bd/go.mod"
	"golang.org/x/net v0.0.0-20190311183353-d8887717615a/go.mod"
	"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
	"golang.org/x/net v0.0.0-20190620200207-3b0461eec859/go.mod"
	"golang.org/x/net v0.0.0-20201110031124-69a78807bb2b/go.mod"
	"golang.org/x/net v0.0.0-20210226172049-e18ecbb05110/go.mod"
	"golang.org/x/net v0.0.0-20211015210444-4f30a5c0130f/go.mod"
	"golang.org/x/net v0.0.0-20220722155237-a158d28d115b/go.mod"
	"golang.org/x/net v0.1.0/go.mod"
	"golang.org/x/net v0.2.0/go.mod"
	"golang.org/x/net v0.26.0"
	"golang.org/x/net v0.26.0/go.mod"
	"golang.org/x/oauth2 v0.0.0-20180821212333-d2e6202438be/go.mod"
	"golang.org/x/oauth2 v0.21.0"
	"golang.org/x/oauth2 v0.21.0/go.mod"
	"golang.org/x/sync v0.0.0-20180314180146-1d60e4601c6f/go.mod"
	"golang.org/x/sync v0.0.0-20181108010431-42b317875d0f/go.mod"
	"golang.org/x/sync v0.0.0-20190423024810-112230192c58/go.mod"
	"golang.org/x/sync v0.0.0-20210220032951-036812b2e83c/go.mod"
	"golang.org/x/sync v0.0.0-20220722155255-886fb9371eb4/go.mod"
	"golang.org/x/sync v0.1.0/go.mod"
	"golang.org/x/sync v0.7.0"
	"golang.org/x/sync v0.7.0/go.mod"
	"golang.org/x/sys v0.0.0-20180830151530-49385e6e1522/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod"
	"golang.org/x/sys v0.0.0-20200930185726-fdedc70b468f/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/sys v0.0.0-20210423082822-04245dca01da/go.mod"
	"golang.org/x/sys v0.0.0-20210615035016-665e8c7367d1/go.mod"
	"golang.org/x/sys v0.0.0-20211007075335-d3039528d8ac/go.mod"
	"golang.org/x/sys v0.0.0-20211019181941-9d821ace8654/go.mod"
	"golang.org/x/sys v0.0.0-20220408201424-a24fb2fb8a0f/go.mod"
	"golang.org/x/sys v0.0.0-20220520151302-bc2c85ada10a/go.mod"
	"golang.org/x/sys v0.0.0-20220715151400-c0bba94af5f8/go.mod"
	"golang.org/x/sys v0.0.0-20220722155257-8c9f86f7a55f/go.mod"
	"golang.org/x/sys v0.1.0/go.mod"
	"golang.org/x/sys v0.2.0/go.mod"
	"golang.org/x/sys v0.5.0/go.mod"
	"golang.org/x/sys v0.10.0/go.mod"
	"golang.org/x/sys v0.22.0"
	"golang.org/x/sys v0.22.0/go.mod"
	"golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1/go.mod"
	"golang.org/x/term v0.0.0-20210927222741-03fcf44c2211/go.mod"
	"golang.org/x/term v0.1.0/go.mod"
	"golang.org/x/term v0.2.0/go.mod"
	"golang.org/x/term v0.22.0"
	"golang.org/x/term v0.22.0/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.3/go.mod"
	"golang.org/x/text v0.3.6/go.mod"
	"golang.org/x/text v0.3.7/go.mod"
	"golang.org/x/text v0.4.0/go.mod"
	"golang.org/x/text v0.16.0"
	"golang.org/x/text v0.16.0/go.mod"
	"golang.org/x/time v0.5.0"
	"golang.org/x/time v0.5.0/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"golang.org/x/tools v0.0.0-20190114222345-bf090417da8b/go.mod"
	"golang.org/x/tools v0.0.0-20190226205152-f727befe758c/go.mod"
	"golang.org/x/tools v0.0.0-20190311212946-11955173bddd/go.mod"
	"golang.org/x/tools v0.0.0-20190524140312-2c0ae7006135/go.mod"
	"golang.org/x/tools v0.0.0-20191119224855-298f0cb1881e/go.mod"
	"golang.org/x/tools v0.1.8-0.20211029000441-d6a9af8af023/go.mod"
	"golang.org/x/tools v0.1.12/go.mod"
	"golang.org/x/tools v0.3.0/go.mod"
	"golang.org/x/xerrors v0.0.0-20190717185122-a985d3407aa7/go.mod"
	"golang.org/x/xerrors v0.0.0-20191011141410-1b5146add898/go.mod"
	"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543/go.mod"
	"golang.org/x/xerrors v0.0.0-20200804184101-5ec99f83aff1/go.mod"
	"google.golang.org/api v0.187.0"
	"google.golang.org/api v0.187.0/go.mod"
	"google.golang.org/appengine v1.1.0/go.mod"
	"google.golang.org/appengine v1.4.0/go.mod"
	"google.golang.org/genproto v0.0.0-20180817151627-c66870c02cf8/go.mod"
	"google.golang.org/genproto v0.0.0-20190819201941-24fa4b261c55/go.mod"
	"google.golang.org/genproto v0.0.0-20200526211855-cb27e3aa2013/go.mod"
	"google.golang.org/genproto v0.0.0-20240624140628-dc46fd24d27d"
	"google.golang.org/genproto v0.0.0-20240624140628-dc46fd24d27d/go.mod"
	"google.golang.org/genproto/googleapis/api v0.0.0-20240617180043-68d350f18fd4"
	"google.golang.org/genproto/googleapis/api v0.0.0-20240617180043-68d350f18fd4/go.mod"
	"google.golang.org/genproto/googleapis/rpc v0.0.0-20240624140628-dc46fd24d27d"
	"google.golang.org/genproto/googleapis/rpc v0.0.0-20240624140628-dc46fd24d27d/go.mod"
	"google.golang.org/grpc v1.19.0/go.mod"
	"google.golang.org/grpc v1.23.0/go.mod"
	"google.golang.org/grpc v1.25.1/go.mod"
	"google.golang.org/grpc v1.27.0/go.mod"
	"google.golang.org/grpc v1.33.2/go.mod"
	"google.golang.org/grpc v1.64.1"
	"google.golang.org/grpc v1.64.1/go.mod"
	"google.golang.org/protobuf v0.0.0-20200109180630-ec00e32a8dfd/go.mod"
	"google.golang.org/protobuf v0.0.0-20200221191635-4d8936d0db64/go.mod"
	"google.golang.org/protobuf v0.0.0-20200228230310-ab0ca4ff8a60/go.mod"
	"google.golang.org/protobuf v1.20.1-0.20200309200217-e05f789c0967/go.mod"
	"google.golang.org/protobuf v1.21.0/go.mod"
	"google.golang.org/protobuf v1.22.0/go.mod"
	"google.golang.org/protobuf v1.23.0/go.mod"
	"google.golang.org/protobuf v1.23.1-0.20200526195155-81db48ad09cc/go.mod"
	"google.golang.org/protobuf v1.25.0/go.mod"
	"google.golang.org/protobuf v1.34.2"
	"google.golang.org/protobuf v1.34.2/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/check.v1 v1.0.0-20180628173108-788fd7840127/go.mod"
	"gopkg.in/check.v1 v1.0.0-20190902080502-41f04d3bba15/go.mod"
	"gopkg.in/check.v1 v1.0.0-20201130134442-10cb98267c6c"
	"gopkg.in/errgo.v2 v2.1.0/go.mod"
	"gopkg.in/ini.v1 v1.67.0"
	"gopkg.in/ini.v1 v1.67.0/go.mod"
	"gopkg.in/yaml.v2 v2.4.0/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
	"honnef.co/go/tools v0.0.0-20190102054323-c2f93a96b099/go.mod"
	"honnef.co/go/tools v0.0.0-20190523083050-ea95bdfd59fc/go.mod"
)

DESCRIPTION="A backup program that is fast, efficient and secure"
HOMEPAGE="https://restic.github.io/"
SRC_URI="https://github.com/restic/restic/tarball/037c0e4c204cae3e3b748a9835c8dfd5a54d0e2e -> restic-0.17.1-037c0e4.tar.gz
https://distfiles.macaronios.org/ad/49/cf/ad49cf478ebf047629f1090dbbc07ca4122afda8c1c6e7fa24616bc6bcf5ff89f00e1772c8b2846d883e92891e5073bf98b38e3ed377b4d185a689881919213e -> restic-0.17.1-funtoo-go-bundle-dabbce6487c9ea6d9ccb13b297b4273d713b23388571f8bb222155f21674e4df1c9b1dfd084b8f9617f8018fdacf1ec9d2e50108d09f691247f1d94a6bbd1caa.tar.gz"

LICENSE="Apache-2.0 BSD BSD-2 LGPL-3-with-linking-exception MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="sys-fs/fuse:0"
DEPEND="${RDEPEND}"

post_src_unpack() {
	mv ${WORKDIR}/restic-* ${S}
}

src_compile() {
	go build -ldflags '-X main.version=0.17.1' \
		-asmflags "-trimpath=${S}" \
		-gcflags "-trimpath=${S}" \
		-o restic ./cmd/restic
}

src_install() {
	dobin restic

	newbashcomp doc/bash-completion.sh "${PN}"

	insinto /usr/share/zsh/site-functions
	newins doc/zsh-completion.zsh _restic

	insinto /usr/share/fish/vendor_completions.d/
	newins doc/fish-completion.fish "${PN}"

	doman doc/man/*
	dodoc doc/*.rst
}