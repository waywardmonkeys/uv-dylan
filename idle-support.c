#include <stdlib.h>
#include "libuv/include/uv.h"

uv_idle_t* uv_dylan_idle_new(void)
{
  return malloc(sizeof(uv_idle_t));
}
