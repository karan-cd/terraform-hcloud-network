module "wrapper" {
  source = "../"

  for_each = var.items

  name     = try(each.value.name, each.key)
  ip_range = try(each.value.ip_range, "10.0.0.0/16")
  labels   = try(each.value.labels, {})
  subnets  = try(each.value.subnets, [])
  routes   = try(each.value.routes, [])

  create_vpc = try(each.value.create_vpc, true)

  create_firewall = try(each.value.create_firewall, false)
  firewall_name   = try(each.value.firewall_name, null)
  inbound_rules   = try(each.value.inbound_rules, [])
  outbound_rules  = try(each.value.outbound_rules, [])

  create_load_balancer   = try(each.value.create_load_balancer, false)
  load_balancer_name     = try(each.value.load_balancer_name, null)
  load_balancer_type     = try(each.value.load_balancer_type, "lb11")
  load_balancer_location = try(each.value.load_balancer_location, "fsn1")
  load_balancer_services = try(each.value.load_balancer_services, [])
  load_balancer_targets  = try(each.value.load_balancer_targets, [])
}

variable "items" {
  description = "Map of network configurations"
  type        = any
  default     = {}
}

output "wrapper" {
  description = "Map of network outputs"
  value       = module.wrapper
}
