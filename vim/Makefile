CHECKABLE=local
SPEAKERS=global local

include ../Makefile.inc

DEF_PLUGINS= \
	taboo
PLUGINS= \
	vim-sensible \
	vim-fugitive \
	xterm-color-table
G_PLUGINS=

PLUGINS=$(DEF_PLUGINS) $(PLUGINS)
G_PLUGINS=$(DEF_GPLUGINS) $(G_PLUGINS)

PLUGINS_DIR=home/.vim/bundle
G_PLUGINS_DIR=var/lib/vim/addons

.PHONY: first
.PHONY: all global local clean
.PHONY: pathogen $(G_PLUGINS) $(PLUGINS)

first: all

all: global local

global: say.global $(G_PLUGINS)
	@$(INSTALL_F) vimrc.local $(abspath $(SRC_PATH)/etc/vim/vimrc.local)

local: check.local $(PLUGINS)
	@echo taking home/ on a trip...
	@$(INSTALL_TOOL) home $(SRC_PATH)/$(HOME)/
	@$(INSTALL_F) vimrc $(abspath $(SRC_PATH)/$(HOME)/.vimrc)
	@if [ -f home/.vim/autoload/pathogen.vim ]; then \
		echo '"enable pathogen' >> $(SRC_PATH)/$(HOME)/.vimrc; \
		echo 'execute pathogen#infect()' >> $(SRC_PATH)/$(HOME)/.vimrc; \
	 fi

clean:
	@rm -vrf home

pathogen:
	@$(INSTALL_D) home/.vim/bundle
	@if [ ! -f home/.vim/autoload/$@.vim ]; then \
		$(INSTALL_F) $(EXT_PROJ)/vim-$@/autoload/$@.vim home/.vim/autoload/$@.vim; \
	 fi

$(G_PLUGINS):
	@$(INSTALL_TOOL) $(EXT_PROJ)/$@/plugin $(SRC_PATH)/$(G_PLUGINS_DIR)/$@/plugin
	@if [ -d $(EXT_PROJ)/$@/doc ]; then \
		$(INSTALL_TOOL) $(EXT_PROJ)/$@/doc $(SRC_PATH)/$(G_PLUGINS_DIR)/$@/doc; \
		vim -u NONE -c "helptags $(SRC_PATH)/$(G_PLUGINS_DIR)/$@/doc" -c q; \
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
	@echo "preparing $* files in $(notdir $(SRC_PATH))..."

check.local: say.local
	@test ! -d home

