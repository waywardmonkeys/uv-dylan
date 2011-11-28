module: uv-wrapper
author: Bruce Mitchener <bruce.mitchener@gmail.com>
copyright: MIT

define C-subtype <%uv-idle> (<%uv-handle>) end;
define class <uv-idle> (<uv-handle>) end;

define C-function %uv-idle-init
  parameter loop :: <uv-loop>;
  parameter idle :: <%uv-idle>;
  result xxx :: <C-int>;
  c-name: "uv_idle_init";
end;

define C-function %uv-idle-start
  parameter idle :: <%uv-idle>;
  parameter callback :: <C-function-pointer>;
  result xxx :: <C-int>;
  c-name: "uv_idle_start";
end;

define C-function %uv-idle-stop
  parameter idle :: <%uv-idle>;
  result xxx :: <C-int>;
  c-name: "uv_idle_stop";
end;

define method uv-idle-start
    (idle :: <uv-idle>, callback :: <function>)
 => (result :: <integer>)
  idle.callback := callback;
  %uv-idle-start(idle.raw-handle, %invoke-callback)
end;

define method uv-idle-stop(idle :: <uv-idle>) => (_)
  %uv-idle-stop(idle.raw-handle)
end;

define C-function %uv-dylan-idle-new
  result idle :: <%uv-idle>;
  c-name: "uv_dylan_idle_new";
end;

define C-function %uv-dylan-idle-delete
  parameter idle :: <%uv-idle>;
  c-name: "uv_dylan_idle_delete";
end;

define sealed domain make(singleton(<uv-idle>));
define sealed domain initialize(singleton(<uv-idle>));

define sealed method initialize(idle :: <uv-idle>, #key loop = uv-default-loop())
  idle.raw-handle := %uv-dylan-idle-new();
  next-method();
  %uv-idle-init(loop, idle.raw-handle);
end;

define method finalize(idle :: <uv-idle>) => ()
  %uv-idle-stop(idle.raw-handle);
  %uv-dylan-idle-delete(idle.raw-handle);
  next-method();
end method finalize;
