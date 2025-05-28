provider "ncloud" {
  region      = var.region
  site        = var.site
  support_vpc = "true"
  access_key  = var.ncloud_access_key
  secret_key  = var.ncloud_secret_key
}

resource "ncloud_login_key" "key" {
  key_name = var.login_key_name
}

resource "local_file" "ssh_key" {
  filename = "./${ncloud_login_key.key.key_name}.pem"
  content  = ncloud_login_key.key.private_key
}

# VPC 설정
resource "ncloud_vpc" "vpc" {
  name            = "${var.service_name}-vpc"
  ipv4_cidr_block = "10.0.0.0/16"
}

resource "ncloud_subnet" "pub_dmz_subnet" {
  vpc_no         = ncloud_vpc.vpc.id
  subnet         = "10.0.10.0/24"
  zone           = var.zone
  network_acl_no = ncloud_vpc.vpc.default_network_acl_no
  subnet_type    = "PUBLIC"
  name           = "${var.service_name}-pub-dmz-sub"
  usage_type     = "BM"
}


resource "ncloud_server" "bm" {
  name                      = var.service_name
  subnet_no                 = ncloud_subnet.pub_dmz_subnet.id
  server_image_product_code = "SW.VSVR.BM.OS.LNX64.CNTOS.0708"
  server_product_code       = "SVR.VSVR.BM.C008.M128.LOCAL.SSD.B7782.G001"
  login_key_name            = ncloud_login_key.key.key_name
  raid_type_name            = "1"
  zone                      = var.zone
}
resource "ncloud_public_ip" "public_ip" {
  server_instance_no = ncloud_server.bm.id
}