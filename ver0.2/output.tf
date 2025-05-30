output "vpc_id" {
  description = "VPC ID"
  value       = ncloud_vpc.vpc.id
}

output "subnet_info" {
  description = "Subnet Information"
  value = {
    pub_dmz     = ncloud_subnet.pub_dmz_subnet.id
    pri_svc     = ncloud_subnet.pri_svc_subnet.id
    pri_db      = ncloud_subnet.pri_db_subnet.id
    pub_nat     = ncloud_subnet.pub_nat_subnet.id
    pub_lb      = ncloud_subnet.pub_lb_subnet.id
    pri_lb      = ncloud_subnet.pri_lb_subnet.id
  }
}

output "server_info" {
  description = "Server Information"
  value = {
    for server_key, server in ncloud_server.servers : server_key => {
      id         = server.id
      name       = server.name
      private_ip = server.private_ip
      #public_ip  = can(ncloud_public_ip.public_ips[server_key]) ? ncloud_public_ip.public_ips[server_key].public_ip : null
    }
  }
}
