mock_provider "hcloud" {
  override_during = plan
}

variables {
  name     = "test-network"
  ip_range = "10.99.0.0/16"

  labels = {
    test = "true"
  }

  subnets = [
    {
      ip_range     = "10.99.1.0/24"
      network_zone = "eu-central"
    }
  ]

  create_firewall = true
  inbound_rules = [
    {
      protocol   = "tcp"
      port       = "22"
      source_ips = ["0.0.0.0/0"]
    }
  ]

  create_load_balancer    = true
  load_balancer_location  = "fsn1"
  load_balancer_algorithm = "round_robin"
  load_balancer_services = [
    {
      protocol         = "http"
      listen_port      = 80
      destination_port = 8080
    }
  ]
  load_balancer_targets = [
    {
      type           = "label_selector"
      label_selector = "service=web"
      use_private_ip = true
    }
  ]
}

run "plan_offline" {
  command = plan

  plan_options {
    refresh = false
  }
}

