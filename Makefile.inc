MAKE=make

ROOT=/
HOME=$(shell ls -d ~/)

PROJ_ROOT=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))
EXT_PROJ=$(PROJ_ROOT)ext_proj
SRC_PATH=$(PROJ_ROOT)_root
BKP_PATH=$(PROJ_ROOT)_bkp

INSTALL_TOOL=$(PROJ_ROOT)tools/install
REVERT_TOOL=$(PROJ_ROOT)tools/revert
BACKUP_TOOL=$(PROJ_ROOT)tools/backup
MERGE_TOOL=$(PROJ_ROOT)tools/fusion

BKP_LIST=backup.list
INSTALLED_LIST=installed.list
