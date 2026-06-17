#!/bin/bash
# Deploy these dotfiles with GNU Stow.
#
# Each top-level dir (bash, git, tmux, vim, gj, zsh) is a Stow package mirroring
# $HOME. Stow won't overwrite existing real files — back up/remove pre-existing
# ~/.bashrc etc. first.
set -e
cd "$(dirname "$0")"

# 1. make runtime dirs REAL first, so stow folds only leaf configs (and the
#    plugins fetched below land in $HOME, not inside the repo).
mkdir -p ~/.vim/bundle ~/.vim/autoload ~/.vim/colors ~/.tmux/plugins

# 2. symlink-farm the config packages into $HOME
stow -t "$HOME" bash git tmux vim gj zsh

# 3. fetch external vim/tmux plugins straight into their runtime homes
./ext_pull.sh

# 4. per-machine git identity (not committed) — set it yourself:
#      git config --global user.name '...' / user.email '...'
#    (touch ~/.gitconfig so --global writes there, not the XDG symlink)
[ -f ~/.gitconfig ] || touch ~/.gitconfig

echo "done. open a new shell; inside tmux press <prefix> + I to install tmux plugins."
