terraform {
  backend "gcs" {
    bucket = "pcln-pl-terraform-prod-tfo"
    prefix = "gcp/pcln_pl_devops_poc/gce/us-east4/lb"
  }
}
