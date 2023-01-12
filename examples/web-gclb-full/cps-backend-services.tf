# ------------------------------------------------------------------------------
# Backend Services

resource "google_compute_backend_service" "cpsnginxfe-global-all-poc-backend" {
  name                            = "cpsnginxfe-global-all-${var.env}-backend"
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
    group                        = google_compute_region_instance_group_manager.gnae1-cpsnginxfe-0igm.instance_group
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
    group                        = google_compute_region_instance_group_manager.guse4-cpsnginxfe-0igm.instance_group
    max_connections              = 0
    max_connections_per_endpoint = 0
    max_connections_per_instance = 0
    max_rate                     = 0
    max_rate_per_endpoint        = 0
    max_rate_per_instance        = 10000
    max_utilization              = 0
  }
}
resource "google_compute_backend_service" "cpsnginxfe-global-gnae1-poc-backend" {
  name                            = "cpsnginxfe-global-gnae1-${var.env}-backend"
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
    group                        = google_compute_region_instance_group_manager.gnae1-cpsnginxfe-0igm.instance_group
    max_connections              = 0
    max_connections_per_endpoint = 0
    max_connections_per_instance = 0
    max_rate                     = 0
    max_rate_per_endpoint        = 0
    max_rate_per_instance        = 10000
    max_utilization              = 0
  }
}
resource "google_compute_backend_service" "cpsnginxfe-global-gsae1-poc-backend" {
  name                            = "cpsnginxfe-global-gsae1-${var.env}-backend"
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
    group                        = google_compute_region_instance_group_manager.gsae1-cpsnginxfe-0igm.instance_group
    max_connections              = 0
    max_connections_per_endpoint = 0
    max_connections_per_instance = 0
    max_rate                     = 0
    max_rate_per_endpoint        = 0
    max_rate_per_instance        = 10000
    max_utilization              = 0
  }

}


resource "google_compute_backend_service" "cpsnginxfe-global-guse4-poc-backend" {
  name                            = "cpsnginxfe-global-guse4-${var.env}-backend"
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
    group                        = google_compute_region_instance_group_manager.guse4-cpsnginxfe-0igm.instance_group
    max_connections              = 0
    max_connections_per_endpoint = 0
    max_connections_per_instance = 0
    max_rate                     = 0
    max_rate_per_endpoint        = 0
    max_rate_per_instance        = 10000
    max_utilization              = 0
  }
}
