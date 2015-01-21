#include <stdlib.h>
#include "uv.h"

uv_check_t* uv_dylan_check_new(void)
{
  return malloc(sizeof(uv_check_t));
}
