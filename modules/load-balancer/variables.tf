variable "create" {
  description = "Whether to create the load balancer."
  type        = bool
  default     = true
}

variable "name" {
  description = "Name of the load balancer."
  type        = string
}

variable "load_balancer_type" {
  description = "Type of the load balancer."
  type        = string
  default     = "lb11"
}

variable "location" {
  description = "Location of the load balancer."
  type        = string
  default     = "fsn1"
}

variable "network_zone" {
  description = "Network zone (alternative to location)."
  type        = string
  default     = null
}

variable "labels" {
  description = "Labels to apply to the load balancer."
  type        = map(string)
  default     = {}
}

variable "algorithm" {
  description = "Algorithm for the load balancer (round_robin or least_connections)."
  type        = string
  default     = "round_robin"
}

variable "delete_protection" {
  description = "Enable delete protection."
  type        = bool
  default     = false
}

variable "network_id" {
  description = "Network ID to attach the load balancer to."
  type        = number
  default     = null
}

variable "enable_public_interface" {
  description = "Enable public interface."
  type        = bool
  default     = true
}

variable "services" {
  description = "List of services for the load balancer."
  type = list(object({
    protocol         = string
    listen_port      = number
    destination_port = number
    proxyprotocol    = optional(bool, false)
    health_check = optional(object({
      protocol = string
      port     = number
      interval = optional(number, 15)
      timeout  = optional(number, 10)
      retries  = optional(number, 3)
      http = optional(object({
        domain       = optional(string)
        path         = optional(string, "/")
        response     = optional(string)
        status_codes = optional(list(string), ["2??", "3??"])
        tls          = optional(bool, false)
      }))
    }))
    http = optional(object({
      sticky_sessions = optional(bool, false)
      cookie_name     = optional(string)
      cookie_lifetime = optional(number)
      certificates    = optional(list(number))
      redirect_http   = optional(bool, false)
    }))
  }))
  default = []
}

variable "targets" {
  description = "List of targets for the load balancer."
  type = list(object({
    type           = string
    server_id      = optional(number)
    label_selector = optional(string)
    ip             = optional(string)
    use_private_ip = optional(bool, false)
  }))
  default = []
}
