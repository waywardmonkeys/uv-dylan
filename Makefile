all: build

.PHONY: build test clean

build: $(wildcard *.dylan *.c *.lid)
	# Force a rebuild to work around dylan-compiler
	# not picking up changes to C files.
	touch library.dylan
	dylan-compiler -build uv

test: $(wildcard *.dylan tests/*.dylan)
	dylan-compiler -build uv-test-suite-app
	./_build/bin/uv-test-suite-app

clean:
	rm -rf _build/build/uv
	rm -rf _build/lib/*uv*
	rm -rf _build/bin/uv*
