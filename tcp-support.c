#include <stdlib.h>
#include <libuv/include/uv.h>

uv_tcp_t* uv_dylan_tcp_new(void)
{
  return malloc(sizeof(uv_tcp_t));
}

void uv_dylan_tcp_delete(uv_tcp_t* tcp)
{
  free(tcp);
}

int uv_dylan_tcp_bind(uv_tcp_t* tcp_stream, const char* bind_ip, int bind_port)
{
  int r = 0;
  int address_type;
  struct in_addr addr4;
  struct in6_addr addr6;
    
  if (inet_pton(AF_INET, bind_ip, &addr4) == 1) {
    address_type = AF_INET;
  } else if (inet_pton(AF_INET6, bind_ip, &addr6) == 1) {
    address_type = AF_INET6;
  } else {
    return -1;
  }

  if (address_type == AF_INET) {
    r = uv_tcp_bind(tcp_stream, uv_ip4_addr(bind_ip, bind_port));
  } else {
    r = uv_tcp_bind6(tcp_stream, uv_ip6_addr(bind_ip, bind_port));
  }
  return r;
}
