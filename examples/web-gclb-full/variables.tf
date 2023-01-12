#----------------------------------------------------------------------------
# variables - module variables
#----------------------------------------------------------------------------

module "gcp_varlib" {
  source = "git::https://github.com/pcln/terraform-gcp-varlib.git//modules/gcp_varlib"
}

#----------------------------------------------------------------------------
# variables
#----------------------------------------------------------------------------

variable "project" {
  description = "The project name"
  type        = string
  default     = "pcln-pl-devops-poc"
}

variable "region" {
  description = "The region within the project"
  type        = string
  default     = "us-east4"
}

variable "env" {
  default = "poc"
}

variable "name" {
  default = "devops"
}

variable "address_type" {
  default = "EXTERNAL"
}

variable "address_ip_version" {
  default = "IPV4"
}

variable "port_range" {
  default = "443"
}

# ------------------------------------------------------------------------------
# BACKEND SERVICE VARS

variable "backend_service_affinity_cookie_ttl_sec" {
  default = 36000
}
variable "backend_service_connection_draining_timeout_sec" {
  default = 300
}
variable "backend_service_enable_cdn" {
  default = false
}
variable "backend_service_load_balancing_scheme" {
  default = "EXTERNAL"
}
variable "backend_service_port_name" {
  default = "http"
}
variable "backend_service_protocol" {
  default = "HTTPS"
}
variable "backend_service_security_policy" {
  default = "security-policy"
}
variable "backend_service_session_affinity" {
  default = "GENERATED_COOKIE"
}
variable "backend_service_timeout_sec" {
  default = 178
}

# ------------------------------------------------------------------------------
# HEALTH CHECK VARS

variable "health_check_check_interval_sec" {
  default = 10
}
variable "health_check_healthy_threshold" {
  default = 2
}
variable "health_check_port" {
  default = 443
}
variable "health_check_request_path" {
  default = "/robots.txt"
}
variable "health_check_timeout_sec" {
  default = 10
}
variable "health_check_unhealthy_threshold" {
  default = 2
}
