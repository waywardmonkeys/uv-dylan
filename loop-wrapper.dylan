module: uv
author: Bruce Mitchener <bruce.mitchener@gmail.com>
copyright: MIT

define C-subtype <uv-loop> (<C-void*>) end;

define inline C-function uv-default-loop
  result loop :: <uv-loop>;
  c-name: "uv_default_loop";
end;

define constant <uv-run-mode> = <integer>;
define constant $UV-RUN-DEFAULT = 0;
define constant $UV-RUN-ONCE = 1;
define constant $UV-RUN-NOWAIT = 2;

define inline C-function %uv-run
  parameter loop :: <uv-loop>;
  parameter run-mode :: <C-signed-int>;
  c-name: "uv_run";
end;

define inline function uv-run
    (#key loop :: <uv-loop> = uv-default-loop(),
          run-mode :: <uv-run-mode> = $UV-RUN-DEFAULT)
 => ()
  %uv-run(loop, run-mode);
end;

define inline C-function %uv-stop
  parameter loop :: <uv-loop>;
  c-name: "uv_stop";
end;

define inline function uv-stop (#key loop :: <uv-loop> = uv-default-loop()) => ()
  %uv-stop(loop);
end;

define inline C-function uv-ref
  parameter loop :: <uv-loop>;
  c-name: "uv_ref";
end;

define inline C-function uv-unref
  parameter loop :: <uv-loop>;
  c-name: "uv_unref";
end;

define inline C-function %uv-update-time
  parameter loop :: <uv-loop>;
  c-name: "uv_update_time";
end;

define inline function uv-update-time (#key loop :: <uv-loop> = uv-default-loop()) => ()
  %uv-update-time(loop);
end;

define inline C-function %uv-now
  parameter loop :: <uv-loop>;
  output parameter low :: <C-unsigned-int*>;
  output parameter high :: <C-unsigned-int*>;
  c-name: "uv_dylan_now";
end;

define inline function uv-now (#key loop :: <uv-loop> = uv-default-loop()) => (_ :: <double-integer>)
  let (low, high) = %uv-now(loop);
  make(<double-integer>, low: as(<machine-word>, low), high: as(<machine-word>, high))
end;

define inline C-function %uv-dylan-loop-new
  result loop :: <uv-loop>;
  c-name: "uv_dylan_loop_new";
end;

define sealed domain make (singleton(<uv-loop>));

define sealed method make (class == <uv-loop>, #rest args, #key address, #all-keys)
 => (loop :: <uv-loop>)
  if (address)
    next-method();
  else
    let loop = %uv-dylan-loop-new();
    loop
  end;
end method make;
