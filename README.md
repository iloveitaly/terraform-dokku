# terraform-dokku

OpenTofu/Terraform Module to deploy Dokku on a node with SSH access using the official Dokku bootstrap script.

## Features

- ✅ Uses official Dokku bootstrap installation method
- ✅ Compatible with OpenTofu 1.6+ and Terraform 1.5+
- ✅ Idempotent installation (safe to run multiple times)
- ✅ Modern Ubuntu support (20.04, 22.04, 24.04)
- ✅ Supports latest Dokku versions (0.35.x)
- ✅ Improved error handling and logging

## Requirements

- OpenTofu >= 1.6 or Terraform >= 1.5
- SSH access to target server
- Ubuntu 20.04+ (recommended)

## Usage

See `test/main.tf` for example usage of the module.

### Basic Example

```hcl
module "dokku" {
  source = "path/to/this/module"

  ssh_host             = "192.168.1.100"
  ssh_user             = "root"
  ssh_private_key_path = "~/.ssh/id_rsa"
  
  dokku_version  = "0.35.20"
  dokku_hostname = "dokku.example.com"
}
```

## Migration from Older Versions

This version updates the installation method from the deprecated Debian package approach to the official bootstrap script. The new version:

- Uses the official Dokku bootstrap script instead of manual package installation
- Updates to the latest Dokku version (0.35.20)
- Adds proper type constraints to all variables
- Improves trigger handling for better change detection
- Adds useful outputs for integration with other modules

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| dokku\_hostname | Dokku hostname | string | `"dokku.yourhost.com"` | no |
| dokku\_version | Dokku version | string | `"0.35.20"` | no |
| ssh\_host | SSH host | string | `"192.168.0.100"` | no |
| ssh\_private\_key\_path | SSH private key path | string | `"~/.ssh/id_rsa"` | no |
| ssh\_user | SSH user | string | `"root"` | no |

## Outputs

| Name | Description |
|------|-------------|
| dokku\_hostname | The hostname configured for Dokku |
| dokku\_version | The version of Dokku installed |
| installation\_id | Unique identifier for this Dokku installation |
| ssh\_host | The SSH host where Dokku is installed |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Contributing

We encourage you to contribute to this project in whatever way you like!

## Versioning

[Semantic Versioning 2.x](https://semver.org/)

In a nutshell:

> Given a version number MAJOR.MINOR.PATCH, increment the:
>
> 1. MAJOR version when you make incompatible API changes,
> 2. MINOR version when you add functionality in a backwards-compatible manner, and
> 3. PATCH version when you make backwards-compatible bug fixes.
>
> Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

## Maintainer

[brotandgames](https://github.com/brotandgames)


