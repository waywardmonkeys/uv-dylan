module: uv-wrapper
author: Bruce Mitchener <bruce.mitchener@gmail.com>
copyright: MIT

define C-subtype <uv-timer> (<uv-handle>) end;

define C-function uv-timer-init
  parameter loop :: <uv-loop>;
  parameter timer :: <uv-timer>;
  result xxx :: <C-int>;
  c-name: "uv_timer_init";
end;

define C-function uv-timer-start
  parameter timer :: <uv-timer>;
  parameter callback :: <C-function-pointer>;
  parameter timeout :: <C-int>; // XXX: This should be a 64 bit value
  parameter repeat :: <C-int>; // XXX: This should be a 64 bit value
  result xxx :: <C-int>;
  c-name: "uv_timer_start";
end;

define C-function uv-timer-stop
  parameter timer :: <uv-timer>;
  result xxx :: <C-int>;
  c-name: "uv_timer_stop";
end;

define C-function uv-timer-again
  parameter timer :: <uv-timer>;
  result xxx :: <C-int>;
  c-name: "uv_timer_again";
end;

// XXX: hook up something for uv_timer_set_repeat and uv_timer_get_repeat

define C-function uv-dylan-timer-new
  result timer :: <uv-timer>;
  c-name: "uv_dylan_timer_new";
end;

define C-function uv-dylan-timer-delete
  parameter timer :: <uv-timer>;
  c-name: "uv_dylan_timer_delete";
end;

define sealed domain make(singleton(<uv-timer>));

define sealed method make(class == <uv-timer>, #rest args,
  #key address, loop = uv-default-loop(), #all-keys)
 => (timer :: <uv-timer>)
  if (address)
    next-method();
  else
    let timer = uv-dylan-timer-new();
    uv-timer-init(loop, timer);
    finalize-when-unreachable(timer);
    timer
  end;
end method make;

define method finalize(timer :: <uv-timer>) => ()
  uv-timer-stop(timer);
  uv-dylan-timer-delete(timer);
end method finalize;