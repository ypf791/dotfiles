CHECKABLE=
SPEAKERS=

include ../Makefile.inc

.PHONY: first
.PHONY: all global local clean

first: all

all: global local

global: say.global
	@$(INSTALL_D) $(SRC_PATH)/etc
	@$(INSTALL_F) bash.bashrc $(abspath $(SRC_PATH)/etc/bash.bashrc)
	@$(INSTALL_TOOL) bin $(SRC_PATH)/usr/local/bin/

local: say.local
	@$(INSTALL_F) home/profile $(abspath $(SRC_HOME_PATH)/.profile)
	@$(INSTALL_F) home/bashrc $(abspath $(SRC_HOME_PATH)/.bashrc)
	@$(INSTALL_F) home/dircolors $(abspath $(SRC_HOME_PATH)/.dircolors)
	@$(INSTALL_F) home/bash_aliases $(abspath $(SRC_HOME_PATH)/.bash_aliases)
	@if [ -d home/bashrc.d ]; then \
		$(INSTALL_TOOL) home/bashrc.d $(SRC_HOME_PATH)/.bashrc.d; \
	 fi

clean:

$(BKP_LIST):
	@touch $@

say.%:
	@echo "preparing $* files..."
