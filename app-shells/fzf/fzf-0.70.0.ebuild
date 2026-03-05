# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit bash-completion-r1 go-module

DESCRIPTION="A command-line fuzzy finder"
HOMEPAGE="https://junegunn.github.io/fzf/"
SRC_URI="
https://api.github.com/repos/junegunn/fzf/tarball/v0.70.0 -> fzf-0.70.0-eacef5e.tar.gz
mirror://macaroni/fzf-0.70.0-mark-go-bundle-eacef5e.tar.xz -> fzf-0.70.0-mark-go-bundle-eacef5e.tar.xz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
BDEPEND="dev-lang/go
"

post_src_unpack() {
	mv junegunn-fzf-* ${S}
}


src_compile() {
	emake PREFIX=${EPREFIX}/usr FZF_VERSION=${PV} FZF_REVISION=tarball bin/fzf
}
src_install() {
	dobin bin/fzf
	doman man/man1/fzf.1
	dobin bin/fzf-tmux
	doman man/man1/fzf-tmux.1
	insinto /usr/share/vim/vimfiles/plugin
	doins plugin/fzf.vim
	insinto /usr/share/nvim/runtime/plugin
	doins plugin/fzf.vim
	newbashcomp shell/completion.bash fzf || die
	insinto /usr/share/zsh/site-functions
	newins shell/completion.zsh _fzf
	insinto /usr/share/fzf
	doins shell/key-bindings.bash
	doins shell/key-bindings.fish
	doins shell/key-bindings.zsh
}
pkg_postinst() {
	if [[ -z "${REPLACING_VERSIONS}" ]]; then
	  elog "To add fzf support to your shell, make sure to use the right file"
	  elog "from /usr/share/fzf."
	  elog
	  elog "For bash, add the following line to ~/.bashrc:"
	  elog
	  elog "	# source /usr/share/fzf/key-bindings.bash"
	  elog
	  elog "Or create a symlink:"
	  elog
	  elog "	# ln -s /usr/share/fzf/key-bindings.bash /etc/bash/bashrc.d/fzf.bash"
	  elog
	  elog "Plugins for Vim and Neovim are installed to respective directories"
	  elog "and will work out of the box."
	  elog
	  elog "For fzf support in tmux see fzf-tmux(1)."
	fi
}



# vim: filetype=ebuild
