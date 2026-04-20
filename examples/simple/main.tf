provider "hcloud" {}

locals {
  name = "ex-${basename(path.cwd)}"

  tags = {
    Example    = local.name
    GithubRepo = "terraform-hcloud-network"
    GithubOrg  = "terraform-hc-modules"
  }
}

################################################################################
# Network Module - Simple VPC
################################################################################

module "network" {
  source = "../../"

  name     = local.name
  ip_range = "10.0.0.0/16"
  labels   = local.tags

  subnets = [
    {
      ip_range     = "10.0.1.0/24"
      network_zone = "eu-central"
    }
  ]
}

output "network_id" {
  description = "ID of the network"
  value       = module.network.network_id
}

output "subnet_ids" {
  description = "IDs of subnets"
  value       = module.network.subnet_ids
}
