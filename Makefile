all: build

.PHONY: build test

UNAME := $(shell uname)
ifeq ($(UNAME), Darwin)
  CFLAGS="-arch i386 -arch x86_64"
endif
ifeq ($(UNAME), Linux)
  CFLAGS="-fPIC"
endif

libuv/libuv.a:
	$(MAKE) -C libuv CFLAGS=$(CFLAGS)

build: libuv/libuv.a $(wildcard *.dylan)
	test -d _build/build/uv-dylan || mkdir -p _build/build/uv-dylan
	test -L _build/build/uv-dylan/libuv || ln -s `pwd`/libuv _build/build/uv-dylan
	dylan-compiler -build uv-dylan

test: libuv/libuv.a $(wildcard *.dylan tests/*.dylan)
	dylan-compiler -build uv-dylan-test-suite-app
	./_build/bin/uv-dylan-test-suite-app

clean-uv:
	$(MAKE) -C libuv clean

clean-uv-dylan:
	rm -rf _build/build/uv-dylan
	rm -rf _build/lib/*uv-dylan*
	rm -rf _build/bin/uv*

clean: clean-uv clean-uv-dylan
