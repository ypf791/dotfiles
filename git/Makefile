CHECKABLE=
SPEAKERS=

include ../Makefile.inc

.PHONY: first
.PHONY: all global local clean

first: all

all: global local

global:

local:
	@$(INSTALL_F) gitconfig.user $(abspath $(SRC_HOME_PATH)/.gitconfig)
	@cat gitconfig.global >> $(SRC_HOME_PATH)/.gitconfig

clean:

$(BKP_LIST):
	@touch $@

say.%:
	@echo "preparing $* files..."
