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
	wget -O mpv/scripts/autoload.lua https://raw.githubusercontent.com/mpv-player/mpv/master/TOOLS/lua/autoload.lua
	wget -O mpv/scripts/slicing.lua https://raw.githubusercontent.com/snylonue/mpv_slicing_copy/master/slicing_copy.lua

bumped:
	git cliff --bumped-version

# make release-tag_name
# make release-$(git cliff --bumped-version)-alpha.0
release-%: checks
	git cliff -o CHANGELOG.md --tag $*
	pre-commit run --files CHANGELOG.md || pre-commit run --files CHANGELOG.md
	git add CHANGELOG.md
	git commit -m "chore(release): prepare for $*"
	git push
	git tag -a $* -m "chore(release): $*"
	git push origin $*
	git tag --verify $*
