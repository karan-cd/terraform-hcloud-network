variable "create" {
  description = "Whether to create the network."
  type        = bool
  default     = true
}

variable "name" {
  description = "Name of the network."
  type        = string
}

variable "ip_range" {
  description = "IP range of the network (CIDR notation)."
  type        = string
  default     = "10.0.0.0/16"
}

variable "labels" {
  description = "Labels to apply to the network."
  type        = map(string)
  default     = {}
}

variable "delete_protection" {
  description = "Enable delete protection."
  type        = bool
  default     = false
}

variable "expose_routes_to_vswitch" {
  description = "Enable routing from vSwitch."
  type        = bool
  default     = false
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
