# Dokku Installation Resource
#
# This null_resource performs the Dokku installation on a remote server via SSH.
# 
# Why null_resource?
# - No native Dokku provider exists for OpenTofu/Terraform
# - Dokku installation requires running shell commands on a remote system
# - null_resource provides the perfect abstraction for executing arbitrary commands
# - Allows us to leverage OpenTofu's lifecycle management for what is essentially
#   a one-time installation task
#
# Key Features:
# - Idempotent: Safe to run multiple times (script checks if Dokku already exists)
# - Change Detection: Re-runs when critical parameters or the install script change
# - Resource Management: Properly tracked in OpenTofu state for dependency management
# - SSH-based: Uses standard SSH connection for secure remote execution
#
# Alternatives Considered:
# - local-exec: Would run commands locally, not on target server
# - remote-exec alone: Lacks the resource lifecycle and change detection features
# - Custom provider: Overkill for this simple installation task
# - Configuration management tools: Adds unnecessary complexity for a one-time setup
#
resource "null_resource" "install" {
  # Triggers define when this resource should be recreated/re-executed
  # Adding comprehensive triggers ensures the installation runs when needed
  triggers = {
    dokku_version  = var.dokku_version                             # Re-install if version changes
    dokku_hostname = var.dokku_hostname                            # Re-install if hostname changes  
    ssh_host       = var.ssh_host                                  # Re-install if target host changes
    install_script = filesha256("${path.module}/files/install.sh") # Re-install if script changes
  }

  # SSH connection configuration for remote execution
  connection {
    type        = "ssh"
    user        = var.ssh_user
    host        = var.ssh_host
    private_key = file(var.ssh_private_key_path)
    timeout     = "5m" # Reasonable timeout for slow connections
  }

  # Upload the installation script to the remote server
  provisioner "file" {
    source      = "${path.module}/files/install.sh"
    destination = "/tmp/install.sh"
  }

  # Execute the installation script with proper parameters and cleanup
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install.sh",                                   # Make script executable
      "/tmp/install.sh ${var.dokku_version} ${var.dokku_hostname}", # Run with validated parameters
      "rm -f /tmp/install.sh"                                       # Clean up temporary file
    ]
  }
}
