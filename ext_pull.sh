#!/bin/bash
# Fetch external vim/tmux plugins directly into the homes their tools expect —
# no ext_proj/ staging, no symlinks. Idempotent: skips what's already there.
set -e

vim_bundle="$HOME/.vim/bundle"
mkdir -p "$vim_bundle" "$HOME/.vim/autoload" "$HOME/.vim/colors" "$HOME/.tmux/plugins"

raw="https://raw.githubusercontent.com"

# Single-file fetches — these are NOT bundle plugins:
#   pathogen bootstraps itself, so it must sit in autoload/, not bundle/.
#   molokai is applied by `colorscheme molokai` in .vimrc *before* pathogen#infect,
#   so it must be in colors/ (default runtimepath), not bundle/.
fetch() { [ -f "$2" ] || curl -fLo "$2" "$1"; }
fetch "$raw/tpope/vim-pathogen/master/autoload/pathogen.vim" "$HOME/.vim/autoload/pathogen.vim"
fetch "$raw/tomasr/molokai/master/colors/molokai.vim"        "$HOME/.vim/colors/molokai.vim"

# Whole-repo plugins, cloned where their loader expects them.
# spec: <author>/<repo>[:dir]   (dir overrides the bundle folder name)
clone() {
	local spec=$1 parent=$2 name url
	name=${spec##*/}; name=${name##*:}
	url="https://github.com/${spec%:*}.git"
	if [ -e "$parent/$name" ]; then
		echo "$name already present"
	else
		git clone "$url" "$parent/$name"
	fi
}

# vim plugins -> ~/.vim/bundle/* (pathogen adds each to runtimepath)
for p in \
	tpope/vim-sensible \
	tpope/vim-fugitive \
	guns/xterm-color-table.vim:xterm-color-table \
	scrooloose/nerdtree:NERDTree \
	gcmt/taboo.vim:taboo \
	majutsushi/tagbar \
	tmux-plugins/vim-tmux \
	fcamel/gj \
	cakebaker/scss-syntax.vim \
	ClockworkNet/vim-apparmor \
	chrisbra/vim-diff-enhanced \
	jelera/vim-javascript-syntax \
	posva/vim-vue \
; do
	clone "$p" "$vim_bundle"
done

# tmux plugin manager -> ~/.tmux/plugins/tpm
clone tmux-plugins/tpm "$HOME/.tmux/plugins"
