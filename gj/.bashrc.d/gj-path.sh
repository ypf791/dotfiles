#!/bin/bash
# Add gj's bin to PATH. gj is symlinked into ~/.vim/bundle/gj by install.sh.
# Self-contained: no shared _oo_addpath helper, so no cross-file load ordering.
# Silently skips when gj isn't installed yet (dir absent).
_gj_bin="$HOME/.vim/bundle/gj/bin"
if [ -d "$_gj_bin" ]; then
	case ":${PATH}:" in
		*:"$_gj_bin":*) ;;
		*) export PATH="${PATH}:${_gj_bin}" ;;
	esac
fi
unset _gj_bin
