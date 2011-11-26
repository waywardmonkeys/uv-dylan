#include <libuv/include/uv.h>

void* uv_dylan_handle_data(uv_handle_t* handle)
{
  return handle->data;
}

void uv_dylan_handle_data_setter(void* data, uv_handle_t* handle)
{
  handle->data = data;
}
