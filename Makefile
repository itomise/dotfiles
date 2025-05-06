.PHONY: install

install:
	@command -v trash > /dev/null || brew install trash
