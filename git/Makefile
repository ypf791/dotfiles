include ../Makefile.inc

CHECKABLE=

.PHONY: first
.PHONY: all clean
.PHONY: $(addprefix check.,$(CHECKABLE))

first: all

all:
	@make global
	@make local

global:

local:

clean:

$(BKP_LIST):
	@touch $@

say.%:
	@echo "preparing $* files in $(notdir $(SRC_PATH))..."
