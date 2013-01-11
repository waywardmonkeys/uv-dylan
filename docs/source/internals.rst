Internals
*********

The ``libuv`` bindings are written using the OpenDylan `C-FFI`_.


Design
======

The bindings have 2 layers in the ``uv-wrapper`` library.

The first is a raw binding around the C API:

.. code-block:: dylan

    define C-subtype <%uv-handle> (<C-void*>) end;

    define C-function %uv-is-active
      parameter handle :: <%uv-handle>;
      result active? :: <C-int>;
      c-name: "uv_is_active";
    end;

We prefix the raw binding with ``%`` to distinguish it from the
API that we want to export.

By using ``C-subtype`` and ``<C-void*>``, we are able to avoid
having to be aware of any of the internal details of the ``libuv``
``struct`` types.

On top of the raw bindings, we then have our own layer:

.. code-block:: dylan

    define class <uv-handle> (<object>)
      slot raw-handle :: <%uv-handle>;
      slot close-callback :: <function>;
      slot callback :: <function>;
    end;

    define method uv-is-active (handle :: <uv-handle>) => (active? :: <boolean>)
      %uv-is-active(handle.raw-handle) == 1
    end;

By having 2 layers, we are able to store additional data in our wrappers
and use the single user data slot provided by ``libuv`` to point to our
wrapper:

.. code-block:: dylan
   :emphasize-lines: 3-4

    define method initialize (handle :: <uv-handle>, #key) => ()
      next-method();
      register-c-dylan-object(handle);
      %uv-handle-data(handle.raw-handle) := export-c-dylan-object(handle);
      finalize-when-unreachable(handle);
    end;

And then we can use them when we're given a raw handle to invoke a callback:

.. code-block:: dylan
   :emphasize-lines: 3-4,6

    define method %uv-close-callback
        (handle :: <%uv-handle>) => ()
      let handle-data = %uv-handle-data(handle);
      let wrapper = import-c-dylan-object(handle-data);
      unregister-c-dylan-object(handle-data);
      apply(wrapper.close-callback, #())
    end;


Finalization and Reference Counting
-----------------------------------

A complete story needs to be worked out for this and then we need to make
sure that it is properly implemented.


Conventions
-----------

* Raw bindings prefix names with ``%``.
* When we add our own C function, we prefix the name with ``uv_dylan`` to
  distinguish it from the ``uv_`` functions.


Future Directions
=================

The ``libuv`` bindings are a work in progress and a lot remains to be
done.


Complete coverage of the ``libuv`` API
--------------------------------------

As of yet, we only cover a small part of the API. This should clearly
be expanded.

There are also parts of the ``libuv`` API that might allow us to simplify
our implementation such as ``uv_handle_size`` and ``uv_req_size``.


Integration with coroutines
---------------------------

While OpenDylan doesn't yet support coroutines, this would be an interesting
and promising direction to move towards.


Move to ``dylan-direct-c-ffi``
------------------------------

Right now, we're using the higher level ``C-FFI`` for all of the bindings.
Much of the raw bindings could probably be done fairly readily with the lower
level ``dylan-direct-c-ffi`` to reduce overhead.

.. _C-FFI: http://opendylan.org/documentation/library-reference/c-ffi/index.html
