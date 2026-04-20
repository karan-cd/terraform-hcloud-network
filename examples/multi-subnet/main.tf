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
# Network Module - Multi Subnet
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
      type         = "cloud"
    },
    {
      ip_range     = "10.0.2.0/24"
      network_zone = "eu-central"
      type         = "cloud"
    },
    {
      ip_range     = "10.0.3.0/24"
      network_zone = "eu-central"
      type         = "cloud"
    },
    {
      ip_range     = "10.0.10.0/24"
      network_zone = "us-east"
      type         = "cloud"
    },
    {
      ip_range     = "10.0.11.0/24"
      network_zone = "us-west"
      type         = "cloud"
    }
  ]

  routes = [
    {
      destination = "10.100.0.0/16"
      gateway     = "10.0.1.1"
    }
  ]
}

output "network_id" {
  description = "ID of the network"
  value       = module.network.network_id
}

output "subnet_ids" {
  description = "IDs of all subnets"
  value       = module.network.subnet_ids
}
