# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
Inflector-0.11.4
abort_on_panic-2.0.0
adler-1.0.2
aead-0.4.3
aes-0.7.5
aes-gcm-0.9.4
aes-kw-0.1.0
ahash-0.7.6
aho-corasick-0.7.18
alloc-no-stdlib-2.0.3
alloc-stdlib-0.2.1
ansi_term-0.12.1
anyhow-1.0.57
arrayvec-0.7.2
ash-0.34.0+1.2.203
ast_node-0.7.7
async-compression-0.3.12
async-stream-0.3.3
async-stream-impl-0.3.3
async-trait-0.1.53
atty-0.2.14
auto_impl-0.5.0
autocfg-0.1.8
autocfg-1.1.0
base64-0.11.0
base64-0.13.0
base64ct-1.1.1
bencher-0.1.5
better_scoped_tls-0.1.0
bit-set-0.5.2
bit-vec-0.6.3
bitflags-1.3.2
bitflags_serde_shim-0.2.2
block-0.1.6
block-buffer-0.9.0
block-buffer-0.10.2
block-modes-0.8.1
block-padding-0.2.1
brotli-3.3.4
brotli-decompressor-2.3.2
bumpalo-3.9.1
byteorder-1.4.3
bytes-1.1.0
cache_control-0.2.0
cc-1.0.73
cfg-if-1.0.0
cfg_aliases-0.1.1
chrono-0.4.19
cipher-0.3.0
clap-3.1.12
clap_complete-3.1.2
clap_complete_fig-3.1.5
clap_lex-0.1.1
clipboard-win-4.4.1
codespan-reporting-0.11.1
const-oid-0.6.2
convert_case-0.4.0
copyless-0.1.5
core-foundation-0.9.3
core-foundation-sys-0.8.3
core-graphics-types-0.1.1
cpufeatures-0.2.2
crc-2.1.0
crc-catalog-1.1.1
crc32fast-1.3.2
crossbeam-channel-0.5.4
crossbeam-utils-0.8.8
crypto-bigint-0.2.11
crypto-common-0.1.3
crypto-mac-0.11.1
ctor-0.1.22
ctr-0.8.0
cty-0.2.2
d3d12-0.4.1
darling-0.10.2
darling_core-0.10.2
darling_macro-0.10.2
dashmap-5.2.0
data-encoding-2.3.2
data-url-0.1.1
debug_unreachable-0.1.1
deno_ast-0.14.0
deno_doc-0.34.0
deno_graph-0.26.0
deno_lint-0.29.0
deno_task_shell-0.2.1
der-0.4.5
derive_more-0.99.17
diff-0.1.12
digest-0.9.0
digest-0.10.3
dissimilar-1.0.3
dlopen-0.1.8
dlopen_derive-0.1.4
dprint-core-0.56.0
dprint-plugin-json-0.15.2
dprint-plugin-markdown-0.13.2
dprint-plugin-typescript-0.68.2
dprint-swc-ecma-ast-view-0.55.0
dyn-clone-1.0.5
ecdsa-0.12.4
either-1.6.1
elliptic-curve-0.10.6
encoding_rs-0.8.31
endian-type-0.1.2
enum-as-inner-0.3.3
enum-as-inner-0.4.0
enum_kind-0.2.1
env_logger-0.9.0
errno-0.1.8
errno-0.2.8
errno-dragonfly-0.1.2
error-code-2.3.1
eszip-0.19.0
fallible-iterator-0.2.0
fallible-streaming-iterator-0.1.9
fancy-regex-0.9.0
fastrand-1.7.0
fd-lock-3.0.5
ff-0.10.1
filetime-0.2.16
fixedbitset-0.4.1
flaky_test-0.1.0
flate2-1.0.23
fly-accept-encoding-0.2.0-alpha.5
fnv-1.0.7
foreign-types-0.3.2
foreign-types-shared-0.1.1
form_urlencoded-1.0.1
from_variant-0.1.3
fs3-0.5.0
fsevent-sys-4.1.0
fslock-0.1.8
futures-0.3.21
futures-channel-0.3.21
futures-core-0.3.21
futures-executor-0.3.21
futures-io-0.3.21
futures-macro-0.3.21
futures-sink-0.3.21
futures-task-0.3.21
futures-util-0.3.21
fwdansi-1.1.0
fxhash-0.2.1
generic-array-0.14.5
getrandom-0.2.6
ghash-0.4.4
glow-0.11.2
gpu-alloc-0.5.3
gpu-alloc-types-0.2.0
gpu-descriptor-0.2.2
gpu-descriptor-types-0.1.1
group-0.10.0
h2-0.3.12
hashbrown-0.11.2
hashlink-0.7.0
heck-0.3.3
heck-0.4.0
hermit-abi-0.1.19
hexf-parse-0.2.1
hmac-0.11.0
hostname-0.3.1
http-0.2.6
http-body-0.4.4
httparse-1.7.1
httpdate-1.0.2
humantime-2.1.0
hyper-0.14.18
hyper-rustls-0.23.0
ident_case-1.0.1
idna-0.2.3
if_chain-1.0.2
import_map-0.9.0
indexmap-1.8.1
inotify-0.9.6
inotify-sys-0.1.5
inplace_it-0.3.3
instant-0.1.12
io-lifetimes-0.6.1
ipconfig-0.2.2
ipnet-2.5.0
is-macro-0.2.0
itoa-1.0.1
jobserver-0.1.24
js-sys-0.3.57
jsonc-parser-0.19.0
kernel32-sys-0.2.2
khronos-egl-4.1.0
kqueue-1.0.5
kqueue-sys-1.0.3
lazy_static-1.4.0
lexical-6.1.0
lexical-core-0.8.3
lexical-parse-float-0.8.3
lexical-parse-integer-0.8.3
lexical-util-0.8.3
lexical-write-float-0.8.4
lexical-write-integer-0.8.3
libc-0.2.124
libffi-3.0.0
libffi-sys-2.0.0
libloading-0.7.3
libm-0.2.2
libsqlite3-sys-0.24.2
linked-hash-map-0.5.4
linux-raw-sys-0.0.42
lock_api-0.4.7
log-0.4.16
lru-cache-0.1.2
lsp-types-0.93.0
lzzzz-0.8.0
malloc_buf-0.0.6
match_cfg-0.1.0
matches-0.1.9
memchr-2.4.1
memoffset-0.6.5
metal-0.23.1
mime-0.3.16
miniz_oxide-0.5.1
mio-0.8.2
miow-0.3.7
mitata-0.0.6
naga-0.8.5
netif-0.1.3
new_debug_unreachable-1.0.4
nibble_vec-0.1.0
nix-0.23.0
node_resolver-0.1.1
notify-5.0.0-pre.14
ntapi-0.3.7
num-bigint-0.4.3
num-bigint-dig-0.7.0
num-integer-0.1.44
num-iter-0.1.43
num-traits-0.2.14
num_cpus-1.13.1
num_threads-0.1.6
objc-0.2.7
objc_exception-0.1.2
once_cell-1.10.0
opaque-debug-0.3.0
openssl-probe-0.1.5
os_pipe-1.0.1
os_str_bytes-6.0.0
output_vt100-0.1.3
p256-0.9.0
p384-0.8.0
parking_lot-0.11.2
parking_lot-0.12.0
parking_lot_core-0.8.5
parking_lot_core-0.9.2
path-clean-0.1.0
path-dedot-3.0.17
pathdiff-0.2.1
pem-rfc7468-0.2.4
percent-encoding-2.1.0
pest-2.1.3
petgraph-0.6.0
phf-0.10.1
phf_generator-0.10.0
phf_macros-0.10.0
phf_shared-0.10.0
pin-project-1.0.10
pin-project-internal-1.0.10
pin-project-lite-0.2.9
pin-utils-0.1.0
pkcs1-0.2.4
pkcs8-0.7.6
pkg-config-0.3.25
pmutil-0.5.3
polyval-0.5.3
ppv-lite86-0.2.16
precomputed-hash-0.1.1
pretty_assertions-1.2.1
proc-macro-crate-1.1.3
proc-macro-error-1.0.4
proc-macro-error-attr-1.0.4
proc-macro-hack-0.5.19
proc-macro2-0.4.30
proc-macro2-1.0.37
profiling-1.0.5
pty-0.2.2
pulldown-cmark-0.9.1
quick-error-1.2.3
quote-0.6.13
quote-1.0.18
radix_fmt-1.0.0
radix_trie-0.2.1
rand-0.8.5
rand_chacha-0.3.1
rand_core-0.6.3
range-alloc-0.1.2
raw-window-handle-0.4.3
redox_syscall-0.2.13
regex-1.5.5
regex-syntax-0.6.25
relative-path-1.7.0
remove_dir_all-0.5.3
renderdoc-sys-0.7.1
reqwest-0.11.10
resolv-conf-0.7.0
retain_mut-0.1.7
ring-0.16.20
ron-0.7.0
rsa-0.5.0
rusqlite-0.27.0
rustc-hash-1.1.0
rustc_version-0.2.3
rustc_version-0.4.0
rustix-0.34.4
rustls-0.20.4
rustls-native-certs-0.6.2
rustls-pemfile-0.3.0
rustls-pemfile-1.0.0
rustyline-9.1.2
rustyline-derive-0.6.0
ryu-1.0.9
same-file-1.0.6
schannel-0.1.19
scoped-tls-1.0.0
scopeguard-1.1.0
sct-0.7.0
security-framework-2.6.1
security-framework-sys-2.6.1
semver-0.9.0
semver-1.0.7
semver-parser-0.7.0
semver-parser-0.10.2
serde-1.0.136
serde_bytes-0.11.5
serde_derive-1.0.136
serde_json-1.0.79
serde_repr-0.1.7
serde_urlencoded-0.7.1
sha-1-0.9.8
sha-1-0.10.0
sha2-0.9.9
sha2-0.10.2
shell-escape-0.1.5
signal-hook-registry-1.4.0
signature-1.3.2
siphasher-0.3.10
slab-0.4.6
slotmap-1.0.6
smallvec-1.8.0
socket2-0.3.19
socket2-0.4.4
sourcemap-6.0.1
spin-0.5.2
spirv-0.2.0+1.5.4
spki-0.4.1
static_assertions-1.1.0
str-buf-1.0.5
string_cache-0.8.4
string_cache_codegen-0.5.2
string_enum-0.3.1
strsim-0.9.3
strsim-0.10.0
subtle-2.4.1
swc_atoms-0.2.11
swc_bundler-0.133.0
swc_common-0.17.25
swc_ecma_ast-0.75.0
swc_ecma_codegen-0.103.0
swc_ecma_codegen_macros-0.7.0
swc_ecma_dep_graph-0.72.0
swc_ecma_loader-0.29.1
swc_ecma_parser-0.100.2
swc_ecma_transforms-0.142.0
swc_ecma_transforms_base-0.75.0
swc_ecma_transforms_classes-0.63.0
swc_ecma_transforms_macros-0.3.0
swc_ecma_transforms_optimization-0.112.1
swc_ecma_transforms_proposal-0.97.0
swc_ecma_transforms_react-0.104.0
swc_ecma_transforms_typescript-0.107.0
swc_ecma_utils-0.79.1
swc_ecma_visit-0.61.0
swc_ecmascript-0.143.0
swc_eq_ignore_macros-0.1.0
swc_fast_graph-0.5.0
swc_graph_analyzer-0.6.0
swc_macros_common-0.3.4
swc_visit-0.3.0
swc_visit_macros-0.3.1
syn-0.15.44
syn-1.0.91
synstructure-0.12.6
sys-info-0.9.1
tempfile-3.3.0
termcolor-1.1.3
text-size-1.1.0
text_lines-0.4.1
textwrap-0.15.0
thiserror-1.0.30
thiserror-impl-1.0.30
time-0.1.44
time-0.3.9
tinyvec-1.6.0
tinyvec_macros-0.1.0
tokio-1.17.0
tokio-macros-1.7.0
tokio-rustls-0.23.3
tokio-stream-0.1.8
tokio-tungstenite-0.16.1
tokio-util-0.6.9
tokio-util-0.7.1
toml-0.5.9
tower-0.4.12
tower-layer-0.3.1
tower-lsp-0.17.0
tower-lsp-macros-0.6.0
tower-service-0.3.1
tracing-0.1.34
tracing-attributes-0.1.21
tracing-core-0.1.26
trust-dns-client-0.21.2
trust-dns-proto-0.20.3
trust-dns-proto-0.21.2
trust-dns-resolver-0.20.3
trust-dns-server-0.21.2
try-lock-0.2.3
tungstenite-0.16.0
twox-hash-1.6.2
typed-arena-2.0.1
typenum-1.15.0
ucd-trie-0.1.3
unic-char-property-0.9.0
unic-char-range-0.9.0
unic-common-0.9.0
unic-ucd-ident-0.9.0
unic-ucd-version-0.9.0
unicase-2.6.0
unicode-bidi-0.3.8
unicode-id-0.3.2
unicode-normalization-0.1.19
unicode-segmentation-1.9.0
unicode-width-0.1.9
unicode-xid-0.1.0
unicode-xid-0.2.2
universal-hash-0.4.1
unreachable-0.1.1
untrusted-0.7.1
url-2.2.2
urlpattern-0.1.6
utf-8-0.7.6
utf8parse-0.2.0
uuid-1.0.0
v8-0.42.0
vcpkg-0.2.15
version_check-0.9.4
void-1.0.2
walkdir-2.3.2
want-0.3.0
wasi-0.10.0+wasi-snapshot-preview1
wasi-0.11.0+wasi-snapshot-preview1
wasm-bindgen-0.2.80
wasm-bindgen-backend-0.2.80
wasm-bindgen-futures-0.4.30
wasm-bindgen-macro-0.2.80
wasm-bindgen-macro-support-0.2.80
wasm-bindgen-shared-0.2.80
web-sys-0.3.57
webpki-0.22.0
webpki-roots-0.22.3
wgpu-core-0.12.2
wgpu-hal-0.12.5
wgpu-types-0.12.0
which-4.2.5
widestring-0.4.3
winapi-0.2.8
winapi-0.3.9
winapi-build-0.1.1
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.5
winapi-x86_64-pc-windows-gnu-0.4.0
windows-sys-0.30.0
windows-sys-0.34.0
windows_aarch64_msvc-0.30.0
windows_aarch64_msvc-0.34.0
windows_i686_gnu-0.30.0
windows_i686_gnu-0.34.0
windows_i686_msvc-0.30.0
windows_i686_msvc-0.34.0
windows_x86_64_gnu-0.30.0
windows_x86_64_gnu-0.34.0
windows_x86_64_msvc-0.30.0
windows_x86_64_msvc-0.34.0
winreg-0.6.2
winreg-0.10.1
winres-0.1.12
zeroize-1.4.3
zeroize_derive-1.3.2
zstd-0.11.1+zstd.1.5.2
zstd-safe-5.0.1+zstd.1.5.2
zstd-sys-2.0.1+zstd.1.5.2
"

inherit cargo

DESCRIPTION="Deno is a simple, modern and secure runtime for JavaScript and TypeScript"
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://api.github.com/repos/denoland/deno/tarball/v1.21.3 -> deno-1.21.3.tar.gz
	$(cargo_crate_uris ${CRATES})"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

BDEPEND="
	sys-devel/llvm:*
	sys-devel/clang:*
	sys-devel/lld:*
	dev-util/gn
"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/denoland-deno-* ${S} || die
}

src_compile() {
	# Don't try to fetch prebuilt V8, build it instead
	export V8_FROM_SOURCE=1

	# Resolves to /usr/lib64/llvm/<version>
	export CLANG_BASE_PATH="$(readlink -f -- "$(dirname -- $(clang --print-prog-name=clang))/..")"

	cargo_src_compile
}

src_install() {
	# Install the binary directly, cargo install doesn't work on workspaces
	dobin target/release/deno

	dodoc -r docs
}