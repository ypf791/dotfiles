CHECKABLE=local
SPEAKERS=global local

include ../Makefile.inc

COLORSCHEMES= \
	molokai

PLUGINS= \
	vim-sensible \
	vim-fugitive \
	xterm-color-table \
	NERDTree \
	taboo
PLUGINS_DIR=home/.vim/bundle

.PHONY: first
.PHONY: all global local clean
.PHONY: pathogen $(PLUGINS)

first: all

all: global local

global: say.global
	@$(INSTALL_D) $(SRC_PATH)/etc/vim
	@$(INSTALL_F) vimrc.local $(abspath $(SRC_PATH)/etc/vim/vimrc.local)

local: check.local $(PLUGINS) $(COLORSCHEMES)
	@echo taking home/ on a trip...
	@$(INSTALL_TOOL) home $(SRC_HOME_PATH)/
	@$(INSTALL_F) vimrc $(abspath $(SRC_HOME_PATH)/.vimrc)

clean:
	@rm -vrf home

pathogen:
	@$(INSTALL_D) home/.vim/bundle
	@if [ ! -f home/.vim/autoload/$@.vim ]; then \
		$(INSTALL_D) home/.vim/autoload; \
		$(INSTALL_F) $(EXT_PROJ)/vim-$@/autoload/$@.vim home/.vim/autoload/$@.vim; \
	 fi

$(PLUGINS): pathogen
	@for dir in `ls -d $(EXT_PROJ)/$@/*/`; do \
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

