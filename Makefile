all: build

.PHONY: build test

BUILD_NAME=uv-dylan-posix
UNAME := $(shell uname)
ifeq ($(UNAME), Darwin)
  CFLAGS="-arch i386 -arch x86_64"
  BUILD_NAME=uv-dylan-darwin
endif

libuv/libuv.a:
	$(MAKE) -C libuv CFLAGS=$(CFLAGS)

build: libuv/libuv.a $(wildcard *.dylan)
	test -d _build/build/$(BUILD_NAME) || mkdir -p _build/build/$(BUILD_NAME)
	test -L _build/build/$(BUILD_NAME)/libuv || ln -s `pwd`/libuv _build/build/$(BUILD_NAME)
	dylan-compiler -build $(BUILD_NAME).lid

test: libuv/libuv.a $(wildcard *.dylan tests/*.dylan)
	dylan-compiler -build uv-dylan-test-suite-app
	./_build/bin/uv-dylan-test-suite
