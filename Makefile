SHELL=/bin/bash
.SHELLFLAGS := -eu -o pipefail -c
.ONESHELL:
.DELETE_ON_ERROR:
.SECONDARY:

MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --silent

CONFIG_HOME := $(HOME)/.config
CACHE_HOME  := $(HOME)/.cache
DATA_HOME   := $(HOME)/.local/share
STATE_HOME  := $(HOME)/.local/state
BIN_HOME    := $(HOME)/.local/bin


FROM     := $(CURDIR)
APPNAME  := nvim
APP_CONFIG    := $(CONFIG_HOME)/$(APPNAME)
APP_DATA      := $(DATA_HOME)/$(APPNAME)
APP_STATE     := $(STATE_HOME)/$(APPNAME)
APP_CACHE     := $(CACHE_HOME)/$(APPNAME)

ROCKS_SERVER := https://nvim-neorocks.github.io/rocks-binaries/
ROCKS_TREE   := $(APP_DATA)/rocks

rwildcard = $(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))

#########
## LISTS
#########

nvimList  := $(call rwildcard,$(FROM),*.lua)
nvimBuild := $(patsubst $(FROM)/%,$(APP_CONFIG)/%,$(nvimList))

default: toml build

.PHONY: help
help: ## show this help
	echo 'Note: build based on APPNAME: $(APPNAME)'
	echo 'build files: $(nvimBuild) '
	cat $(MAKEFILE_LIST) |
	grep -oP '^[a-zA-Z_-]+:.*?## .*$$' |
	sort |
	awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build:  $(nvimBuild) ## build nvim config base on $(APPNAME)
	if ! luarocks --lua-version=5.1 --tree $(ROCKS_TREE) --server $(ROCKS_SERVER) show rocks.nvim &>/dev/null ; then
	echo " - try to install rocks.nvim"
	luarocks --lua-version=5.1 --tree $(ROCKS_TREE) --server $(ROCKS_SERVER) install rocks.nvim || true
	fi

clean:
	echo '##[ $@ ]##'
	rm -Rfv $(APP_CONFIG)/*

clean-cache:
	rm -Rfv $(APP_CACHE)/* || true

clean-all:
	echo '##[ $@ ]##'
	rm -Rfv $(APP_CONFIG) || true
	rm -Rfv $(APP_DATA) || true
	rm -Rfv $(APP_STATE) || true
	rm -Rfv $(APP_CACHE) || tru


clean-locks:
	rm '$(APP_CONFIG)/rocks/lockfile.lfs' || true
	rm '$(APP_CONFIG)/rocks/.lock*' || true

toml: $(APP_CONFIG)/rocks.toml
$(APP_CONFIG)/rocks.toml: $(FROM)/rocks.toml
	mkdir -p $(dir $@)
	echo  '##[ $< ]##'
	# source_file symbolic_link
	ln -sf $(abspath $<) $(abspath $@)

$(APP_CONFIG)/%.lua: $(FROM)/%.lua
	mkdir -p $(dir $@)
	echo  '##[ $< ]##'
	cp $< $@

check:
	toolbox run --container zie-toolbox luarocks







