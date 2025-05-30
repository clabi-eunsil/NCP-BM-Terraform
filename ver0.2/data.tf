# 각 server group별 image 조회
data "ncloud_server_images" "server_images" {
  for_each = var.server_groups
  infra_resource_detail_type_code = "BM"

  filter {
    name   = "product_name"
    values = [each.value.image_filter]
  }
  
  filter {
    name   = "product_type"
    values = ["LINUX"]
  }
}

# 각 server group별 server spec 조회
data "ncloud_server_products" "server_products" {
  for_each = var.server_groups
  
  server_image_product_code = data.ncloud_server_images.server_images[each.key].server_images[0].product_code
  
  filter {
    name   = "cpu_count"
    values = [each.value.cpu_count]
  }
  
  filter {
    name   = "product_type"
    values = ["BM"]
  }
}