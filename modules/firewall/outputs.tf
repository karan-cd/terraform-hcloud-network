output "firewall_id" {
  description = "ID of the firewall."
  value       = try(hcloud_firewall.this[0].id, null)
}

output "firewall_name" {
  description = "Name of the firewall."
  value       = try(hcloud_firewall.this[0].name, null)
}

output "firewall" {
  description = "Firewall attributes."
  value = try({
    id     = hcloud_firewall.this[0].id
    name   = hcloud_firewall.this[0].name
    labels = hcloud_firewall.this[0].labels
    rules  = hcloud_firewall.this[0].rule
  }, null)
}
