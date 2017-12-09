BUILDERS=all global local
CHECKABLE=$(BUILDERS) install revert clean
SPEAKERS=$(CHECKABLE)

include Makefile.inc

TARGETS=$(shell ls target.list)

FIND_ROOT_CMD=cd $(SRC_PATH); find -type f -o -type l | sed 's/^\.//g'

.PHONY: first
.PHONY: $(CHECKABLE)
.PHONY: pre.$(BKP_LIST) pre.targets $(TARGETS)

first: all

pre.targets:
	@echo "first prepare external projects..."
	@./ext_pull.sh
	@echo "find targets: $(TARGETS)"

$(TARGETS): pre.targets
	@echo "======> $@"
	@make -C `readlink -f target.list/$@` $(MAKECMDGOALS)
	@echo "<====== $@ complete"

$(BUILDERS): %: check.% $(TARGETS)
	@echo "<== make $@ complete!!"

install: check.install $(BACKUP_TOOL) $(INSTALL_TOOL)
	@echo "prepare $(BKP_LIST)..."
	@make $(BKP_LIST)
	@echo "invoking backup tool..."
	@$(BACKUP_TOOL) -f $(BKP_LIST) -- $(BKP_PATH)
	@rm -vf $(BKP_LIST)
	@echo "invoking install tool..."
	@$(INSTALL_TOOL) $(SRC_PATH) /
	@echo "<== make $@ complete!!"

revert: check.revert $(REVERT_TOOL)
	@echo "preparing $(INS_LIST)..."
	@make $(INS_LIST)
	@echo "invoking revert tool..."
	@$(REVERT_TOOL) -f $(INS_LIST) -- $(BKP_PATH)
	@rm -vf $(INS_LIST)
	@echo "cleaning backup files..."
	@rm -rf $(BKP_PATH)
	@echo "<== make $@ complete!!"

clean: say.clean $(TARGETS)
	@echo "cleaning..."
	@rm -vrf $(BKP_LIST) $(INS_LIST) $(SRC_PATH) $(BKP_PATH)
	@echo "<== make $@ complete!!"

pre.$(BKP_LIST):
	@echo "====> $(BKP_LIST)"

$(BKP_LIST): pre.$(BKP_LIST) $(MERGE_TOOL) $(TARGETS)
	@echo "gathering backup list..."
	@$(MERGE_TOOL) \
		-o $@ \
		-i "`$(FIND_ROOT_CMD)`" \
		-- $(addsuffix /$(BKP_LIST),$(TARGETS))
	@echo "<==== $(BKP_LIST) complete"

$(INS_LIST): $(SRC_PATH)
	@echo "====> $(INS_LIST)"
	@echo "listing $(SRC_PATH)..."
	@echo "`$(FIND_ROOT_CMD)`" > $(INS_LIST)
	@echo "<==== $(INS_LIST) complete"

$(addprefix say.,$(SPEAKERS)): say.%:
	@echo "==> make $*"

$(addprefix check.,$(CHECKABLE)): check.%: say.%

$(addprefix check.,$(BUILDERS)):
	@test ! -e $(SRC_PATH)
	@$(INSTALL_D) $(SRC_PATH)

check.install:
	@test -d $(SRC_PATH) -a ! -e $(BKP_PATH)
	@$(INSTALL_D) $(BKP_PATH)

check.revert:
	@test -d $(SRC_PATH) -a -d $(BKP_PATH)

