all: build

.PHONY: build test

BUILD_DIR=uv-dylan-posix
UNAME := $(shell uname)
ifeq ($(UNAME), Darwin)
  CFLAGS="-arch i386 -arch x86_64"
  BUILD_DIR=uv-dylan-darwin
endif

libuv/uv.a:
	$(MAKE) -C libuv CFLAGS=$(CFLAGS)

build: libuv/uv.a $(wildcard *.dylan)
	test -d _build/build/$(BUILD_DIR) || mkdir -p _build/build/$(BUILD_DIR)
	test -L _build/build/$(BUILD_DIR)/libuv || ln -s `pwd`/libuv _build/build/$(BUILD_DIR)
	dylan-compiler -build uv-dylan-darwin.lid

test: libuv/uv.a $(wildcard *.dylan tests/*.dylan)
	dylan-compiler -build uv-dylan-test-suite-app
	./_build/bin/uv-dylan-test-suite
