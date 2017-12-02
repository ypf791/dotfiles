include ../Makefile.inc

CHECKABLE=local
SPEAKERS=global local
PLUGINS= \
	vim-sensible \
	vim-fugitive \
	xterm-color-table
PLUGINS_DIR=home/.vim/bundle

INSTALL_F=install -v -m 644 -D
INSTALL_D=install -d -m 755 -D

.PHONY: first
.PHONY: all global local clean
.PHONY: $(addprefix say.,$(SPEAKERS))
.PHONY: $(addprefix check.,$(CHECKABLE))
.PHONY: pathogen $(PLUGINS)

first: all

all:
	@make global
	@make local

global: say.global
	@$(INSTALL_F) vimrc.local $(abspath $(SRC_PATH)/etc/vim/vimrc.local)

local: check.local $(PLUGINS)
	@$(INSTALL_D) $(SRC_PATH)/$(HOME)/
	@echo taking home/ on a trip...
	@cd home; tar cf - . | tar xf - -C $(SRC_PATH)/$(HOME)/
	@$(INSTALL_F) vimrc $(abspath $(SRC_PATH)/$(HOME)/.vimrc)
	@if [ -f home/.vim/autoload/pathogen.vim ]; then \
		echo '"enable pathogen' >> $(SRC_PATH)/$(HOME)/.vimrc; \
		echo 'execute pathogen#infect()' >> $(SRC_PATH)/$(HOME)/.vimrc; \
	 fi

clean:
	@rm -vrf home

pathogen:
	@$(INSTALL_D) home/.vim/autoload home/.vim/bundle
	@$(INSTALL_F) $(EXT_PROJ)/vim-$@/autoload/$@.vim home/.vim/autoload/$@.vim

$(PLUGINS): pathogen
	@$(INSTALL_D) $(PLUGINS_DIR)/$@/plugin
	@$(INSTALL_F) $(EXT_PROJ)/$@/plugin/* $(PLUGINS_DIR)/$@/plugin/
	@if [ -d $(EXT_PROJ)/$@/doc ]; then \
		$(INSTALL_D) $(PLUGINS_DIR)/$@/doc; \
		$(INSTALL_F) $(EXT_PROJ)/$@/doc/* $(PLUGINS_DIR)/$@/doc/; \
		vim -u NONE -c "helptags $(PLUGINS_DIR)/$@/doc" -c q; \
	 fi

$(BKP_LIST):
	@touch $@

say.%:
	@echo "preparing $* files in $(notdir $(SRC_PATH))..."

check.local: say.local
	@test ! -d home

