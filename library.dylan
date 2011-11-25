module: dylan-user

define library uv
  use functional-dylan;
  use C-FFI;

  export uv-wrapper;
end;

define module uv-wrapper
  use dylan;
  use c-ffi;

  export <uv-loop>, uv-loop-new, uv-loop-delete,
    uv-default-loop, uv-run;

end;

