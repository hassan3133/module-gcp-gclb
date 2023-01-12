#----------------------------------------------------------------------------
# local variables
#----------------------------------------------------------------------------

locals {
  load_balancer_name   = var.custom_name_override ? var.load_balancer_name : "${var.name}-httplb"
  target_proxy_name    = var.custom_name_override ? var.target_proxy_name : "${var.name}-httplb-http-proxy"
  forwarding_rule_name = var.custom_name_override ? var.forwarding_rule_name : "${var.name}-httplb-fwd-rule"
  url_map_name         = local.load_balancer_name
  health_check_name    = var.custom_name_override ? var.health_check_name : "${var.name}-httplb-hc"
  backend_service_name = var.custom_name_override ? var.backend_service_name : "${var.name}-httplb-bs"

  network_project = module.gcp_varlib.env_to_network_project[var.network_type][var.env]
  network_name    = module.gcp_varlib.network_project_to_network[local.network_project]

  subnetwork_prefix = module.gcp_varlib.network_project_region_to_subnet[local.network_project][var.region]

  default_labels = {
    environment = var.env,
    managed_by  = "terraform",
  }

  labels = merge(local.default_labels, module.cloudcost_labels.labels, var.user_labels)
}

#----------------------------------------------------------------------------
# data requests
#----------------------------------------------------------------------------
data "google_compute_network" "pcln" {
  name = local.network_name
}

data "google_compute_subnetwork" "pcln" {
  name    = var.network_name_override != "" ? var.network_name_override : "${local.subnetwork_prefix}-${var.subnet_type}"
  project = var.network_project_override != "" ? var.network_project_override : local.network_project
  region  = var.region
}

#----------------------------------------------------------------------------
# resources
#----------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# IF PLAIN HTTP ENABLED, CREATE FORWARDING RULE AND PROXY
# https://cloud.google.com/load-balancing/docs/forwarding-rule-concepts
# ------------------------------------------------------------------------------

resource "google_compute_forwarding_rule" "http" {
  provider = google-beta
  count    = var.use_tls ? 0 : 1

  # the name of the loadbalacer appears to be a name of url mal in the console
  name   = local.forwarding_rule_name
  region = var.region

  ip_address            = var.ip_address
  ip_protocol           = var.ip_protocol
  load_balancing_scheme = "INTERNAL_MANAGED"
  port_range            = var.port_range
  target                = google_compute_region_target_http_proxy.http[0].self_link
  network               = data.google_compute_network.pcln.self_link
  subnetwork            = data.google_compute_subnetwork.pcln.self_link
  network_tier          = var.network_tier

  labels = local.labels
}

resource "google_compute_region_target_http_proxy" "http" {
  provider = google-beta
  count    = var.use_tls ? 0 : 1

  name    = local.target_proxy_name
  region  = var.region
  project = var.project
  url_map = google_compute_region_url_map.pcln.id
}

# ------------------------------------------------------------------------------
# IF USE_TLS ENABLED, CREATE FORWARDING RULE AND PROXY
# https://cloud.google.com/load-balancing/docs/forwarding-rule-concepts
# ------------------------------------------------------------------------------

resource "google_compute_forwarding_rule" "https" {
  provider = google-beta
  count    = var.use_tls ? 1 : 0

  # the name of the loadbalacer appears to be a name of url mal in the console
  name   = local.forwarding_rule_name
  region = var.region

  ip_address            = var.ip_address
  ip_protocol           = var.ip_protocol
  load_balancing_scheme = "INTERNAL_MANAGED"
  port_range            = var.port_range
  target                = google_compute_region_target_https_proxy.https[0].self_link
  network               = data.google_compute_network.pcln.self_link
  subnetwork            = data.google_compute_subnetwork.pcln.self_link
  network_tier          = var.network_tier

  labels = local.labels
}

resource "google_compute_region_target_https_proxy" "https" {
  provider = google-beta
  count    = var.use_tls ? 1 : 0

  name             = local.target_proxy_name
  region           = var.region
  project          = var.project
  ssl_certificates = var.ssl_certificates
  url_map          = google_compute_region_url_map.pcln.id
}

# ------------------------------------------------------------------------------
# url map
# https://cloud.google.com/load-balancing/docs/url-map-concepts
# ------------------------------------------------------------------------------
resource "google_compute_region_url_map" "pcln" {
  provider = google-beta

  name            = local.url_map_name
  region          = var.region
  default_service = google_compute_region_backend_service.pcln.id
}

resource "google_compute_region_backend_service" "pcln" {
  provider = google-beta

  name                  = local.backend_service_name
  region                = var.region
  project               = var.project
  load_balancing_scheme = "INTERNAL_MANAGED"

  dynamic "backend" {
    for_each = var.backend_services

    content {
      group           = backend.value["group"]
      balancing_mode  = backend.value["balancing_mode"]
      capacity_scaler = backend.value["capacity_scaler"]
    }
  }

  port_name = var.port_name
  protocol  = var.backend_protocol

  health_checks = [var.health_check["type"] == "tcp" ? google_compute_region_health_check.tcp[0].self_link : google_compute_region_health_check.http[0].self_link]
}

# ------------------------------------------------------------------------------
# health checks
# https://cloud.google.com/load-balancing/docs/health-check-concepts
# ------------------------------------------------------------------------------

resource "google_compute_region_health_check" "tcp" {
  provider = google-beta

  name    = local.health_check_name
  region  = var.region
  project = var.project

  count = var.health_check["type"] == "tcp" ? 1 : 0

  tcp_health_check {
    port = var.health_check["port"]
  }
}

resource "google_compute_region_health_check" "http" {
  provider = google-beta

  name    = local.health_check_name
  region  = var.region
  project = var.project

  count = var.health_check["type"] == "http" ? 1 : 0

  http_health_check {
    port = var.health_check["port"]
  }
}
