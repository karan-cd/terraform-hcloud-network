resource "hcloud_firewall" "this" {
  count = var.create ? 1 : 0

  name   = var.name
  labels = var.labels

  dynamic "rule" {
    for_each = var.inbound_rules
    content {
      description     = rule.value.description
      direction       = "in"
      protocol        = rule.value.protocol
      port            = rule.value.port
      source_ips      = rule.value.source_ips
      destination_ips = rule.value.destination_ips
    }
  }

  dynamic "rule" {
    for_each = var.outbound_rules
    content {
      description     = rule.value.description
      direction       = "out"
      protocol        = rule.value.protocol
      port            = rule.value.port
      source_ips      = rule.value.source_ips
      destination_ips = rule.value.destination_ips
    }
  }

  dynamic "apply_to" {
    for_each = var.apply_to
    content {
      label_selector = apply_to.value.label_selector
      server         = apply_to.value.server
    }
  }
}
