module "example" {
  source = "git::https://github.com/pcln/terraform-gcp-gclb.git//modules/external-ssl?ref=develop"

  name             = "example"
  ssl_certificates = ["projects/pcln-pl-devops-poc/global/sslCertificates/wild-priceline-2020"]
  backends = [
    {
      group           = ""
      balancing_mode  = "UTILIZATION"
      max_utilization = 1.0
      capacity_scaler = 1.0
    }
  ]
  project = var.project
}
