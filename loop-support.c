#include <stdlib.h>
#include "uv.h"

uv_loop_t* uv_dylan_loop_new(void)
{
  uv_loop_t *loop = malloc(sizeof(uv_loop_t));
  uv_loop_init(loop);
  return loop;
}

void uv_dylan_now(uv_loop_t* loop, unsigned int* low, unsigned int* high)
{
  uint64_t now = (uint64_t)uv_now(loop);
  *low = now;
  *high = now >> 32;
}

