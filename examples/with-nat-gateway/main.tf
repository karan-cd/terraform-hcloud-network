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
# Network Module - With NAT Gateway Pattern
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
    }
  ]

  # Route all traffic through a NAT gateway IP
  routes = [
    {
      destination = "0.0.0.0/0"
      gateway     = "10.0.1.1"
    }
  ]

  create_firewall = true
  inbound_rules = [
    {
      description = "Allow SSH from internal"
      protocol    = "tcp"
      port        = "22"
      source_ips  = ["10.0.0.0/8"]
    }
  ]
  outbound_rules = [
    {
      description     = "Allow all outbound"
      protocol        = "tcp"
      port            = "1-65535"
      destination_ips = ["0.0.0.0/0", "::/0"]
    }
  ]
}
