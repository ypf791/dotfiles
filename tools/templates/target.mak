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
	@echo "default rule for $@; override to have your target build correctly"

local:
	@echo "default rule fo $@; override to have your target build correctly"

clean:

$(BKP_LIST):
	@touch $@

say.%:
	@echo "preparing $* files in $(notdir $(SRC_PATH))..."
