#----------------------------------------------------------------------------
# local variables
#----------------------------------------------------------------------------
locals {
  load_balancer_name   = var.custom_name_override ? var.load_balancer_name : "${var.name}-gclb"
  target_proxy_name    = var.custom_name_override ? var.target_proxy_name : "${var.name}-gclb-https-proxy"
  forwarding_rule_name = var.custom_name_override ? var.forwarding_rule_name : "${var.name}-gclb-global-forwarding-rule"
  ip_address_name      = var.custom_name_override ? var.ip_address_name : "${var.name}-gclb-ip"

}

#----------------------------------------------------------------------------
# resources
#---------------------------------------------------------------------------

resource "google_compute_global_address" "pcln" {
  name         = (var.address_name != "" ? var.address_name : local.ip_address_name)
  ip_version   = var.address_ip_version
  address_type = var.address_type
}

resource "google_compute_target_https_proxy" "pcln" {
  name             = (var.proxy_name != "" ? var.proxy_name : local.target_proxy_name)
  url_map          = google_compute_url_map.pcln.self_link
  ssl_certificates = var.ssl_certificates
  ssl_policy       = var.ssl_policy
  quic_override    = var.quic_override

  depends_on = [google_compute_url_map.pcln]

}

resource "google_compute_global_forwarding_rule" "pcln" {
  provider = google-beta

  name       = (var.fwd_rule_name != "" ? var.fwd_rule_name : local.forwarding_rule_name)
  target     = google_compute_target_https_proxy.pcln.self_link
  ip_address = google_compute_global_address.pcln.address
  port_range = var.port_range

  depends_on = [google_compute_global_address.pcln]

}

resource "google_compute_url_map" "pcln" {
  name            = (var.url_map_name != "" ? var.url_map_name : local.load_balancer_name)
  default_service = var.default_backend_service

  dynamic "host_rule" {
    for_each = var.url_host_rules
    content {
      hosts        = host_rule.value["hosts"]
      path_matcher = host_rule.value["matcher"]
    }
  }

  dynamic "path_matcher" {
    for_each = var.url_map_rules
    content {
      name            = path_matcher.value["matcher"]
      default_service = path_matcher.value["default_service"]

      dynamic "path_rule" {
        for_each = path_matcher.value["service_paths"]
        content {
          paths   = path_rule.value["path"]
          service = path_rule.value["service"]
        }
      }
    }
  }

}
