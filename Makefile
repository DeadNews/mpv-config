.PHONY: all clean test

dotbot:
	dotbot -c install.conf.yaml

pc-install:
	pre-commit install

pc-run:
	pre-commit run -a

autoload-up:
	wget --output-document mpv/scripts/autoload.lua https://raw.githubusercontent.com/mpv-player/mpv/master/TOOLS/lua/autoload.lua
