CHECKABLE=local
SPEAKERS=global local

include ../Makefile.inc

COLORSCHEMES= \
	molokai

PLUGINS= \
	vim-sensible \
	vim-fugitive \
	vim-tmux \
	xterm-color-table \
	NERDTree \
	taboo \
	tagbar \
	scss-syntax.vim \
	vim-apparmor \
	vim-diff-enhanced \
	vim-javascript-syntax \
	vim-vue
PLUGINS_DIR=home/.vim/bundle

.PHONY: first
.PHONY: all global local clean
.PHONY: vim-pathogen $(PLUGINS)

first: all

all: global local

global:

local: check.local $(PLUGINS) $(COLORSCHEMES)
	@$(INSTALL_TOOL) ftdetect home/.vim/ftdetect/
	@echo taking home/ on a trip...
	@$(INSTALL_TOOL) home $(SRC_HOME_PATH)/
	@$(INSTALL_F) vimrc $(abspath $(SRC_HOME_PATH)/.vimrc)

clean:
	@rm -vrf home

vim-pathogen:
	@for dir in $(EXT_PROJ)/$@/*/; do \
		$(INSTALL_TOOL) $${dir} home/.vim/`basename $${dir}`; \
	 done

$(PLUGINS): vim-pathogen
	@for dir in $(EXT_PROJ)/$@/*/; do \
		$(INSTALL_TOOL) $${dir} $(PLUGINS_DIR)/$@/`basename $${dir}`; \
	 done
	@if [ -d $(PLUGINS_DIR)/$@/doc ]; then \
		vim -u NONE -c "helptags $(PLUGINS_DIR)/$@/doc" -c q; \
	 fi

$(COLORSCHEMES):
	@$(INSTALL_TOOL) $(EXT_PROJ)/$@/colors home/.vim/colors

$(BKP_LIST):
	@touch $@

say.%:
	@echo "preparing $* files..."

check.local: say.local
	@test ! -d home

