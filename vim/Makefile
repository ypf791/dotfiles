CHECKABLE=local
SPEAKERS=global local

include ../Makefile.inc

PLUGINS= \
	vim-sensible \
	vim-fugitive \
	xterm-color-table \
	taboo
PLUGINS_DIR=home/.vim/bundle

.PHONY: first
.PHONY: all global local clean
.PHONY: pathogen $(PLUGINS)

first: all

all: global local

global: say.global
	@$(INSTALL_F) vimrc.local $(abspath $(SRC_PATH)/etc/vim/vimrc.local)

local: check.local $(PLUGINS)
	@echo taking home/ on a trip...
	@$(INSTALL_TOOL) home $(SRC_HOME_PATH)/
	@$(INSTALL_F) vimrc $(abspath $(SRC_HOME_PATH)/.vimrc)
	@if [ -f home/.vim/autoload/pathogen.vim ]; then \
		echo '"enable pathogen' >> $(SRC_HOME_PATH)/.vimrc; \
		echo 'execute pathogen#infect()' >> $(SRC_HOME_PATH)/.vimrc; \
	 fi

clean:
	@rm -vrf home

pathogen:
	@$(INSTALL_D) home/.vim/bundle
	@if [ ! -f home/.vim/autoload/$@.vim ]; then \
		$(INSTALL_F) $(EXT_PROJ)/vim-$@/autoload/$@.vim home/.vim/autoload/$@.vim; \
	 fi

$(PLUGINS): pathogen
	@$(INSTALL_TOOL) $(EXT_PROJ)/$@/plugin $(PLUGINS_DIR)/$@/plugin
	@if [ -d $(EXT_PROJ)/$@/doc ]; then \
		$(INSTALL_TOOL) $(EXT_PROJ)/$@/doc $(PLUGINS_DIR)/$@/doc; \
		vim -u NONE -c "helptags $(PLUGINS_DIR)/$@/doc" -c q; \
	 fi

$(BKP_LIST):
	@touch $@

say.%:
	@echo "preparing $* files..."

check.local: say.local
	@test ! -d home

