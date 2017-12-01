include Makefile.inc

CHECKABLE=all install revert clean
TARGETS=$(shell ls target.list)

.PHONY: first
.PHONY: all install revert clean
.PHONY: $(addprefix check.,$(CHECKABLE))
.PHONY: targets.pre $(TARGETS)

first: all

targets.pre:
	@echo "find targets: $(TARGETS)"

$(TARGETS): targets.pre
	@echo "======> $@"
	@$(MAKE) -C $@ $(MAKECMDGOALS)
	@echo "<====== $@ complete"

all global local: %: check.% $(TARGETS)
	@echo "<== make $@ complete!!"

install: check.install $(BACKUP_TOOL) $(INSTALL_TOOL)
	@echo "prepare backup.list..."
	@make $(BKP_LIST)
	@echo "invoking backup tool..."
	@$(BACKUP_TOOL) -f $< -o $(BKP_PATH)
	@echo "invoking install tool..."
	@$(INSTALL_TOOL) $(SRC_PATH)
	@echo "making $(INSTALLED_LIST) for revert..."
	@touch $(INSTALLED_LIST)
	@cd $(SRC_PATH); find -type f > ../$(INSTALLED_LIST)
	@echo "<== make $@ complete!!"

revert: check.revert $(REVERT_TOOL) $(INSTALLED_LIST)
	@echo "invoking revert tool..."
	@$(REVERT_TOOL) -f $(INSTALLED_LIST) -- $(BKP_PATH)
	@echo "<== make $@ complete!!"

clean: say.clean $(TARGETS)
	@echo "cleaning..."
	@rm -vrf $(BKP_LIST) $(INSTALLED_LIST) $(SRC_PATH) $(BKP_PATH)
	@echo "<== make $@ complete!!"

$(BKP_LIST).pre:
	@echo "====> $(BKP_LIST)"

$(BKP_LIST): $(BKP_LIST).pre $(MERGE_TOOL) $(TARGETS)
	@echo "gathering backup list..."
	@$(MERGE_TOOL) -o $@ -i `find $(SRC_PATH) -type f` -- $(addsuffix /$(BKP_LIST),$(TARGETS))
	@echo "<==== $(BKP_LIST) complete"

say.%:
	@echo "==> make $*"

check.all check.global check.local: check.%: say.%
	@test ! -d $(SRC_PATH)
	@mkdir -p $(SRC_PATH) $(BKP_PATH)

check.install: say.install
	@test -d $(SRC_PATH)

check.revert: say.revert
	@test -d $(BKP_PATH) -a -f $(INSTALLED_LIST)

