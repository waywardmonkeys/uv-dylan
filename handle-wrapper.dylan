module: uv-wrapper
author: Bruce Mitchener <bruce.mitchener@gmail.com>
copyright: MIT

define C-subtype <uv-handle> (<C-void*>) end;

define C-function uv-is-active
  parameter handle :: <uv-handle>;
  result active? :: <C-int>;
  c-name: "uv_is_active";
end;

define C-function %uv-handle-data
  parameter handle :: <uv-handle>;
  result data :: <C-dylan-object>;
  c-name: "uv_dylan_handle_data";
end;

define C-function %uv-handle-data-setter
  parameter data :: <C-dylan-object>;
  parameter handle :: <uv-handle>;
  c-name: "uv_dylan_handle_data_setter";
end;

define method uv-close-callback
    (handle :: <uv-handle>) => ()
  let user-data = %uv-handle-data(handle);
  let f = import-c-dylan-object(user-data);
  unregister-c-dylan-object(user-data);
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
  %uv-handle-data(handle) := export-c-dylan-object(callback);
  %uv-close(handle, close-callback)
end;
