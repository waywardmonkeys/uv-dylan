module: uv-wrapper
author: Bruce Mitchener <bruce.mitchener@gmail.com>
copyright: MIT

define C-subtype <uv-loop> (<C-void*>) end;

define C-function uv-loop-new
  result loop :: <uv-loop>;
  c-name: "uv_loop_new";
end;

define C-function uv-loop-delete
  parameter loop :: <uv-loop>;
  c-name: "uv_loop_delete";
end;

define C-function uv-default-loop
  result loop :: <uv-loop>;
  c-name: "uv_default_loop";
end;

define C-function uv-run
  parameter loop :: <uv-loop>;
  c-name: "uv_run";
end;

