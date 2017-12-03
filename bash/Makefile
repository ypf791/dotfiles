CHECKABLE=
SPEAKERS=

include ../Makefile.inc

.PHONY: first
.PHONY: all global local clean

first: all

all:
	@make global
	@make local

global:
	@$(INSTALL_F) bash.bashrc $(abspath $(SRC_PATH)/etc/bash.bashrc)
	@$(INSTALL_TOOL) bin $(SRC_PATH)/usr/local/bin/

local:
	@$(INSTALL_F) home/bashrc $(abspath $(SRC_PATH)/$(HOME)/.bashrc)
	@$(INSTALL_F) home/dircolors $(abspath $(SRC_PATH)/$(HOME)/.dircolors)
	@$(INSTALL_F) home/bash_aliases $(abspath $(SRC_PATH)/$(HOME)/.bash_aliases)
	@if [ -d home/bashrc.d ]; then \
		$(INSTALL_TOOL) home/bashrc.d $(SRC_PATH)/$(HOME)/.bashrc.d; \
	 fi

clean:

$(BKP_LIST):
	@touch $@

say.%:
	@echo "preparing $* files in $(notdir $(SRC_PATH))..."
