variable "create" {
  description = "Whether to create the firewall."
  type        = bool
  default     = true
}

variable "name" {
  description = "Name of the firewall."
  type        = string
}

variable "labels" {
  description = "Labels to apply to the firewall."
  type        = map(string)
  default     = {}
}

variable "inbound_rules" {
  description = "List of inbound firewall rules."
  type = list(object({
    description     = optional(string)
    direction       = optional(string, "in")
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
    direction       = optional(string, "out")
    protocol        = string
    port            = optional(string)
    source_ips      = optional(list(string))
    destination_ips = optional(list(string), ["0.0.0.0/0", "::/0"])
  }))
  default = []
}

variable "apply_to" {
  description = "Resources to apply the firewall to."
  type = list(object({
    label_selector = optional(string)
    server         = optional(number)
  }))
  default = []
}
