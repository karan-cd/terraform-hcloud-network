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
# Network Module - Firewall Only (No VPC)
################################################################################

module "network" {
  source = "../../"

  name   = local.name
  labels = local.tags

  # Disable VPC creation
  create_vpc = false

  # Create firewall only
  create_firewall = true
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
    },
    {
      description = "Allow HTTPS"
      protocol    = "tcp"
      port        = "443"
      source_ips  = ["0.0.0.0/0", "::/0"]
    }
  ]
}

output "firewall_id" {
  description = "ID of the firewall"
  value       = module.network.firewall_id
}
