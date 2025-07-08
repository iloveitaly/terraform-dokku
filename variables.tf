variable "ssh_private_key_path" {
  description = "SSH private key path"
  type        = string
  default     = "~/.ssh/id_rsa"
}

variable "ssh_user" {
  description = "SSH user"
  type        = string
  default     = "root"
}

variable "ssh_host" {
  description = "SSH host"
  type        = string
  default     = "192.168.0.100"
}

variable "dokku_version" {
  description = "Dokku version"
  type        = string
  default     = "0.35.20"
}

variable "dokku_hostname" {
  description = "Dokku hostname"
  type        = string
  default     = "dokku.yourhost.com"
}
