module: uv-test-suite
synopsis: Test suite for the uv library.
author: Bruce Mitchener, Jr.
copyright: See LICENSE file in this distribution.

define test uv-idle-test ()
  let idle-ran = 0;
  let i = make(<uv-idle>);
  uv-idle-start(i, method (#rest args)
                     idle-ran := idle-ran + 1;
                     uv-idle-stop(i);
                   end);
  uv-run(run-mode: $UV-RUN-ONCE);
  assert-equal(idle-ran, 1);
end test;

define suite uv-test-suite ()
  test uv-idle-test;
end suite;

