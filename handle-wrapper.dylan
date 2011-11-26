module: uv-wrapper
author: Bruce Mitchener <bruce.mitchener@gmail.com>
copyright: MIT

define C-struct <_uv-handle>
  slot loop :: <uv-loop>; //read-only!
  slot handle :: <C-void*>; //read-only!
  slot close-cb :: <C-void*>; //uv_close_cb
  slot data :: <C-dylan-object>;
end;

define C-pointer-type <uv-handle> => <_uv-handle>;

define C-function uv-is-active
  parameter handle :: <uv-handle>;
  result active? :: <C-int>;
  c-name: "uv_is_active";
end;

define method uv-close-callback
    (handle :: <uv-handle>) => ()
  let f = import-c-dylan-object(handle.data);
  unregister-c-dylan-object(handle.data);
  f();
end;

define C-callable-wrapper close-callback of uv-close-callback
  parameter handle :: <uv-handle>;
  c-name: "uv_close_callback";
end;

define C-function %uv-close
  parameter handle :: <uv-handle>;
  parameter callback :: <C-function-pointer>;
  c-name: "uv_close";
end;

define method uv-close
    (handle :: <uv-handle>, callback :: <function>)
 => ()
  register-c-dylan-object(callback);
  handle.data := export-c-dylan-object(callback);
  %uv-close(handle, close-callback)
end;
