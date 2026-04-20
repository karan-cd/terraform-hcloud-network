################################################################################
# Common
################################################################################

variable "name" {
  description = "Name prefix for resources."
  type        = string
}

variable "labels" {
  description = "Labels to apply to all resources."
  type        = map(string)
  default     = {}
}

################################################################################
# VPC
################################################################################

variable "create_vpc" {
  description = "Whether to create the VPC."
  type        = bool
  default     = true
}

variable "ip_range" {
  description = "IP range of the network."
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnets" {
  description = "List of subnets to create."
  type = list(object({
    ip_range     = string
    network_zone = string
    type         = optional(string, "cloud")
    vswitch_id   = optional(number)
  }))
  default = []
}

variable "routes" {
  description = "List of routes to create."
  type = list(object({
    destination = string
    gateway     = string
  }))
  default = []
}

################################################################################
# Firewall
################################################################################

variable "create_firewall" {
  description = "Whether to create the firewall."
  type        = bool
  default     = false
}

variable "firewall_name" {
  description = "Name of the firewall. Defaults to name-firewall."
  type        = string
  default     = null
}

variable "inbound_rules" {
  description = "List of inbound firewall rules."
  type = list(object({
    description     = optional(string)
    protocol        = string
    port            = optional(string)
    source_ips      = optional(list(string), ["0.0.0.0/0", "::/0"])
    destination_ips = optional(list(string))
  }))
  default = []
}

variable "outbound_rules" {
  description = "List of outbound firewall rules."
  type = list(object({
    description     = optional(string)
    protocol        = string
    port            = optional(string)
    source_ips      = optional(list(string))
    destination_ips = optional(list(string), ["0.0.0.0/0", "::/0"])
  }))
  default = []
}

################################################################################
# Load Balancer
################################################################################

variable "create_load_balancer" {
  description = "Whether to create the load balancer."
  type        = bool
  default     = false
}

variable "load_balancer_name" {
  description = "Name of the load balancer. Defaults to name-lb."
  type        = string
  default     = null
}

variable "load_balancer_type" {
  description = "Type of the load balancer."
  type        = string
  default     = "lb11"
}

variable "load_balancer_location" {
  description = "Location of the load balancer."
  type        = string
  default     = "fsn1"
}

variable "load_balancer_algorithm" {
  description = "Algorithm for the load balancer."
  type        = string
  default     = "round_robin"
}

variable "load_balancer_services" {
  description = "List of services for the load balancer."
  type        = any
  default     = []
}

variable "load_balancer_targets" {
  description = "List of targets for the load balancer."
  type        = any
  default     = []
}
