module "guse4-master-intip" {
  source = "git::https://github.com/pcln/terraform-gcp-compute_address.git//modules/compute_address_tfo"

  clusterid    = "a"
  ip_addresses = [""]
  name_suffix  = "-intip"
  servertype   = "master"
  subnet_type  = "private"

  # pass through
  env     = var.env
  project = var.project
  region  = var.region

  # set the qubole VPC
  network_type = "valohai"
}
