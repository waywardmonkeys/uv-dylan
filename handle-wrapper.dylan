module: uv-wrapper
author: Bruce Mitchener <bruce.mitchener@gmail.com>
copyright: MIT

define C-subtype <uv-handle> (<C-void*>) end;

define C-function uv-is-active
  parameter handle :: <uv-handle>;
  result active? :: <C-int>;
  c-name: "uv_is_active";
end;

define C-function uv-close
  parameter handle :: <uv-handle>;
  parameter close-cb :: <C-function-pointer>;
  c-name: "uv_close";
end;

