module: uv-wrapper

begin
  let loop = make(<uv-loop>);
  let srv = make(<uv-tcp>, loop: loop);
  let listen-cb = method(#rest fs)
      let client = make(<uv-tcp>, loop: loop);
      uv-accept(srv, client);
    end;
  uv-tcp-bind(srv, "0.0.0.0", 1289);
  uv-listen(srv, 8, listen-cb);
  let timer = make(<uv-timer>, loop: loop);
  uv-timer-start(timer, method(#rest fs)
                            format-out("hello %=\n", fs);
                            force-output(*standard-output*);
                        end, 100, 100);
  uv-run(loop: loop);
end;
