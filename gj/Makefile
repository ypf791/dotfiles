CHECKABLE=
SPEAKERS=

include ../Makefile.inc

.PHONY: first
.PHONY: all global local clean

first: all

all: global local

global:

local: say.local
	@for dir in plugin doc bin; do \
		$(INSTALL_TOOL) $(EXT_PROJ)/gj/$$dir $(SRC_HOME_PATH)/.vim/bundle/gj/$$dir; \
	 done
	@$(INSTALL_F) custom_path.sh $(SRC_HOME_PATH)/.bashrc.d/custom_path.sh

clean:

$(BKP_LIST):
	@touch $@

say.%:
	@echo "preparing $* files..."
