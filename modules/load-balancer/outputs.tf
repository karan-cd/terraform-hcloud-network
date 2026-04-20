output "load_balancer_id" {
  description = "ID of the load balancer."
  value       = try(hcloud_load_balancer.this[0].id, null)
}

output "load_balancer_name" {
  description = "Name of the load balancer."
  value       = try(hcloud_load_balancer.this[0].name, null)
}

output "ipv4" {
  description = "IPv4 address of the load balancer."
  value       = try(hcloud_load_balancer.this[0].ipv4, null)
}

output "ipv6" {
  description = "IPv6 address of the load balancer."
  value       = try(hcloud_load_balancer.this[0].ipv6, null)
}

output "network_id" {
  description = "Network ID the load balancer is attached to."
  value       = try(hcloud_load_balancer_network.this[0].network_id, null)
}

output "network_ip" {
  description = "Private IP in the network."
  value       = try(hcloud_load_balancer_network.this[0].ip, null)
}
