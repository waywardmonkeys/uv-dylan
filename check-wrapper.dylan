module: uv-wrapper
author: Bruce Mitchener <bruce.mitchener@gmail.com>
copyright: MIT

define C-subtype <%uv-check> (<%uv-handle>) end;
define class <uv-check> (<uv-handle>) end;

define C-function %uv-check-init
  parameter loop :: <uv-loop>;
  parameter check :: <%uv-check>;
  result xxx :: <C-int>;
  c-name: "uv_check_init";
end;

define C-function %uv-check-start
  parameter check :: <%uv-check>;
  parameter callback :: <C-function-pointer>;
  result xxx :: <C-int>;
  c-name: "uv_check_start";
end;

define C-function %uv-check-stop
  parameter check :: <%uv-check>;
  result xxx :: <C-int>;
  c-name: "uv_check_stop";
end;

define method uv-check-start
    (check :: <uv-check>, callback :: <function>)
 => (result :: <integer>)
  check.callback := callback;
  %uv-check-start(check.raw-handle, %invoke-callback)
end;

define method uv-check-stop (check :: <uv-check>) => (_)
  %uv-check-stop(check.raw-handle)
end;

define C-function %uv-dylan-check-new
  result check :: <%uv-check>;
  c-name: "uv_dylan_check_new";
end;

define sealed domain make (singleton(<uv-check>));
define sealed domain initialize (singleton(<uv-check>));

define sealed method initialize (check :: <uv-check>, #key loop = uv-default-loop())
  check.raw-handle := %uv-dylan-check-new();
  next-method();
  %uv-check-init(loop, check.raw-handle);
end;
