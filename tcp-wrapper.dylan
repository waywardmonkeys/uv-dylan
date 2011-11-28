module: uv-wrapper
author: Bruce Mitchener <bruce.mitchener@gmail.com>
copyright: MIT

define C-subtype <%uv-tcp> (<%uv-stream>) end;
define class <uv-tcp> (<uv-stream>)
  slot connection-callback :: <function>;
end;

define C-function %uv-tcp-init
  parameter loop :: <uv-loop>;
  parameter tcp-stream :: <%uv-tcp>;
  result xxx :: <C-int>;
  c-name: "uv_tcp_init";
end;

define C-function %uv-tcp-bind
  parameter tcp-stream :: <%uv-tcp>;
  parameter bind-ip :: <C-string>;
  parameter bind-port :: <C-int>;
  c-name: "uv_dylan_tcp_bind";
end;

define method uv-tcp-bind(tcp-stream :: <uv-tcp>, bind-ip :: <string>, bind-port :: <integer>) => ()
  %uv-tcp-bind(tcp-stream.raw-handle, bind-ip, bind-port);
end method;

define C-function %uv-listen
  parameter server :: <%uv-tcp>;
  parameter backlog :: <C-int>;
  parameter connection-cb :: <C-function-pointer>;
  result xxx :: <C-int>;
  c-name: "uv_listen";
end;

define method %uv-invoke-connection-callback
    (raw-handle :: <%uv-tcp>, #rest args) => ()
  let handle = import-c-dylan-object(%uv-handle-data(raw-handle));
  apply(handle.connection-callback, args)
end;

define C-callable-wrapper %invoke-connection-callback of %uv-invoke-connection-callback
  parameter server :: <%uv-tcp>;
  parameter status :: <C-int>;
  c-name: "uv_invoke_connection_callback";
end;

define method uv-listen(server :: <uv-tcp>, backlog :: <integer>, connection-cb :: <function>) => ()
  server.connection-callback := connection-cb;
  %uv-listen(server.raw-handle, backlog, %invoke-connection-callback);
end method;

define C-function %uv-accept
  parameter server :: <%uv-stream>;
  parameter client :: <%uv-stream>;
  c-name: "uv_accept";
end;

define method uv-accept(server :: <uv-stream>, client :: <uv-stream>) => ()
  %uv-accept(server.raw-handle, client.raw-handle);
end method;

define C-function %uv-dylan-tcp-new
  result tcp-stream :: <%uv-tcp>;
  c-name: "uv_dylan_tcp_new";
end;

define C-function %uv-dylan-tcp-delete
  parameter tcp-stream :: <%uv-tcp>;
  c-name: "uv_dylan_tcp_delete";
end;

define sealed domain make(singleton(<uv-tcp>));
define sealed domain initialize(singleton(<uv-tcp>));

define sealed method initialize(tcp-stream :: <uv-tcp>, #key loop = uv-default-loop())
  tcp-stream.raw-handle := %uv-dylan-tcp-new();
  next-method();
  %uv-tcp-init(loop, tcp-stream.raw-handle);
end;

define method finalize(tcp-stream :: <uv-tcp>) => ()
  %uv-close(tcp-stream.raw-handle);
  %uv-dylan-tcp-delete(tcp-stream.raw-handle);
  next-method();
end method finalize;
