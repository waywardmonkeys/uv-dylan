module: uv-wrapper
author: Bruce Mitchener <bruce.mitchener@gmail.com>
copyright: MIT

define C-subtype <uv-idle> (<uv-handle>) end;

define C-function uv-idle-init
  parameter loop :: <uv-loop>;
  parameter idle :: <uv-idle>;
  result xxx :: <C-int>;
  c-name: "uv_idle_init";
end;

define C-function uv-idle-start
  parameter idle :: <uv-idle>;
  parameter callback :: <C-function-pointer>;
  result xxx :: <C-int>;
  c-name: "uv_idle_start";
end;

define C-function uv-idle-stop
  parameter idle :: <uv-idle>;
  result xxx :: <C-int>;
  c-name: "uv_idle_stop";
end;

define C-function uv-dylan-idle-new
  result idle :: <uv-idle>;
  c-name: "uv_dylan_idle_new";
end;

define C-function uv-dylan-idle-delete
  parameter idle :: <uv-idle>;
  c-name: "uv_dylan_idle_delete";
end;

define sealed domain make(singleton(<uv-idle>));

define sealed method make(class == <uv-idle>, #rest args,
  #key address, loop = uv-default-loop(), #all-keys)
 => (idle :: <uv-idle>)
  if (address)
    next-method();
  else
    let idle = uv-dylan-idle-new();
    uv-idle-init(loop, idle);
    finalize-when-unreachable(idle);
    idle
  end;
end method make;

define method finalize(idle :: <uv-idle>) => ()
  uv-idle-stop(idle);
  uv-dylan-idle-delete(idle);
end method finalize;
