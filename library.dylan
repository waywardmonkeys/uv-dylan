module: dylan-user

define library uv
  use dylan;
  use common-dylan;
  use C-FFI;

  use io; //only for testing purposes

  export uv;
end;

define module uv
  use dylan;
  use dylan-extensions;
  use c-ffi;
  use finalization;

  use format-out; //only for testing purposes
  use streams, import: { force-output }; //only for testing purposes
  use standard-io, import: { *standard-output* }; //only for testing purposes

  export uv-run, uv-stop,
    $UV-RUN-DEFAULT, $UV-RUN-ONCE, $UV-RUN-NOWAIT;

  export <uv-loop>, uv-default-loop,
    uv-ref, uv-unref,
    uv-update-time, uv-now;

  export <uv-handle>, uv-is-active, uv-close;

  export <uv-check>, uv-check-start, uv-check-stop;

  export <uv-idle>, uv-idle-start, uv-idle-stop;

  export <uv-prepare>, uv-prepare-start, uv-prepare-stop;

  export <uv-stream>, uv-read-start, uv-read-stop;

  export <uv-tcp>, uv-listen, uv-accept, uv-tcp-bind;

  export <uv-timer>, uv-timer-start, uv-timer-stop,
    uv-timer-again;

end;

