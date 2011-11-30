module: uv-wrapper
author: Bruce Mitchener <bruce.mitchener@gmail.com>
copyright: MIT

define C-subtype <%uv-handle> (<C-void*>) end;

define class <uv-handle> (<object>)
  slot raw-handle :: <%uv-handle>;
  slot close-callback :: <function>;
  slot callback :: <function>;
end;

define C-function %uv-dylan-handle-delete
  parameter handle :: <%uv-handle>;
  c-name: "uv_dylan_handle_delete";
end;

define C-function %uv-is-active
  parameter handle :: <%uv-handle>;
  result active? :: <C-int>;
  c-name: "uv_is_active";
end;

define method uv-is-active(handle :: <uv-handle>) => (active? :: <boolean>)
  %uv-is-active(handle.raw-handle) == 1
end;

define C-function %uv-handle-data
  parameter handle :: <%uv-handle>;
  result data :: <C-dylan-object>;
  c-name: "uv_dylan_handle_data";
end;

define C-function %uv-handle-data-setter
  parameter data :: <C-dylan-object>;
  parameter handle :: <%uv-handle>;
  c-name: "uv_dylan_handle_data_setter";
end;

define method %uv-close-callback
    (handle :: <%uv-handle>) => ()
  let handle-data = %uv-handle-data(handle);
  let wrapper = import-c-dylan-object(handle-data);
  unregister-c-dylan-object(handle-data);
  apply(wrapper.close-callback, #())
end;

define C-callable-wrapper %close-callback of %uv-close-callback
  parameter handle :: <%uv-handle>;
  c-name: "uv_close_callback";
end;

define C-function %uv-close
  parameter handle :: <%uv-handle>;
  parameter callback :: <C-function-pointer>;
  c-name: "uv_close";
end;

define method uv-close
    (handle :: <uv-handle>, callback :: <function>)
 => ()
  handle.close-callback := callback;
  %uv-close(handle.raw-handle, %close-callback);
end;

define method %uv-invoke-callback
    (raw-handle :: <%uv-handle>, #rest args) => ()
  let handle = import-c-dylan-object(%uv-handle-data(raw-handle));
  apply(handle.callback, args)
end;

define C-callable-wrapper %invoke-callback of %uv-invoke-callback
  parameter raw-handle :: <%uv-handle>;
  parameter status :: <C-int>;
  c-name: "uv_invoke_callback";
end;

define method initialize(handle :: <uv-handle>, #key) => ()
  next-method();
  register-c-dylan-object(handle);
  %uv-handle-data(handle.raw-handle) := export-c-dylan-object(handle);
  finalize-when-unreachable(handle);
end;

define method %uv-close-finalize-callback
    (handle :: <%uv-handle>) => ()
  %uv-dylan-handle-delete(handle);
end;

define C-callable-wrapper %close-finalize-callback of %uv-close-finalize-callback
  parameter handle :: <%uv-handle>;
  c-name: "uv_close_finalize_callback";
end;

define method finalize(handle :: <uv-handle>) => ()
  unregister-c-dylan-object(handle);
  %uv-close(handle.raw-handle, %close-finalize-callback);
  next-method();
end;
