#----------------------------------------------------------------------------
# local variables
#----------------------------------------------------------------------------
locals {
  backend_service_name        = var.custom_name_override ? var.backend_service_name : "${var.name}-ssl-backend-service"
  global_address_name         = var.custom_name_override ? var.global_address_name : "${var.name}-ssl-global-lb"
  global_forwarding_rule_name = var.custom_name_override ? var.global_forwarding_rule_name : "${var.name}-ssl-global-fwd-rule"
  health_check_name           = var.custom_name_override ? var.health_check_name : "${var.name}-ssl-health-check"
  load_balancing_scheme       = "EXTERNAL"
  target_ssl_proxy_name       = var.custom_name_override ? var.target_ssl_proxy_name : "${var.name}-target-ssl-proxy"
}

#----------------------------------------------------------------------------
# resources
#---------------------------------------------------------------------------

resource "google_compute_global_address" "default" {
  project      = var.project
  name         = local.global_address_name
  ip_version   = var.ip_version
  address_type = local.load_balancing_scheme
}

resource "google_compute_global_forwarding_rule" "default" {
  project               = var.project
  name                  = local.global_forwarding_rule_name
  ip_protocol           = "TCP"
  load_balancing_scheme = local.load_balancing_scheme
  port_range            = var.port_range
  target                = google_compute_target_ssl_proxy.default.id
  ip_address            = google_compute_global_address.default.id
}

resource "google_compute_target_ssl_proxy" "default" {
  project          = var.project
  name             = local.target_ssl_proxy_name
  backend_service  = google_compute_backend_service.default.id
  ssl_certificates = var.ssl_certificates
  ssl_policy       = var.ssl_policy
}

#
resource "google_compute_backend_service" "default" {
  name                  = local.backend_service_name
  protocol              = var.backend_service_protocol
  port_name             = var.port_name
  load_balancing_scheme = local.load_balancing_scheme
  timeout_sec           = var.backend_service_timeout_sec
  health_checks         = [google_compute_health_check.default.id]
  dynamic "backend" {
    for_each = var.backends
    content {
      group           = lookup(backend.value, "group", null)
      balancing_mode  = lookup(backend.value, "balancing_mode", "UTILIZATION")
      max_utilization = lookup(backend.value, "max_utilization", 1.0)
      capacity_scaler = lookup(backend.value, "capacity_scaler", 1.0)
    }
  }
}

resource "google_compute_health_check" "default" {
  name               = local.health_check_name
  timeout_sec        = var.health_check_timeout_sec
  check_interval_sec = var.health_check_check_interval_sec
  tcp_health_check {
    port = var.port_tcp_health_check
  }
}
