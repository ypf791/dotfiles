#!/bin/bash

__ext_projs() {
	# FORMAT: <hostname>/<author>/<project>[:foldername]
	# DESCRIPTION
	# 	<foldername> is the name under ext_proj/
	# 	if not given, use <project>
	cat <<EOF
tpope/vim-pathogen
tpope/vim-sensible
tpope/vim-fugitive
guns/xterm-color-table.vim:xterm-color-table
scrooloose/nerdtree:NERDTree
gcmt/taboo.vim:taboo
tomasr/molokai
tmux-plugins/tpm
tmux-plugins/vim-tmux
fcamel/gj
EOF
}

mkdir -p ext_proj
cd ext_proj
for proj in `__ext_projs`; do
	proj_name=${proj##*/}
	proj_name=${proj_name##*:}
	proj_path=https://github.com/${proj%:*}.git
	if [ -e "$proj_name" ]; then
		echo "$proj_name already exists"
	else
		git clone $proj_path $proj_name
	fi
done

