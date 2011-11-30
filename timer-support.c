#include <stdlib.h>
#include <libuv/include/uv.h>

uv_timer_t* uv_dylan_timer_new(void)
{
  return malloc(sizeof(uv_timer_t));
}

int uv_dylan_timer_start(uv_timer_t* timer, uv_timer_cb* cb, int32_t timeout, int32_t repeat)
{
  return uv_timer_start(timer, cb, timeout, repeat);
}
