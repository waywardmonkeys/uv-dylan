#include <stdlib.h>
#include <libuv/include/uv.h>

uv_check_t* uv_dylan_check_new(void)
{
  return malloc(sizeof(uv_check_t));
}

void uv_dylan_check_delete(uv_check_t* check)
{
  free(check);
}

