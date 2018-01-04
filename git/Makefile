CHECKABLE=
SPEAKERS=

include ../Makefile.inc

.PHONY: first
.PHONY: all global local clean

first: all

all: global local

global:
	@$(INSTALL_D) $(SRC_PATH)/etc
	@$(INSTALL_F) gitconfig.system $(abspath $(SRC_PATH)/etc/gitconfig)

local:
	@$(INSTALL_F) gitconfig.user $(abspath $(SRC_HOME_PATH)/.gitconfig)
	@cat gitconfig.global >> $(SRC_HOME_PATH)/.gitconfig

clean:

$(BKP_LIST):
	@touch $@

say.%:
	@echo "preparing $* files..."
