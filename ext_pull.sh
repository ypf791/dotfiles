#!/bin/bash
# Fetch external plugins for the given packages, into their runtime homes.
#   ext_pull.sh vim tmux gj
set -e
raw="https://raw.githubusercontent.com"
fetch() { [ -f "$2" ] || curl -fLo "$2" "$1"; }
clone() {  # <author>/<repo>[:dir]  <parent>
	local spec=$1 parent=$2 name url
	name=${spec##*/}; name=${name##*:}; url="https://github.com/${spec%:*}.git"
	[ -e "$parent/$name" ] && echo "$name already present" || git clone "$url" "$parent/$name"
}
for pkg in "$@"; do case "$pkg" in
	vim)
		mkdir -p "$HOME/.vim/bundle" "$HOME/.vim/autoload" "$HOME/.vim/colors"
		fetch "$raw/tpope/vim-pathogen/master/autoload/pathogen.vim" "$HOME/.vim/autoload/pathogen.vim"
		fetch "$raw/tomasr/molokai/master/colors/molokai.vim"        "$HOME/.vim/colors/molokai.vim"
		for p in tpope/vim-sensible tpope/vim-fugitive \
			guns/xterm-color-table.vim:xterm-color-table scrooloose/nerdtree:NERDTree \
			gcmt/taboo.vim:taboo majutsushi/tagbar tmux-plugins/vim-tmux \
			cakebaker/scss-syntax.vim ClockworkNet/vim-apparmor chrisbra/vim-diff-enhanced \
			jelera/vim-javascript-syntax posva/vim-vue; do clone "$p" "$HOME/.vim/bundle"; done
		;;
	gj)   mkdir -p "$HOME/.vim/bundle";   clone fcamel/gj "$HOME/.vim/bundle" ;;
	tmux) mkdir -p "$HOME/.tmux/plugins"; clone tmux-plugins/tpm "$HOME/.tmux/plugins" ;;
esac; done
