ROOT=/
HOME=$(shell ls -d ~/)

.PHONY: $(addprefix say.,$(SPEAKERS))
.PHONY: $(addprefix check.,$(CHECKABLE))

PROJ_ROOT=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))
EXT_PROJ=$(PROJ_ROOT)ext_proj
SRC_PATH=$(PROJ_ROOT)_root
SRC_HOME_PATH=$(PROJ_ROOT)_root$(HOME)
BKP_PATH=$(PROJ_ROOT)_bkp

INSTALL_F=install -v -m 644
INSTALL_D=install -d -m 755

INSTALL_TOOL=$(PROJ_ROOT)tools/install
REVERT_TOOL=$(PROJ_ROOT)tools/revert
BACKUP_TOOL=$(PROJ_ROOT)tools/backup
MERGE_TOOL=$(PROJ_ROOT)tools/fusion

BKP_LIST=backup.list
INS_LIST=installed.list
