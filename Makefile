.PHONY: build test install-dependencies

build:
	forge build

test:
	forge t -vvvv --ffi

install-dependencies:
	npm install
