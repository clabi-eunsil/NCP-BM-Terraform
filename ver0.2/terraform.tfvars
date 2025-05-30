#############################
#          IAM 설정         
#############################
### 공공존 사용시
# site = "gov"
# ncloud_access_key = ""
# ncloud_secret_key = ""
### 민간존 사용시
site              = "pub"
ncloud_access_key = ""
ncloud_secret_key = ""

#############################
#      서비스 이름 설정          
#############################
service_name = "tf-test"

#############################
#     VPC 및 Subnet 설정     
#############################
vpc_cidr            = "10.0.0.0/16"

pub_dmz_subnet_cidr = "10.0.1.0/24"
pub_lb_subnet_cidr  = "10.0.5.0/24"
pub_nat_subnet_cidr = "10.0.6.0/24"
pri_svc_subnet_cidr = "10.0.11.0/24"
pri_lb_subnet_cidr  = "10.0.15.0/24"
pri_db_subnet_cidr  = "10.0.21.0/24"

#############################
#     Server Group 설정
#############################
server_groups = {
  "web" = {
    count               = 0
    image_filter        = "centos-7.8-64"
    cpu_count           = 8
    raid_type_name      = "1"
    subnet_type         = "pub_dmz"
  },
  "was" = {
    count               = 1
    image_filter        = "ubuntu-22.04"
    cpu_count           = 8
    raid_type_name      = "1"
    subnet_type         = "pri_svc"
  },
  "db" = {
    count               = 0
    image_filter        = "centos-7.8-64"
    cpu_count           = 8
    raid_type_name      = "1"
    subnet_type         = "pri_db"
  }
}


#############################
#          ACG 설정
#############################
acg_rules = {
  "web" = [
    {
      protocol_type = "TCP"
      ip_block     = "0.0.0.0/0"
      port_range   = "80"
      description  = "HTTP"
    },
    {
      protocol_type = "TCP"
      ip_block     = "0.0.0.0/0"
      port_range   = "443"
      description  = "HTTPS"
    },
    {
      protocol_type = "TCP"
      ip_block     = "1.209.229.248/32"
      port_range   = "22"
      description  = "clabi SSH"
    }
  ],
  "was" = [
    {
      protocol_type = "TCP"
      ip_block     = "10.0.0.0/16"
      port_range   = "8080"
      description  = "Application Port"
    },
    {
      protocol_type = "TCP"
      ip_block     = "10.0.0.0/16"
      port_range   = "22"
      description  = "SSH"
    }
  ],
  "db" = [
    {
      protocol_type = "TCP"
      ip_block     = "10.0.0.0/16"
      port_range   = "3306"
      description  = "MySQL"
    },
    {
      protocol_type = "TCP"
      ip_block     = "10.0.0.0/16"
      port_range   = "22"
      description  = "SSH"
    }
  ]
}