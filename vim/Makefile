CHECKABLE=local
SPEAKERS=global local

include ../Makefile.inc

PLUGINS= \
	vim-sensible \
	vim-fugitive \
	vim-tmux \
	xterm-color-table \
	NERDTree \
	taboo \
	tagbar \
	molokai
PLUGINS_DIR=home/.vim/bundle

.PHONY: first
.PHONY: all global local clean
.PHONY: vim-pathogen $(PLUGINS)

first: all

all: global local

global: say.global
	@$(INSTALL_D) $(SRC_PATH)/etc/vim
	@$(INSTALL_F) vimrc.local $(abspath $(SRC_PATH)/etc/vim/vimrc.local)

local: check.local $(PLUGINS)
	@$(INSTALL_TOOL) ftdetect home/.vim/ftdetect/
	@echo taking home/ on a trip...
	@$(INSTALL_TOOL) home $(SRC_HOME_PATH)/
	@$(INSTALL_F) vimrc $(abspath $(SRC_HOME_PATH)/.vimrc)

clean:
	@rm -vrf home

vim-pathogen:
	@for dir in `ls -d $(EXT_PROJ)/$@/*/`; do \
		$(INSTALL_TOOL) $${dir} home/.vim/`basename $${dir}`; \
	 done

$(PLUGINS): vim-pathogen
	@for dir in `ls -d $(EXT_PROJ)/$@/*/`; do \
		$(INSTALL_TOOL) $${dir} $(PLUGINS_DIR)/$@/`basename $${dir}`; \
	 done
	@if [ -d $(PLUGINS_DIR)/$@/doc ]; then \
		vim -u NONE -c "helptags $(PLUGINS_DIR)/$@/doc" -c q; \
	 fi

$(BKP_LIST):
	@touch $@

say.%:
	@echo "preparing $* files..."

check.local: say.local
	@test ! -d home

