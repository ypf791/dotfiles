#!/bin/bash
# Deploy these dotfiles with GNU Stow.
#   ./install.sh            # interactive: pick packages
#   ./install.sh bash vim   # install just these
#   ./install.sh all        # everything
set -e
cd "$(dirname "$0")"
ALL=(bash git tig tmux vim gj zsh)

if [ "$#" -gt 0 ]; then
	[ "$1" = all ] && selected=("${ALL[@]}") || selected=("$@")
else
	selected=()
	for p in "${ALL[@]}"; do read -r -p "install $p? [Y/n] " a; [[ "$a" =~ ^[Nn] ]] || selected+=("$p"); done
fi
for p in "${selected[@]}"; do
	case " ${ALL[*]} " in *" $p "*) ;; *) echo "unknown package: $p (have: ${ALL[*]})" >&2; exit 1 ;; esac
done
[ "${#selected[@]}" -gt 0 ] || { echo "nothing to do"; exit 0; }
want() { case " ${selected[*]} " in *" $1 "*) return 0 ;; *) return 1 ;; esac; }

# detect conflicts -- no changes yet
backup="$HOME/.dotfiles-pre-stow-$(date +%Y%m%d%H%M%S)"
mapfile -t conflicts < <(stow -n -v -t "$HOME" "${selected[@]}" 2>&1 \
	| sed -n 's/^.*existing target is [^:]*: //p' | sort -u)

# show the plan; confirm only if there are pre-existing files to move aside
echo "install: ${selected[*]}"
if [ "${#conflicts[@]}" -gt 0 ]; then
	echo "these existing files conflict and would be moved to $backup:"
	printf '    ~/%s\n' "${conflicts[@]}"
	read -r -p "proceed? [Y/n] " a; [[ "$a" =~ ^[Nn] ]] && { echo "aborted; nothing changed."; exit 0; }
else
	echo "no conflicts."
fi

# agreed: back up conflicts, make runtime dirs, stow
for rel in "${conflicts[@]}"; do
	[ -n "$rel" ] && [ -e "$HOME/$rel" ] || continue
	mkdir -p "$backup/$(dirname "$rel")" && mv "$HOME/$rel" "$backup/$rel"
done
[ -d "$backup" ] && echo "moved pre-existing files to $backup"
want vim  && mkdir -p ~/.vim/bundle ~/.vim/autoload ~/.vim/colors
want gj   && mkdir -p ~/.vim/bundle
want tmux && mkdir -p ~/.tmux/plugins
stow -t "$HOME" "${selected[@]}"

# external plugins, only for selected packages that have them
plugins=(); for p in vim gj tmux; do want "$p" && plugins+=("$p"); done
[ "${#plugins[@]}" -gt 0 ] && ./ext_pull.sh "${plugins[@]}"

echo "done."
want git  && {
	[ -f ~/.gitconfig ] || touch ~/.gitconfig   # so `git config --global` lands here, not the XDG symlink
	echo "  -> set your git identity (kept out of the repo, in ~/.gitconfig):"
	echo "       git config --global user.name  'Your Name'"
	echo "       git config --global user.email 'you@example.com'"
}
want tmux && echo "  -> in tmux: <prefix> + I to install tmux plugins."
echo "  -> open a new shell to pick up the changes."
