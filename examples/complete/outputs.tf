output "network_id" {
  description = "ID of the network"
  value       = module.network.network_id
}

output "firewall_id" {
  description = "ID of the firewall"
  value       = module.network.firewall_id
}

output "load_balancer_id" {
  description = "ID of the load balancer"
  value       = module.network.load_balancer_id
}

output "load_balancer_ipv4" {
  description = "IPv4 of the load balancer"
  value       = module.network.load_balancer_ipv4
}
