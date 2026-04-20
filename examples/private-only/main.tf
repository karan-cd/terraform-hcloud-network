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
# Network Module - Private Network Only (No Firewall, No LB)
################################################################################

module "network" {
  source = "../../"

  name     = local.name
  ip_range = "172.16.0.0/12"
  labels   = local.tags

  subnets = [
    {
      ip_range     = "172.16.0.0/24"
      network_zone = "eu-central"
      type         = "cloud"
    }
  ]

  # Explicitly disable firewall and load balancer
  create_firewall      = false
  create_load_balancer = false
}
