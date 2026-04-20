output "firewall_id" {
  description = "ID of the firewall."
  value       = try(hcloud_firewall.this[0].id, null)
}

output "firewall_name" {
  description = "Name of the firewall."
  value       = try(hcloud_firewall.this[0].name, null)
}
