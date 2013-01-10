module: dylan-user
author: Bruce Mitchener, Jr.
copyright: See LICENSE file in this distribution.

define library uv-test-suite
  use common-dylan;
  use io;
  use uv;
  use testworks;

  export uv-test-suite;
end library;

define module uv-test-suite
  use common-dylan, exclude: { format-to-string };
  use format;
  use uv;
  use streams, import: { <buffer> };
  use testworks;

  export uv-test-suite;
end module;
