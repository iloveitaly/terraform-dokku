output "dokku_hostname" {
  description = "The hostname configured for Dokku"
  value       = var.dokku_hostname
}

output "dokku_version" {
  description = "The version of Dokku installed"
  value       = var.dokku_version
}

output "ssh_host" {
  description = "The SSH host where Dokku is installed"
  value       = var.ssh_host
}

output "installation_id" {
  description = "Unique identifier for this Dokku installation"
  value       = null_resource.install.id
}
