#include <stdlib.h>
#include <libuv/include/uv.h>

uv_prepare_t* uv_dylan_prepare_new(void)
{
  return malloc(sizeof(uv_prepare_t));
}

void uv_dylan_prepare_delete(uv_prepare_t* prepare)
{
  free(prepare);
}

