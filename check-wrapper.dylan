module: uv-wrapper
author: Bruce Mitchener <bruce.mitchener@gmail.com>
copyright: MIT

define C-subtype <uv-check> (<uv-handle>) end;

define C-function uv-check-init
  parameter loop :: <uv-loop>;
  parameter check :: <uv-check>;
  result xxx :: <C-int>;
  c-name: "uv_check_init";
end;

define C-function uv-check-start
  parameter check :: <uv-check>;
  parameter callback :: <C-function-pointer>;
  result xxx :: <C-int>;
  c-name: "uv_check_start";
end;

define C-function uv-check-stop
  parameter check :: <uv-check>;
  result xxx :: <C-int>;
  c-name: "uv_check_stop";
end;

define C-function uv-dylan-check-new
  result check :: <uv-check>;
  c-name: "uv_dylan_check_new";
end;

define C-function uv-dylan-check-delete
  parameter check :: <uv-check>;
  c-name: "uv_dylan_check_delete";
end;

define sealed domain make(singleton(<uv-check>));

define sealed method make(class == <uv-check>, #rest args,
  #key address, loop = uv-default-loop(), #all-keys)
 => (check :: <uv-check>)
  if (address)
    next-method();
  else
    let check = uv-dylan-check-new();
    uv-check-init(loop, check);
    finalize-when-unreachable(check);
    check
  end;
end method make;

define method finalize(check :: <uv-check>) => ()
  uv-check-stop(check);
  uv-dylan-check-delete(check);
end method finalize;
