#include <stdlib.h>
#include <libuv/include/uv.h>

void uv_dylan_now(uv_loop_t* loop, unsigned int* low, unsigned int* high)
{
  uint64_t now = (uint64_t)uv_now(loop);
  *low = now;
  *high = now >> 32;
}

