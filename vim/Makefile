include ../Makefile.inc

CHECKABLE=global local
PLUGINS= \
	vim-sensible \
	vim-fugitive \
	xterm-color-table
PLUGINS_DIR=home/.vim/bundle

INSTALL=install -v -m 644 -D

.PHONY: first
.PHONY: all global local clean
.PHONY: $(addprefix check.,$(CHECKABLE))
.PHONY: pathogen $(PLUGINS)

first: all

all:
	@make global
	@make local

global: check.global
	@install -v -m 644 -D vimrc.local $(abspath $(SRC_PATH)/etc/vim/vimrc.local)

local: check.local $(PLUGINS)
	@install -d -m 755 -D $(SRC_PATH)/$(HOME)/
	@echo taking home/ on a trip...
	@cd home; tar cf - . | tar xf - -C $(SRC_PATH)/$(HOME)/
	@install -v -m 644 -D vimrc $(abspath $(SRC_PATH)/$(HOME)/.vimrc)
	@if [ -f home/.vim/autoload/pathogen.vim ]; then \
		echo '"enable pathogen' >> $(SRC_PATH)/$(HOME)/.vimrc; \
		echo 'execute pathogen#infect()' >> $(SRC_PATH)/$(HOME)/.vimrc; \
	 fi

clean:
	@rm -vrf home

pathogen:
	@install -d -m 755 -D home/.vim/autoload home/.vim/bundle
	@$(INSTALL) $(EXT_PROJ)/vim-$@/autoload/$@.vim home/.vim/autoload/$@.vim

$(PLUGINS): pathogen
	@$(INSTALL) -d -m 755 -D $(PLUGINS_DIR)/$@/plugin
	@$(INSTALL) $(EXT_PROJ)/$@/plugin/* $(PLUGINS_DIR)/$@/plugin/
	@if [ -d $(EXT_PROJ)/$@/doc ]; then \
		$(INSTALL) -d -m 755 -D $(PLUGINS_DIR)/$@/doc; \
		$(INSTALL) $(EXT_PROJ)/$@/doc/* $(PLUGINS_DIR)/$@/doc/; \
		vim -u NONE -c "helptags $(PLUGINS_DIR)/$@/doc" -c q; \
	 fi

$(BKP_LIST):
	@touch $@

say.%:
	@echo "preparing $* files in $(notdir $(SRC_PATH))..."

check.global: say.global

check.local: say.local
	@test ! -d home

