#!/bin/bash
# Stow symlinks this file into ~/.bashrc.d/; readlink -f resolves it back to the
# real repo, and ../../bin reaches the repo's top-level bin/ (sibling of bash/).
# bin/ is intentionally NOT a stow package, so it's never symlinked into $HOME —
# its tools (gdf, mkscript, traceps) are reached only via this PATH entry.
_oo_bin="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/../../bin" 2>/dev/null && pwd -P)"
if [ -n "$_oo_bin" ]; then
	case ":${PATH}:" in
		*:"$_oo_bin":*) ;;
		# Prepend so these can override system-installed binaries of the same name.
		*) export PATH="$_oo_bin:$PATH" ;;
	esac
fi
unset _oo_bin
