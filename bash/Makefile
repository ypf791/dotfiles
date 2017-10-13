include ../Makefile.inc

CHECKABLE=

.PHONY: first
.PHONY: all clean
.PHONY: $(addprefix check.,$(CHECKABLE))

first: all

say:
	@echo "preparing files in $(notdir $(SRC_PATH))..."

all: say
	@echo "This is the default rule of $(notdir $(SRC_PATH)); override to have your target build correctly"

clean:

$(BKP_LIST):
	@touch $@
