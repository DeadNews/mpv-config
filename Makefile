.PHONY: all clean test default dotbot install checks pc

default: dotbot

dotbot:
	dotbot -c install.conf.yaml

install:
	pre-commit install

checks: pc

pc:
	pre-commit run -a

scripts-up:
	wget -O mpv/scripts/slicing.lua https://raw.githubusercontent.com/snylonue/mpv_slicing_copy/master/slicing_copy.lua
