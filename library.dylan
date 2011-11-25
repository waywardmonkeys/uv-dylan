module: dylan-user

define library uv
  use functional-dylan;
  use C-FFI;

  export uv-wrapper;
end;

define module uv-wrapper
  use dylan;
  use c-ffi;
  use finalization;

  export <uv-loop>, uv-default-loop, uv-run;

  export <uv-handle>, uv-is-active, uv-close;

  export <uv-check>, uv-check-start, uv-check-stop;

  export <uv-idle>, uv-idle-start, uv-idle-stop;

  export <uv-prepare>, uv-prepare-start, uv-prepare-stop;

  export <uv-timer>, uv-timer-start, uv-timer-stop,
    uv-timer-again;

end;

