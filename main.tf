################################################################################
# VPC
################################################################################

module "vpc" {
  source = "./modules/vpc"

  create = var.create_vpc

  name     = var.name
  ip_range = var.ip_range
  labels   = var.labels
  subnets  = var.subnets
  routes   = var.routes
}

################################################################################
# Firewall
################################################################################

module "firewall" {
  source = "./modules/firewall"

  create = var.create_firewall

  name           = coalesce(var.firewall_name, "${var.name}-firewall")
  labels         = var.labels
  inbound_rules  = var.inbound_rules
  outbound_rules = var.outbound_rules
}

################################################################################
# Load Balancer
################################################################################

module "load_balancer" {
  source = "./modules/load-balancer"

  create = var.create_load_balancer

  name               = coalesce(var.load_balancer_name, "${var.name}-lb")
  load_balancer_type = var.load_balancer_type
  location           = var.load_balancer_location
  labels             = var.labels
  algorithm          = var.load_balancer_algorithm
  network_id         = var.create_vpc ? module.vpc.network_id : null
  services           = var.load_balancer_services
  targets            = var.load_balancer_targets
}
