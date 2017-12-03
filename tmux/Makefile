CHECKABLE=
SPEAKERS=local

include ../Makefile.inc

.PHONY: first
.PHONY: all global local clean

first: all

all: global local

global:

local: say.local
	@$(INSTALL_F) tmux.conf $(abspath $(SRC_HOME_PATH)/.tmux.conf)
	@$(INSTALL_D) $(SRC_HOME_PATH)/.tmux/plugins/tpm
	@$(INSTALL_TOOL) $(EXT_PROJ)/tpm $(SRC_HOME_PATH)/.tmux/plugins/tpm

clean:

$(BKP_LIST):
	@touch $@

say.%:
	@echo "preparing $* files..."
