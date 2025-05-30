# group별 server 생성
resource "ncloud_server" "servers" {
  for_each = {
    for server_key, server_data in flatten([
      for group_key, group_data in var.server_groups : [
        for i in range(group_data.count) : {
          key       = "${group_key}-${i + 1}"
          group_key = group_key
          index     = i + 1
        }
      ]
    ]) : server_data.key => server_data
  }

  name                      = "${var.service_name}-${each.value.key}"
  subnet_no                 = local.subnet_mapping[each.value.group_key]
  server_image_product_code = data.ncloud_server_images.server_images[each.value.group_key].server_images[0].product_code
  server_product_code       = data.ncloud_server_products.server_products[each.value.group_key].server_products[0].product_code
  login_key_name            = ncloud_login_key.key.key_name
  raid_type_name            = var.server_groups[each.value.group_key].raid_type_name
  zone                      = var.zone
  
# classic 환경에서만 지원 가능
#   access_control_group_configuration_no_list = [
#     ncloud_access_control_group.acg[each.value.group_key].id
#   ]

#   depends_on = [
#     ncloud_access_control_group_rule.acg_rule
#   ]
}

# # dmz 존의 서버에 공인IP 할당
# resource "ncloud_public_ip" "public_ips" {
#   for_each = {
#     for server_key, server_data in ncloud_server.servers : server_key => server_data
#     if contains(["pub_dmz"], var.server_groups[server_data.group_key].subnet_type)
#   }
  
#   server_instance_no = each.value.id
# }