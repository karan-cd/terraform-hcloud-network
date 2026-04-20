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

output "network" {
  description = "Network attributes."
  value = try({
    id                       = hcloud_network.this[0].id
    name                     = hcloud_network.this[0].name
    ip_range                 = hcloud_network.this[0].ip_range
    labels                   = hcloud_network.this[0].labels
    delete_protection        = hcloud_network.this[0].delete_protection
    expose_routes_to_vswitch = hcloud_network.this[0].expose_routes_to_vswitch
  }, null)
}

output "subnet_ids" {
  description = "Map of subnet IDs."
  value       = { for k, v in hcloud_network_subnet.this : k => v.id }
}

output "subnets" {
  description = "Map of created subnets keyed by index."
  value = {
    for k, v in hcloud_network_subnet.this : k => {
      id           = v.id
      ip_range     = v.ip_range
      network_zone = v.network_zone
      type         = v.type
      vswitch_id   = v.vswitch_id
    }
  }
}

output "route_ids" {
  description = "Map of route IDs."
  value       = { for k, v in hcloud_network_route.this : k => v.id }
}

output "routes" {
  description = "Map of created routes keyed by index."
  value = {
    for k, v in hcloud_network_route.this : k => {
      id          = v.id
      destination = v.destination
      gateway     = v.gateway
    }
  }
}
