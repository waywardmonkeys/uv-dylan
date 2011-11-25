module: uv-wrapper

begin
  let loop = make(<uv-loop>);
  let timer = make(<uv-timer>, loop: loop);
  uv-timer-start(timer, null-pointer(<C-function-pointer>), 100, 100);
  uv-run(loop);
end;
