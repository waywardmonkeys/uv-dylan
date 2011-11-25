uv-dylan
********

This is the start of a Dylan binding for `libuv <https://github.com/joyent/libuv>`_.

To build this, first build the ``libuv`` submodule::

    make -C libuv

On Mac OS X, you'll want to specify the architecture to build for::

    make -C libuv CFLAGS="-arch i386"

For now, you'll have to manually copy a file around so that it can
be found at link time::

    cp libuv/uv.a ~/Open-Dylan/build/uv-dylan/

(Note that that destination directory won't exist until you've already
attempted a build.)

You will also need a hack to let the compiler find the headers for now:

    ln -s `pwd`/libuv /opt/opendylan-2011.1.pre3/include

You can build this library with::

    minimal-console-compiler -build uv-dylan.lid

A lot of work remains to be done here, we're just getting started!
