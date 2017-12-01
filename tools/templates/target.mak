include ../Makefile.inc

CHECKABLE=

.PHONY: first
.PHONY: all clean
.PHONY: $(addprefix check.,$(CHECKABLE))

first: all

all: say.all
	@echo "This is the default rule of $(notdir $(SRC_PATH)); override to have your target build correctly"

global:

local:

clean:

$(BKP_LIST):
	@touch $@

say.%:
	@echo "preparing $* files in $(notdir $(SRC_PATH))..."
