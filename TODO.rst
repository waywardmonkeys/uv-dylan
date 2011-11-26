uv-dylan TODO
=============

* Decide how to handle and map errors from uv back to Dylan.

  * Should these signal conditions or keep the return value
    for the errors?

* Wrap remaining functionality:

  * TCP
  * UDP
  * DNS lookups
  * Process control
  * TTY control
  * Pipes
  * File I/O
  * File System Events

* Think about better / more flexible memory management.

* Look at more Dylan-like API rather than a start / stop function
  per type?

* Provide a directory structure for source, docs to keep things neat.

* Write documentation (using Sphinx).

* Add support for 64 bit integers to C-FFI.

* Make it easy to build this out of the box without dropping symlinks
  or copies of stuff here and there.

* Write tests that demonstrate the usage of the full API. Consider
  borrowing code / ideas from the ``libuv`` tests.

* Get someone using this (like Koala).

