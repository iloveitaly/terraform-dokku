locals {
  ssh_private_key_path = "~/.ssh/brotandgames_automation_id_rsa"
  fqdn                 = "dokku.yourhost.com"
  ssh_host             = "192.168.1.100"
}

module "dokku" {
  source = "../"

  ssh_host             = local.ssh_host
  ssh_user             = "root"
  ssh_private_key_path = local.ssh_private_key_path

  dokku_version  = "0.35.20"
  dokku_hostname = local.fqdn
}

output "dokku_info" {
  description = "Information about the Dokku installation"
  value = {
    hostname = module.dokku.dokku_hostname
    version  = module.dokku.dokku_version
    ssh_host = module.dokku.ssh_host
  }
}
