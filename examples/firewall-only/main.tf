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
# Firewall Module - Standalone
################################################################################

module "firewall" {
  source = "../../modules/firewall"

  name   = local.name
  labels = local.tags

  inbound_rules = [
    {
      description = "Allow SSH"
      protocol    = "tcp"
      port        = "22"
      source_ips  = ["0.0.0.0/0", "::/0"]
    },
    {
      description = "Allow HTTP"
      protocol    = "tcp"
      port        = "80"
      source_ips  = ["0.0.0.0/0", "::/0"]
    }
  ]

  outbound_rules = [
    {
      description     = "Allow all outbound"
      protocol        = "tcp"
      destination_ips = ["0.0.0.0/0", "::/0"]
    },
    {
      description     = "Allow all UDP outbound"
      protocol        = "udp"
      destination_ips = ["0.0.0.0/0", "::/0"]
    }
  ]
}
