#include <stdlib.h>
#include "uv.h"

uv_tcp_t* uv_dylan_tcp_new(void)
{
  return malloc(sizeof(uv_tcp_t));
}

int uv_dylan_tcp_bind(uv_tcp_t* tcp_stream, const char* bind_ip, int bind_port)
{
  int r = 0;
  int address_type;
  struct sockaddr addr;
    
  if (inet_pton(AF_INET, bind_ip, &addr) == 1) {
    uv_ip4_addr(bind_ip, bind_port, &addr);
  } else if (inet_pton(AF_INET6, bind_ip, &addr) == 1) {
    uv_ip6_addr(bind_ip, bind_port, &addr);
  } else {
    return -1;
  }

  uv_tcp_bind(tcp_stream, &addr, 0);

  return r;
}
