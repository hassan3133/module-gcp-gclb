module "guse4-master-internallb" {
  source = "../../modules/internal-http"
  #source = "git::https://github.com/pcln/terraform-gcp-gclb.git//modules/internal-http"

  name             = "guse4-internallb"
  ip_address       = module.guse4-internallb-intip.ip_addresses[0]
  use_tls          = true
  ssl_certificates = [google_compute_region_ssl_certificate.pcln.id]
  port_range       = 443

  backend_services = [
    {
      group           = data.google_compute_instance_group.backend.self_link,
      balancing_mode  = "UTILIZATION",
      capacity_scaler = 1.0
    },
  ]

  # pass through
  env     = var.env
  project = var.project
  region  = var.region

  # set the valohai VPC
  network_type = "valohai"

  depends_on = [
    google_compute_region_ssl_certificate.pcln
  ]
}
