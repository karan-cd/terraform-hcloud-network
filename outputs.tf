################################################################################
# VPC
################################################################################

output "network_id" {
  description = "ID of the network."
  value       = module.vpc.network_id
}

output "network_name" {
  description = "Name of the network."
  value       = module.vpc.network_name
}

output "ip_range" {
  description = "IP range of the network."
  value       = module.vpc.ip_range
}

output "subnet_ids" {
  description = "Map of subnet IDs."
  value       = module.vpc.subnet_ids
}

################################################################################
# Firewall
################################################################################

output "firewall_id" {
  description = "ID of the firewall."
  value       = module.firewall.firewall_id
}

output "firewall_name" {
  description = "Name of the firewall."
  value       = module.firewall.firewall_name
}

################################################################################
# Load Balancer
################################################################################

output "load_balancer_id" {
  description = "ID of the load balancer."
  value       = module.load_balancer.load_balancer_id
}

output "load_balancer_ipv4" {
  description = "IPv4 address of the load balancer."
  value       = module.load_balancer.ipv4
}

output "load_balancer_ipv6" {
  description = "IPv6 address of the load balancer."
  value       = module.load_balancer.ipv6
}
