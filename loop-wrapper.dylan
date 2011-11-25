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

define sealed domain make(singleton(<uv-loop>));

define sealed method make(class == <uv-loop>, #rest args, #key address, #all-keys)
 => (loop :: <uv-loop>)
  if (address)
    next-method();
  else
    let loop = uv-loop-new();
    finalize-when-unreachable(loop);
    loop
  end;
end method make;

define method finalize(loop :: <uv-loop>) => ()
  uv-loop-delete(loop);
end method finalize;
