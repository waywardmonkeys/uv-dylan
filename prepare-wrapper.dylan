module: uv-wrapper
author: Bruce Mitchener <bruce.mitchener@gmail.com>
copyright: MIT

define C-subtype <%uv-prepare> (<%uv-handle>) end;
define class <uv-prepare> (<uv-handle>) end;

define C-function %uv-prepare-init
  parameter loop :: <uv-loop>;
  parameter prepare :: <%uv-prepare>;
  result xxx :: <C-int>;
  c-name: "uv_prepare_init";
end;

define C-function %uv-prepare-start
  parameter prepare :: <%uv-prepare>;
  parameter callback :: <C-function-pointer>;
  result xxx :: <C-int>;
  c-name: "uv_prepare_start";
end;

define C-function %uv-prepare-stop
  parameter prepare :: <%uv-prepare>;
  result xxx :: <C-int>;
  c-name: "uv_prepare_stop";
end;

define method uv-prepare-start
    (prepare :: <uv-prepare>, callback :: <function>)
 => (result :: <integer>)
  prepare.callback := callback;
  %uv-prepare-start(prepare.raw-handle, %invoke-callback)
end;

define method uv-prepare-stop (prepare :: <uv-prepare>) => (_)
  %uv-prepare-stop(prepare.raw-handle)
end;

define C-function %uv-dylan-prepare-new
  result prepare :: <%uv-prepare>;
  c-name: "uv_dylan_prepare_new";
end;

define sealed domain make (singleton(<uv-prepare>));
define sealed domain initialize (singleton(<uv-prepare>));

define sealed method initialize (prepare :: <uv-prepare>, #key loop = uv-default-loop())
  prepare.raw-handle := %uv-dylan-prepare-new();
  next-method();
  %uv-prepare-init(loop, prepare.raw-handle);
end;
