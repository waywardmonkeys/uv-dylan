module: uv-wrapper
author: Bruce Mitchener <bruce.mitchener@gmail.com>
copyright: MIT

define C-subtype <uv-prepare> (<uv-handle>) end;

define C-function uv-prepare-init
  parameter loop :: <uv-loop>;
  parameter prepare :: <uv-prepare>;
  result xxx :: <C-int>;
  c-name: "uv_prepare_init";
end;

define C-function uv-prepare-start
  parameter prepare :: <uv-prepare>;
  parameter callback :: <C-function-pointer>;
  result xxx :: <C-int>;
  c-name: "uv_prepare_start";
end;

define C-function uv-prepare-stop
  parameter prepare :: <uv-prepare>;
  result xxx :: <C-int>;
  c-name: "uv_prepare_stop";
end;

define C-function uv-dylan-prepare-new
  result prepare :: <uv-prepare>;
  c-name: "uv_dylan_prepare_new";
end;

define C-function uv-dylan-prepare-delete
  parameter prepare :: <uv-prepare>;
  c-name: "uv_dylan_prepare_delete";
end;

define sealed domain make(singleton(<uv-prepare>));

define sealed method make(class == <uv-prepare>, #rest args,
  #key address, loop = uv-default-loop(), #all-keys)
 => (prepare :: <uv-prepare>)
  if (address)
    next-method();
  else
    let prepare = uv-dylan-prepare-new();
    uv-prepare-init(loop, prepare);
    finalize-when-unreachable(prepare);
    prepare
  end;
end method make;

define method finalize(prepare :: <uv-prepare>) => ()
  uv-prepare-stop(prepare);
  uv-dylan-prepare-delete(prepare);
end method finalize;
