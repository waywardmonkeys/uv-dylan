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

define C-function %uv-run
  parameter loop :: <uv-loop>;
  c-name: "uv_run";
end;

define method uv-run(#key loop :: <uv-loop> = uv-default-loop()) => ()
  %uv-run(loop);
end method;

define C-function uv-ref
  parameter loop :: <uv-loop>;
  c-name: "uv_ref";
end;

define C-function uv-unref
  parameter loop :: <uv-loop>;
  c-name: "uv_unref";
end;

define C-function %uv-update-time
  parameter loop :: <uv-loop>;
  c-name: "uv_update_time";
end;

define method uv-update-time(#key loop :: <uv-loop> = uv-default-loop()) => ()
  %uv-update-time(loop);
end method;

define C-function %uv-now
  parameter loop :: <uv-loop>;
  output parameter low :: <C-unsigned-int*>;
  output parameter high :: <C-unsigned-int*>;
  c-name: "uv_dylan_now";
end;

define method uv-now(#key loop :: <uv-loop> = uv-default-loop()) => (_ :: <double-integer>)
  let (low, high) = %uv-now(loop);
  make(<double-integer>, low: as(<machine-word>, low), high: as(<machine-word>, high))
end method;

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
