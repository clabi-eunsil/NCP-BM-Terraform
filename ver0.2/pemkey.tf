resource "ncloud_login_key" "key" {
  key_name = var.service_name
}

resource "local_file" "ssh_key" {
  filename = "./${ncloud_login_key.key.key_name}.pem"
  content  = ncloud_login_key.key.private_key
}
