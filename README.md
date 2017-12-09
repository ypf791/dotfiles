# dotfiles

> This project is under Alpha test. Feel free to inform me if there are any issues.

## Installation

1. Starting from a brand new system, use
```bash
cd
wget https://raw.githubusercontent.com/ypf791/dotfiles/master/prepare.sh -O ~/prepare.sh
bash prepare.sh
```
2. To build the targets and deploy them, use
```bash
make
make install
```
3. To clean up for next build, use
```bash
make clean
```
4. To revert the configs before deployment, use
```bash
make revert
```
5. The traversal graph of project build state:
```
  +-------+  make install  +-------+
  | _root | -------------> | _root |
  |       | <------------- | _bkp  |
  +-------+  make revert   +-------+
     ^|                       |
make || --- make              |
     |v       clean           |
   +----+          \          |
   |    | <-------------------+
   +----+
```

## For Development

### Overview

To create a new target for installation, 
run `tools/mktarget <name>` to create a target folder. 
Put your setting files in the folder and modify the Makefile if needed.

The framework requires that any target deploys necessary files under `_root` after running `make` or `make all`, 
as well as guarantees existence of `<target>/backup.list` for reverting after running `make backup.list`. 

The default `make install` puts all files under `_root` to `/`, 
and backup those files in `<target>/backup.list` **AND** those existing in `_root` to `_bkp`. 
On the other hand, the default `make revert` removes all files addressed in `_root`, 
and puts files in `_bkp` back to their original location.

### `global` and `local`

In addition to `make all`, 
one may only want to deploy global settings (under `/`) or local settings (under `~`).
As long as your targets support `make local` or `make global`, 
which are supported by the default targets, 
replacing `make` with `make local` does the trick.

## Credits

This project includes some brilliant projects. Listed below.

`vim`:
* [vim-pathogen](https://github.com/tpope/vim-pathogen)
* [vim-sensible](https://github.com/tpope/vim-sensible)
* [vim-fugitive](https://github.com/tpope/vim-fugitive)
* [xterm-color-table.vim](https://github.com/guns/xterm-color-table.vim)
* [NERDTree] (https://github.com/scrooloose/nerdtree)
* [Taboo](https://github.com/gcmt/taboo.vim)

`tmux`:
* [tpm](https://github.com/tmux-plugins/tpm)
* [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect)
