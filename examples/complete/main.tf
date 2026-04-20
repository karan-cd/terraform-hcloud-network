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
# Network Module - Complete
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
    },
    {
      ip_range     = "10.0.2.0/24"
      network_zone = "eu-central"
    }
  ]

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

  create_load_balancer   = true
  load_balancer_type     = "lb11"
  load_balancer_location = "fsn1"
  load_balancer_services = [
    {
      protocol         = "http"
      listen_port      = 80
      destination_port = 80
      health_check = {
        protocol = "http"
        port     = 80
        http = {
          path = "/health"
        }
      }
    }
  ]
}
