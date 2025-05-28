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

variable "service_name" {
  description = "The name of the service for naming the resources"
  type        = string
}

variable "login_key_name"{
    type = string
    default = "test-es"
}