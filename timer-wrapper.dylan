module: uv
author: Bruce Mitchener <bruce.mitchener@gmail.com>
copyright: MIT

define C-subtype <%uv-timer> (<%uv-handle>) end;

define class <uv-timer> (<uv-handle>) end;

define C-function %uv-timer-init
  parameter loop :: <uv-loop>;
  parameter timer :: <%uv-timer>;
  result xxx :: <C-int>;
  c-name: "uv_timer_init";
end;

define C-function %uv-timer-start
  parameter timer :: <%uv-timer>;
  parameter callback :: <C-function-pointer>;
  parameter timeout :: <C-int>; // XXX: This should be a 64 bit value
  parameter repeat :: <C-int>; // XXX: This should be a 64 bit value
  result xxx :: <C-int>;
  c-name: "uv_dylan_timer_start";
end;

define method uv-timer-start
    (timer :: <uv-timer>, callback :: <function>, timeout :: <integer>, repeat :: <integer>)
 => (result :: <integer>)
  timer.callback := callback;
  %uv-timer-start(timer.raw-handle, %invoke-callback, timeout, repeat)
end;

define C-function %uv-timer-stop
  parameter timer :: <%uv-timer>;
  result xxx :: <C-int>;
  c-name: "uv_timer_stop";
end;

define method uv-timer-stop (timer :: <uv-timer>) => (_)
  %uv-timer-stop(timer.raw-handle)
end;

define C-function %uv-timer-again
  parameter timer :: <%uv-timer>;
  result xxx :: <C-int>;
  c-name: "uv_timer_again";
end;

define method uv-timer-again (timer :: <uv-timer>) => (_)
  %uv-timer-again(timer.raw-handle)
end;

// XXX: hook up something for uv_timer_set_repeat and uv_timer_get_repeat

define C-function %uv-dylan-timer-new
  result timer :: <%uv-timer>;
  c-name: "uv_dylan_timer_new";
end;

define sealed domain make (singleton(<uv-timer>));
define sealed domain initialize (singleton(<uv-timer>));

define sealed method initialize (timer :: <uv-timer>, #key loop = uv-default-loop())
  timer.raw-handle := %uv-dylan-timer-new();
  next-method();
  %uv-timer-init(loop, timer.raw-handle);
end;
