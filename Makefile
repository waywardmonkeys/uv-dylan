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
	test -d _build/build/uv || mkdir -p _build/build/uv
	test -L _build/build/uv/libuv || ln -s `pwd`/libuv _build/build/uv
	dylan-compiler -build uv

test: libuv/libuv.a $(wildcard *.dylan tests/*.dylan)
	dylan-compiler -build uv-test-suite-app
	./_build/bin/uv-test-suite-app

clean-uv:
	$(MAKE) -C libuv clean

clean-uv-dylan:
	rm -rf _build/build/uv
	rm -rf _build/lib/*uv*
	rm -rf _build/bin/uv*

clean: clean-uv clean-uv-dylan
