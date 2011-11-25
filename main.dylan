module: uv-wrapper

begin
  let loop = make(<uv-loop>);
  let timer = make(<uv-timer>, loop: loop);
  uv-timer-start(timer, method(#rest fs)
                            format-out("hello %=\n", fs);
                            force-output(*standard-output*);
                        end, 100, 0);
  uv-run(loop);
end;
