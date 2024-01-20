.PHONY: all clean test

dotbot:
	dotbot -c install.conf.yaml

pc-install:
	pre-commit install

pc-run:
	pre-commit run -a

scripts-up:
	wget -O mpv/scripts/autoload.lua https://raw.githubusercontent.com/mpv-player/mpv/master/TOOLS/lua/autoload.lua
	wget -O mpv/scripts/slicing.lua https://raw.githubusercontent.com/snylonue/mpv_slicing_copy/master/slicing_copy.lua
