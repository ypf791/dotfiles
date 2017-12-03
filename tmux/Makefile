CHECKABLE=
SPEAKERS=local

include ../Makefile.inc

.PHONY: first
.PHONY: all global local clean

first: all

all: global local

global:

local: say.local
	@$(INSTALL_F) tmux.conf $(abspath $(SRC_PATH)/$(HOME)/.tmux.conf)
	@$(INSTALL_D) $(SRC_PATH)/$(HOME)/.tmux/plugin/tpm
	@$(INSTALL_TOOL) $(EXT_PROJ)/tpm $(SRC_PATH)/$(HOME)/.tmux/plugin/tpm

clean:

$(BKP_LIST):
	@touch $@

say.%:
	@echo "preparing $* files in $(notdir $(SRC_PATH))..."
