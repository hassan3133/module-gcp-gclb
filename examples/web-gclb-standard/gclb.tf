module "gclb" {
  source = "../../modules/gclb"

  env                     = var.env
  name                    = var.name
  address_type            = var.address_type
  address_ip_version      = var.address_ip_version
  ssl_certificates        = [data.google_compute_ssl_certificate.pcln.self_link]
  ssl_policy              = data.google_compute_ssl_policy.pcln.self_link
  port_range              = var.port_range
  default_backend_service = google_compute_backend_service.rcnginxfe-global-all-poc-backend.self_link

  url_host_rules = [
    { hosts = ["*"], matcher = "rcnginxfe-global-all-poc-pathmatcher" },
    { hosts = ["guse4-poc.priceline.com"], matcher = "rcnginxfe-global-guse4-poc-pathmatcher" },
    { hosts = ["gnae1-poc.priceline.com"], matcher = "rcnginxfe-global-gnae1-poc-pathmatcher" },
    { hosts = ["gsae1-poc.priceline.com"], matcher = "rcnginxfe-global-gsae1-poc-pathmatcher" }
  ]

  url_map_rules = [
    {
      service_paths = [{
        service = google_compute_backend_service.cpsnginxfe-global-all-poc-backend.self_link,
        path    = ["/pws/v0/index/*", "/pws/v0/gateql/*", "/pws/v0/streamgest/*"],
      }],
      matcher         = "rcnginxfe-global-all-poc-pathmatcher"
      default_service = google_compute_backend_service.rcnginxfe-global-all-poc-backend.self_link
    },
    {
      service_paths = [{
        service = google_compute_backend_service.cpsnginxfe-global-guse4-poc-backend.self_link,
        path    = ["/pws/v0/index/*", "/pws/v0/gateql/*", "/pws/v0/streamgest/*"],
      }],
      matcher         = "rcnginxfe-global-guse4-poc-pathmatcher"
      default_service = google_compute_backend_service.rcnginxfe-global-guse4-poc-backend.self_link
    },
    {
      service_paths = [{
        service = google_compute_backend_service.cpsnginxfe-global-gnae1-poc-backend.self_link,
        path    = ["/pws/v0/index/*", "/pws/v0/gateql/*", "/pws/v0/streamgest/*"],
      }],
      matcher         = "rcnginxfe-global-gnae1-poc-pathmatcher"
      default_service = google_compute_backend_service.rcnginxfe-global-gnae1-poc-backend.self_link
    },
    {
      service_paths = [{
        service = google_compute_backend_service.cpsnginxfe-global-gsae1-poc-backend.self_link,
        path    = ["/pws/v0/index/*", "/pws/v0/gateql/*", "/pws/v0/streamgest/*"],
      }],
      matcher         = "rcnginxfe-global-gsae1-poc-pathmatcher"
      default_service = google_compute_backend_service.rcnginxfe-global-gsae1-poc-backend.self_link
    }
  ]
}
