au BufRead,BufNewFile *.git/config,gitconfig,.gitconfig set filetype=gitconfig
au BufRead,BufNewFile *.mak,Makefile* set filetype=make
au BufRead,BufNewFile *.tmux set filetype=tmux | compiler tmux

