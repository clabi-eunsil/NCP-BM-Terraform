# 서브넷 매핑 
# server group의 subnet_type에 따른 subnet 할당
locals{
  all_subnets = {
    "pub_dmz"  = ncloud_subnet.pub_dmz_subnet.id
    "pub_lb"   = ncloud_subnet.pub_lb_subnet.id
    "pri_lb" = ncloud_subnet.pri_lb_subnet.id
    "pri_svc" = ncloud_subnet.pri_svc_subnet.id
    "pri_db"  = ncloud_subnet.pri_db_subnet.id
    "pub_nat"  = ncloud_subnet.pub_nat_subnet.id
  }

   subnet_mapping = {
    for group_key, group_config in var.server_groups : group_key => local.all_subnets[group_config.subnet_type]
  }
}
