module: uv-wrapper
author: Bruce Mitchener <bruce.mitchener@gmail.com>
copyright: MIT

define C-struct <_uv-handle>
  slot loop :: <uv-loop>; //read-only!
  slot handle :: <C-void*>; //read-only!
  slot close-cb :: <C-void*>; //uv_close_cb
  slot data :: <C-dylan-object>;
end;

define C-pointer-type <uv-handle> => <_uv-handle>;

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

