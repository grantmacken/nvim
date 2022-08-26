SHELL := /bin/bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --silent
.DEFAULT_GOAL := config

.PHONY: config
config:
	echo 'TASK: use stow to create symlinks in XDG config dir'
	mkdir -p  ~/.config/nvim
	pushd ../
	stow -v -t ~/.config/nvim nvim
	popd

.PHONY: clean-config
clean-config:
	echo 'TASK : use stow to remove symlinks'
	pushd ../
	stow -D -v -t ~/.config/nvim nvim
	popd
