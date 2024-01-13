.PHONY: all clean test

dotbot:
	dotbot -c install.conf.yaml

pc-install:
	pre-commit install

pc-run:
	pre-commit run -a

scripts-up:
	wget --output-document mpv/scripts/autoload.lua https://raw.githubusercontent.com/mpv-player/mpv/master/TOOLS/lua/autoload.lua
	wget --output-document mpv/scripts/slicing_copy.lua https://raw.githubusercontent.com/snylonue/mpv_slicing_copy/master/slicing_copy.lua
