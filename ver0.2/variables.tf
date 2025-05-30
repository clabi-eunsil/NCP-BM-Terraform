##############################
#      default setting       #
##############################

variable "ncloud_access_key" {
  description = "Naver Cloud Platform Access Key"
  type        = string
  #sensitive   = true  # 민감 정보로 표시
}

variable "ncloud_secret_key" {
  description = "Naver Cloud Platform Secret Key"
  type        = string
  #sensitive   = true  # 민감 정보로 표시
}

variable "region" {
  description = "Region to deploy resources in Ncloud"
  type        = string
  default     = "KR" # 기본값을 설정했지만 필요에 따라 변경 가능
}

variable "site" {
  description = "Ncloud Site"
  type        = string
  default     = "pub" # pub | gov | fin
}

variable "zone" {
  description = "Availability zone"
  type        = string
  default     = "KR-1"
}

##############################
#      service setting       #
##############################

variable "service_name" {
  description = "The name of the service for naming the resources"
  type        = string
}

##############################
#      network setting       #
##############################
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}


variable "pub_dmz_subnet_cidr" {
  description = "CIDR block for the public DMZ subnet"
  type        = string
}

variable "pub_lb_subnet_cidr" {
  description = "CIDR block for the public Load Balancer subnet"
  type        = string
}

variable "pub_nat_subnet_cidr" {
  description = "CIDR block for the public NAT subnet"
  type        = string
}

variable "pri_svc_subnet_cidr" {
  description = "CIDR block for the private Service subnet"
  type        = string
}

variable "pri_lb_subnet_cidr" {
  description = "CIDR block for the private Load Balancer subnet"
  type        = string
}

variable "pri_db_subnet_cidr" {
  description = "CIDR block for the private Database subnet"
  type        = string
  default     = null # Optional if a DB subnet is not always needed
}

##############################
#       server setting       #
##############################

variable "server_groups" {
  description = "Server Groups Configuration"
  type = map(object({
    count              = number
    image_filter       = string   # ex: "Ubuntu Server 22.04"
    cpu_count          = number
    raid_type_name     = string
    subnet_type        = string   # pub_dmz | pri_svc | pri_db
  }))
}

##############################
#         acg setting        #
##############################

variable "acg_rules" {
  description = "Access Control Group Rules for each server group"
  type = map(list(object({
    protocol_type   = string
    ip_block       = string
    port_range     = string
    # rule_action    = string
    # priority       = number
    description    = string
  })))
}

