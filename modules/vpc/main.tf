resource "hcloud_network" "this" {
  count = var.create ? 1 : 0

  name                     = var.name
  ip_range                 = var.ip_range
  labels                   = var.labels
  delete_protection        = var.delete_protection
  expose_routes_to_vswitch = var.expose_routes_to_vswitch
}

resource "hcloud_network_subnet" "this" {
  for_each = var.create ? { for idx, subnet in var.subnets : idx => subnet } : {}

  network_id   = hcloud_network.this[0].id
  ip_range     = each.value.ip_range
  network_zone = each.value.network_zone
  type         = each.value.type
  vswitch_id   = each.value.vswitch_id
}

resource "hcloud_network_route" "this" {
  for_each = var.create ? { for idx, route in var.routes : idx => route } : {}

  network_id  = hcloud_network.this[0].id
  destination = each.value.destination
  gateway     = each.value.gateway
}
