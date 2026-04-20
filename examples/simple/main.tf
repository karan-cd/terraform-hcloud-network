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
# Network Module - VPC Only
################################################################################

module "vpc" {
  source = "../../modules/vpc"

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
