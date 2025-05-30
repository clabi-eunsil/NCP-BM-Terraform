resource "ncloud_access_control_group" "acg" {
  for_each = var.server_groups
  
  name   = "${var.service_name}-${each.key}-acg"
  vpc_no = ncloud_vpc.vpc.id
}

# 그룹별 ACG 규칙 생성
resource "ncloud_access_control_group_rule" "acg_rule" {
  for_each = {
    for rule_key, rule_data in flatten([
      for group_key, group_data in var.acg_rules : [
        for rule_idx, rule in group_data : {
          key         = "${group_key}-${rule_idx}"
          group_key   = group_key
          rule        = rule
        }
      ]
    ]) : rule_data.key => rule_data
  }

  access_control_group_no = ncloud_access_control_group.acg[each.value.group_key].id
  
  inbound {
    protocol    = each.value.rule.protocol_type
    ip_block    = each.value.rule.ip_block
    port_range  = each.value.rule.port_range
    description = each.value.rule.description
  }
}
