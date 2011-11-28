module: uv-wrapper
author: Bruce Mitchener <bruce.mitchener@gmail.com>
copyright: MIT

define C-subtype <%uv-stream> (<%uv-handle>) end;
define class <uv-stream> (<uv-handle>)
  slot alloc-callback :: <function>;
  slot read-callback :: <function>;
end;

define C-function %uv-read-start
  parameter stream :: <%uv-stream>;
  parameter alloc-cb :: <C-function-pointer>;
  parameter read-cb :: <C-function-pointer>;
  result xxx :: <C-int>;
  c-name: "uv_read_start";
end;

define method %uv-invoke-alloc-callback
    (raw-handle :: <%uv-handle>, #rest args) => ()
  let handle = import-c-dylan-object(%uv-handle-data(raw-handle));
  apply(handle.alloc-callback, args)
end;

define C-callable-wrapper %invoke-alloc-callback of %uv-invoke-alloc-callback
  parameter raw-handle :: <%uv-handle>;
  parameter suggested-size :: <C-int>;
  // result buffer :: <C-void*>; // XXX: this needs work
  c-name: "uv_invoke_alloc_callback";
end;

define method %uv-invoke-read-callback
    (raw-handle :: <%uv-handle>, #rest args) => ()
  let handle = import-c-dylan-object(%uv-handle-data(raw-handle));
  apply(handle.read-callback, args)
end;

define C-callable-wrapper %invoke-read-callback of %uv-invoke-read-callback
  parameter raw-stream :: <%uv-stream>;
  parameter nread :: <C-int>;
  parameter buffer :: <C-void*>; // XXX: this needs work
  c-name: "uv_invoke_read_callback";
end;

define method uv-read-start(stream :: <uv-stream>, alloc-cb :: <function>, read-cb :: <function>) => (_ :: <integer>)
  stream.alloc-callback := alloc-cb;
  stream.read-callback := read-cb;
  %uv-read-start(stream.raw-handle, %invoke-alloc-callback, %invoke-read-callback)
end method;

define C-function %uv-read-stop
  parameter stream :: <%uv-stream>;
  c-name: "uv_read_stop";
end;

define method uv-read-stop(stream :: <uv-stream>) => ()
  %uv-read-stop(stream.raw-handle);
end method;