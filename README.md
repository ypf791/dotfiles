# dotfiles

Personal dotfiles for Linux and macOS, deployed with [GNU Stow](https://www.gnu.org/software/stow/).

Each top-level directory (`bash`, `git`, `tmux`, `vim`, `gj`, `zsh`) is a **Stow
package** mirroring your home directory. `install.sh` symlinks the packages you
choose into `$HOME`, so editing a file in this repo takes effect immediately.

## Quick start

On a machine that already has `git` and `stow`:

```bash
git clone https://github.com/ypf791/dotfiles ~/dotfiles && cd ~/dotfiles
./install.sh            # interactive — choose packages with y/n
# or:  ./install.sh bash vim     (just these)
#      ./install.sh all          (everything)
```

`install.sh` will:

1. let you choose which packages to install;
2. detect pre-existing real files that would block stow (e.g. a fresh system's
   `~/.bashrc`) and, **after you confirm**, move them to a `~/.dotfiles-pre-stow-*`
   backup;
3. symlink the chosen packages into `$HOME`;
4. fetch each package's external vim/tmux plugins (see [External plugins](#external-plugins)).

## Brand-new machine

`prepare.sh` bootstraps a box that has nothing yet — not even `git`. It installs the
base OS packages (`apt` on Debian/Ubuntu, Homebrew on macOS) — including `git` and
`stow` — offers to set up an SSH key, and clones this repo. Download it and run it:

```bash
curl -fsSLO https://raw.githubusercontent.com/ypf791/dotfiles/master/prepare.sh
bash prepare.sh
```

Then `cd dotfiles && ./install.sh` as in [Quick start](#quick-start).

## What's inside

| Package | What you get |
|---|---|
| **bash** | a comfortable shell — informative prompt, aliases, a `to` directory-jump command, and the [`bin/` tools](#bin-tools) on your `PATH` |
| **git**  | short aliases for everyday commands and nicer log views |
| **tmux** | ergonomic key bindings (`C-a` prefix) and a custom status bar |
| **vim**  | a ready-to-use editor — color scheme, file-tree and tag sidebars, and a few F-key toggles |
| **gj**   | the `gj` code-search command on your `PATH` |
| **zsh**  | a zsh setup with prompt and aliases |

Top-level entries that are **not** stowed: `bin/` (tools, below), `prepare.sh` +
`prepare_pkgs/` (bootstrap), and the helper scripts.

### bin tools

On `PATH` via `bash/.bashrc.d/bin-env.sh`, but never symlinked into `$HOME`:

- **`gdf`** — review all changed (or conflicted) files as side-by-side Vim diffs,
  one per tab. `gdf -n 2` diffs against 2 commits back; merge conflicts open 3-way.
- **`mkscript <name>…`** — scaffold new executable script(s) from a built-in
  `getopt` skeleton.
- **`traceps <binary>`** — wrap a binary so every invocation logs its process tree
  (plus args/timestamp) to a file.

### External plugins

Vim/tmux plugins are **not** committed here. At install time, `ext_pull.sh` clones
each one straight from GitHub into the home its tool expects — `~/.vim/bundle/`,
`~/.tmux/plugins/`, and the two single-file ones into `~/.vim/autoload/` (pathogen)
and `~/.vim/colors/` (molokai). The list lives in `ext_pull.sh`; see
[Acknowledgements](#acknowledgements).

## Development

To add a package: create `<pkg>/` mirroring `$HOME` (files keep their leading dots),
add `<pkg>` to the `ALL` array in `install.sh`, and list any third-party plugins it
needs in `ext_pull.sh`.

Keep this README in step with such changes — the package list, the [What's
inside](#whats-inside) table, and [Acknowledgements](#acknowledgements). `CLAUDE.md`
records the full convention.

## Acknowledgements

All third-party code is fetched at install time, not vendored here.

**vim** — [vim-pathogen](https://github.com/tpope/vim-pathogen),
[molokai](https://github.com/tomasr/molokai),
[vim-sensible](https://github.com/tpope/vim-sensible),
[vim-fugitive](https://github.com/tpope/vim-fugitive),
[xterm-color-table.vim](https://github.com/guns/xterm-color-table.vim),
[NERDTree](https://github.com/scrooloose/nerdtree),
[Taboo](https://github.com/gcmt/taboo.vim),
[Tagbar](https://github.com/majutsushi/tagbar),
[vim-tmux](https://github.com/tmux-plugins/vim-tmux),
[scss-syntax.vim](https://github.com/cakebaker/scss-syntax.vim),
[vim-apparmor](https://github.com/ClockworkNet/vim-apparmor),
[vim-diff-enhanced](https://github.com/chrisbra/vim-diff-enhanced),
[vim-javascript-syntax](https://github.com/jelera/vim-javascript-syntax),
[vim-vue](https://github.com/posva/vim-vue)

**shell + vim** — [gj](https://github.com/fcamel/gj)

**tmux** — [tpm](https://github.com/tmux-plugins/tpm)
