#----------------------------------------------------------------------------
# inputs - module parameters
#----------------------------------------------------------------------------

variable "env" {
  default = "poc"
}

variable "region" {
  default = ""
}

variable "project" {
  default = ""
}

variable "name" {
  default = ""
}

variable "ssl_certificates" {
  type    = list
  default = []
}

variable "port_range" {
  default = "80"
}

variable "backend_services" {
  type = list(object({
    group           = string
    balancing_mode  = string
    capacity_scaler = number
  }))

  default = []

  validation {
    condition = length([
      for o in var.backend_services : true
      if contains(["UTILIZATION", "RATE"], o.balancing_mode)
    ]) == length(var.backend_services)
    error_message = "Valid values for backend_services.balancing_mode are: UTILIZATION, RATE."
  }

  validation {
    condition = length([
      for o in var.backend_services : true
      if o.capacity_scaler >= 0.0 && o.capacity_scaler <= 1.0
    ]) == length(var.backend_services)
    error_message = "Valid values for backend_services.capacity_scaler are: 0.0 to 1.0 inclusive."
  }
}

# CUSTOM NAME OVERRIDES
variable "custom_name_override" {
  description = "Allows to override loadbalancer components names."
  default     = false

  validation {
    condition     = var.custom_name_override == true || var.custom_name_override == false
    error_message = "Valid values for custom_name_override are: boolean true or false."
  }
}

variable "load_balancer_name" {
  description = "Loadbalancer name. Overrides standard naming convention"
  type        = string
  default     = ""
}

variable "target_proxy_name" {
  description = "HTTP/S proxy name. Overrides standard naming convention"
  type        = string
  default     = ""
}

variable "forwarding_rule_name" {
  description = "Forwarding rule name. Overrides standard naming convention"
  type        = string
  default     = ""
}

variable "url_map_name" {
  description = "Url map name. Overrides standard naming convention"
  type        = string
  default     = ""
}

variable "health_check_name" {
  description = "Health check name. Overrides standard naming convention"
  type        = string
  default     = ""
}

variable "backend_service_name" {
  description = "Backend Service name. Overrides standard naming convention"
  type        = string
  default     = ""
}

variable "ip_protocol" {
  description = "The IP protocol to which this rule applies."
  default     = "TCP"

  validation {
    condition     = var.ip_protocol == "TCP"
    error_message = "Valid values for ip_protocol is: TCP."
  }
}

variable "ip_address" {
  description = "The IP address that this forwarding rule is serving on behalf of."
  default     = ""
}

variable "network_tier" {
  description = "Network tier to use for loadbalancer."
  default     = "PREMIUM"
  validation {
    condition     = contains(["PREMIUM", "STANDARD"], var.network_tier)
    error_message = "Valid values for network_tier are: PREMIUM, STANDARD."
  }
}

variable "health_check" {
  description = "Health check to determine whether instances are responsive and able to do work, could be (`tcp` or `http`)"
  type = object({
    type = string
    port = string
  })

  default = {
    type = "tcp",
    port = "80",
  }

  validation {
    condition     = contains(["tcp", "http"], var.health_check.type)
    error_message = "Valid values for health_check.type are: tcp, http."
  }
}

variable "network_type" {
  description = "Used to identify the pcln network (net, valohai or qubole)"
  type        = string
  default     = "net"

  validation {
    condition     = contains(["net", "qubole", "valohai"], var.network_type)
    error_message = "Valid values for network_type are: net, qubole, valohai."
  }
}

variable "user_labels" {
  description = "User defined labels to apply to the loadbalancer components"
  type        = map
  default     = {}
}

variable "network_name_override" {
  description = "Override the network name"
  type        = string
  default     = ""
}

variable "subnet_type" {
  description = "a subnet type"
  type        = string
  default     = "private"
}

variable "network_project_override" {
  description = "Override the network name"
  type        = string
  default     = ""
}

variable "use_tls" {
  description = "Use TLS with loadbalncer"
  type        = bool
  default     = true

  validation {
    condition     = var.use_tls == true || var.use_tls == false
    error_message = "Valid values for use_tls are: boolean true or false."
  }
}

variable "port_name" {
  description = "A named port on a backend instance group representing the port for communication to the backend VMs in that group."
  default     = "http"
}

variable "backend_protocol" {
  description = "A named port on a backend instance group representing the port for communication to the backend VMs in that group."
  default     = "HTTP"
}

variable "team" {
  description = "Name of the team that owns the resource"
  type        = string
  default     = ""
}
