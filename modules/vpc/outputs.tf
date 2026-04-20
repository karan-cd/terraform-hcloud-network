output "network_id" {
  description = "ID of the network."
  value       = try(hcloud_network.this[0].id, null)
}

output "network_name" {
  description = "Name of the network."
  value       = try(hcloud_network.this[0].name, null)
}

output "ip_range" {
  description = "IP range of the network."
  value       = try(hcloud_network.this[0].ip_range, null)
}

output "subnet_ids" {
  description = "Map of subnet IDs."
  value       = { for k, v in hcloud_network_subnet.this : k => v.id }
}

output "route_ids" {
  description = "Map of route IDs."
  value       = { for k, v in hcloud_network_route.this : k => v.id }
}
