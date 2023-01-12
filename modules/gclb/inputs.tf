#----------------------------------------------------------------------------
# inputs - module parameters
#----------------------------------------------------------------------------

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

variable "ssl_certificates" {
  default = []
  type    = list
}

variable "ssl_policy" {
  default = ""
}

variable "quic_override" {
  default = "NONE"
}

variable "port_range" {
  default = "443"
}

variable "default_backend_service" {
  default = ""
}

variable "url_host_rules" {
  type = list(object({
    hosts   = list(string)
    matcher = string
  }))
  default = [{ hosts = ["region-env.priceline.com"], matcher = "name-global-region-env-pathmatcher" }]

}

variable "url_map_rules" {
  type = list(object({
    service_paths   = list(object({ service = string, path = list(string) }))
    default_service = string
    matcher         = string
  }))
  default = [{ service_paths = [{ "service" = "service2", "path" = ["/*"] }], default_service = "service1", matcher = "name-global-region-env-pathmatcher" }]
}

variable "address_name" {
  description = "Compute address name. Overrides standard naming convention"
  type        = string
  default     = ""
}

variable "proxy_name" {
  description = "HTTPS proxy name. Overrides standard naming convention"
  type        = string
  default     = ""
}

variable "fwd_rule_name" {
  description = "Forwarding rule name. Overrides standard naming convention"
  type        = string
  default     = ""
}

variable "url_map_name" {
  description = "Url map  name. Overrides standard naming convention"
  type        = string
  default     = ""
}

# CUSTOM NAME OVERRIDES

variable "custom_name_override" {
  default = false
}
variable "load_balancer_name" {
  default = ""
}
variable "target_proxy_name" {
  default = ""
}
variable "forwarding_rule_name" {
  default = ""
}
variable "ip_address_name" {
  default = ""
}
