variable "create" {
  description = "Whether to create the firewall."
  type        = bool
  default     = true
}

variable "name" {
  description = "Name of the firewall."
  type        = string

  validation {
    condition     = length(trimspace(var.name)) > 0
    error_message = "The `name` value must be a non-empty string."
  }
}

variable "labels" {
  description = "Labels to apply to the firewall."
  type        = map(string)
  default     = {}

  validation {
    condition = alltrue([
      for k, v in var.labels : (
        length(k) > 0 &&
        length(k) <= 63 &&
        length(v) <= 63 &&
        can(regex("^[A-Za-z0-9][A-Za-z0-9_.-]{0,62}$", k))
      )
    ])
    error_message = "The `labels` map keys must match ^[A-Za-z0-9][A-Za-z0-9_.-]{0,62}$ (max 63 chars). Label values must be <= 63 chars."
  }
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

  validation {
    condition = alltrue([
      for r in var.inbound_rules : (
        contains(["in"], lower(try(r.direction, "in"))) &&
        contains(["tcp", "udp", "icmp", "esp", "gre"], lower(r.protocol)) &&
        (try(r.port, null) == null || can(regex("^([0-9]{1,5})(-[0-9]{1,5})?$", r.port))) &&
        alltrue([for ip in coalesce(try(r.source_ips, null), []) : can(cidrhost(ip, 0))]) &&
        alltrue([for ip in coalesce(try(r.destination_ips, null), []) : can(cidrhost(ip, 0))])
      )
    ])
    error_message = "Inbound rules: direction must be in; protocol must be one of tcp/udp/icmp/esp/gre; port (if set) must be like 80 or 80-90; and IPs must be valid CIDR blocks."
  }
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

  validation {
    condition = alltrue([
      for r in var.outbound_rules : (
        contains(["out"], lower(try(r.direction, "out"))) &&
        contains(["tcp", "udp", "icmp", "esp", "gre"], lower(r.protocol)) &&
        (try(r.port, null) == null || can(regex("^([0-9]{1,5})(-[0-9]{1,5})?$", r.port))) &&
        alltrue([for ip in coalesce(try(r.source_ips, null), []) : can(cidrhost(ip, 0))]) &&
        alltrue([for ip in coalesce(try(r.destination_ips, null), []) : can(cidrhost(ip, 0))])
      )
    ])
    error_message = "Outbound rules: direction must be out; protocol must be one of tcp/udp/icmp/esp/gre; port (if set) must be like 80 or 80-90; and IPs must be valid CIDR blocks."
  }
}

variable "apply_to" {
  description = "Resources to apply the firewall to."
  type = list(object({
    label_selector = optional(string)
    server         = optional(number)
  }))
  default = []

  validation {
    condition = alltrue([
      for a in var.apply_to : (
        (try(a.server, null) != null && try(a.server, 0) > 0) ||
        (try(a.label_selector, null) != null && length(trimspace(try(a.label_selector, ""))) > 0)
      )
    ])
    error_message = "Each `apply_to` entry must set either `server` (> 0) or a non-empty `label_selector`."
  }
}
