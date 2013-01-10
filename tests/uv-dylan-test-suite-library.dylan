module: dylan-user
author: Bruce Mitchener, Jr.
copyright: See LICENSE file in this distribution.

define library uv-dylan-test-suite
  use common-dylan;
  use io;
  use uv-dylan;
  use testworks;

  export uv-dylan-test-suite;
end library;

define module uv-dylan-test-suite
  use common-dylan, exclude: { format-to-string };
  use format;
  use uv-dylan;
  use streams, import: { <buffer> };
  use testworks;

  export uv-dylan-test-suite;
end module;
