output "network_id" {
  description = "ID of the network"
  value       = module.vpc.network_id
}

output "subnet_ids" {
  description = "Subnet IDs"
  value       = module.vpc.subnet_ids
}
