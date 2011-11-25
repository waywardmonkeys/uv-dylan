#include <stdlib.h>
#include <libuv/include/uv.h>

uv_timer_t* uv_dylan_timer_new(void)
{
  return malloc(sizeof(uv_timer_t));
}

void uv_dylan_timer_delete(uv_timer_t* timer)
{
  free(timer);
}

