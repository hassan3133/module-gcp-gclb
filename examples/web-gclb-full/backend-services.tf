# ------------------------------------------------------------------------------
# Backend Services

resource "google_compute_backend_service" "rcnginxfe-global-all-poc-backend" {
  name                            = "rcnginxfe-global-all-${var.env}-backend"
  affinity_cookie_ttl_sec         = var.backend_service_affinity_cookie_ttl_sec
  connection_draining_timeout_sec = var.backend_service_connection_draining_timeout_sec
  enable_cdn                      = var.backend_service_enable_cdn
  load_balancing_scheme           = var.backend_service_load_balancing_scheme
  port_name                       = var.backend_service_port_name
  protocol                        = var.backend_service_protocol
  security_policy                 = var.backend_service_security_policy
  session_affinity                = var.backend_service_session_affinity
  timeout_sec                     = var.backend_service_timeout_sec

  health_checks = [google_compute_https_health_check.pcln.self_link]

  backend {
    balancing_mode               = "RATE"
    capacity_scaler              = 1
    group                        = google_compute_region_instance_group_manager.gnae1-rcnginxfe-0igm.instance_group
    max_connections              = 0
    max_connections_per_endpoint = 0
    max_connections_per_instance = 0
    max_rate                     = 0
    max_rate_per_endpoint        = 0

    max_rate_per_instance = 10000
    max_utilization       = 0
  }

  backend {
    balancing_mode               = "RATE"
    capacity_scaler              = 1
    group                        = google_compute_region_instance_group_manager.guse4-rcnginxfe-0igm.instance_group
    max_connections              = 0
    max_connections_per_endpoint = 0
    max_connections_per_instance = 0
    max_rate                     = 0
    max_rate_per_endpoint        = 0
    max_rate_per_instance        = 10000
    max_utilization              = 0
  }
}
resource "google_compute_backend_service" "rcnginxfe-global-gnae1-poc-backend" {
  name                            = "rcnginxfe-global-gnae1-${var.env}-backend"
  affinity_cookie_ttl_sec         = var.backend_service_affinity_cookie_ttl_sec
  connection_draining_timeout_sec = var.backend_service_connection_draining_timeout_sec
  enable_cdn                      = var.backend_service_enable_cdn
  load_balancing_scheme           = var.backend_service_load_balancing_scheme
  port_name                       = var.backend_service_port_name
  protocol                        = var.backend_service_protocol
  security_policy                 = var.backend_service_security_policy
  session_affinity                = var.backend_service_session_affinity
  timeout_sec                     = var.backend_service_timeout_sec

  health_checks = [google_compute_https_health_check.pcln.self_link]

  backend {
    balancing_mode               = "RATE"
    capacity_scaler              = 1
    group                        = google_compute_region_instance_group_manager.gnae1-rcnginxfe-0igm.instance_group
    max_connections              = 0
    max_connections_per_endpoint = 0
    max_connections_per_instance = 0
    max_rate                     = 0
    max_rate_per_endpoint        = 0
    max_rate_per_instance        = 10000
    max_utilization              = 0
  }
}
resource "google_compute_backend_service" "rcnginxfe-global-gsae1-poc-backend" {
  name                            = "rcnginxfe-global-gsae1-${var.env}-backend"
  affinity_cookie_ttl_sec         = var.backend_service_affinity_cookie_ttl_sec
  connection_draining_timeout_sec = var.backend_service_connection_draining_timeout_sec
  enable_cdn                      = var.backend_service_enable_cdn
  load_balancing_scheme           = var.backend_service_load_balancing_scheme
  port_name                       = var.backend_service_port_name
  protocol                        = var.backend_service_protocol
  security_policy                 = var.backend_service_security_policy
  session_affinity                = var.backend_service_session_affinity
  timeout_sec                     = var.backend_service_timeout_sec

  health_checks = [google_compute_https_health_check.pcln.self_link]
  backend {
    balancing_mode               = "RATE"
    capacity_scaler              = 1
    group                        = google_compute_region_instance_group_manager.gsae1-rcnginxfe-0igm.instance_group
    max_connections              = 0
    max_connections_per_endpoint = 0
    max_connections_per_instance = 0
    max_rate                     = 0
    max_rate_per_endpoint        = 0
    max_rate_per_instance        = 10000
    max_utilization              = 0
  }

}


resource "google_compute_backend_service" "rcnginxfe-global-guse4-poc-backend" {
  name                            = "rcnginxfe-global-guse4-${var.env}-backend"
  affinity_cookie_ttl_sec         = var.backend_service_affinity_cookie_ttl_sec
  connection_draining_timeout_sec = var.backend_service_connection_draining_timeout_sec
  enable_cdn                      = var.backend_service_enable_cdn
  load_balancing_scheme           = var.backend_service_load_balancing_scheme
  port_name                       = var.backend_service_port_name
  protocol                        = var.backend_service_protocol
  security_policy                 = var.backend_service_security_policy
  session_affinity                = var.backend_service_session_affinity
  timeout_sec                     = var.backend_service_timeout_sec

  health_checks = [google_compute_https_health_check.pcln.self_link]

  backend {
    balancing_mode               = "RATE"
    capacity_scaler              = 1
    group                        = google_compute_region_instance_group_manager.guse4-rcnginxfe-0igm.instance_group
    max_connections              = 0
    max_connections_per_endpoint = 0
    max_connections_per_instance = 0
    max_rate                     = 0
    max_rate_per_endpoint        = 0
    max_rate_per_instance        = 10000
    max_utilization              = 0
  }
}

# ------------------------------------------------------------------------------
# Health Checks

resource "google_compute_https_health_check" "pcln" {
  name        = "${var.name}-gclb-healthcheck-${var.env}"
  description = "healthcheck for ${var.env} gclb backends"

  check_interval_sec  = var.health_check_check_interval_sec
  healthy_threshold   = var.health_check_healthy_threshold
  port                = var.health_check_port
  request_path        = var.health_check_request_path
  timeout_sec         = var.health_check_timeout_sec
  unhealthy_threshold = var.health_check_unhealthy_threshold
}
