include ../Makefile.inc

CHECKABLE=
SPEAKERS=

.PHONY: first
.PHONY: all global local clean
.PHONY: $(addprefix say.,$(SPEAKERS))
.PHONY: $(addprefix check.,$(CHECKABLE))

first: all

all:
	@make global
	@make local

global:
	@$(INSTALL_F) bash.bashrc $(abspath $(SRC_PATH)/etc/bash.bashrc)
	@$(INSTALL_D) $(SRC_PATH)/usr/local/bin
	@cd bin; tar cf - . | tar xf - -C $(SRC_PATH)/usr/local/bin/

local:
	@$(INSTALL_F) home/bashrc $(abspath $(SRC_PATH)/$(HOME)/.bashrc)
	@$(INSTALL_F) home/dircolors $(abspath $(SRC_PATH)/$(HOME)/.dircolors)
	@$(INSTALL_F) home/bash_aliases $(abspath $(SRC_PATH)/$(HOME)/.bash_aliases)
	@$(INSTALL_D) $(SRC_PATH)/$(HOME)/.bashrc.d
	@cd home/bashrc.d; tar cf - . | tar xf - -C $(SRC_PATH)/$(HOME)/.bashrc.d

clean:

$(BKP_LIST):
	@touch $@

say.%:
	@echo "preparing $* files in $(notdir $(SRC_PATH))..."
