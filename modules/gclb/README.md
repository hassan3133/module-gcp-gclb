# External HTTP/s Loadbalancer module usage
- The following example **examples/web-gclb-standard**, it relies on the instances/instance groups and ssl certs/policies that have already been created. They are being referenced via the **data** sources
- You will need to create a backend per instance group. **examples/web-gclb-standard/backend-services.tf**
- SSL: **examples/web-gclb-standard/ssl.tf**
- Security Policy: **examples/gclb-standard/security-policy.tf**
- In a normal scenario we are assuming some of the basic resources of a project have already been created.
- Review **examples/web-gclb-full** for a full reference of all the resources involved with spinning up the gclb in an empty project - **tested in pcln-pl-devops-poc**
- `export GOOGLE_CLOUD_PROJECT=pcln-pl-devops-poc`

```
module "gcp_gclb" {
  source = "git::https://github.com/pcln/terraform-gcp-gclb.git//modules/gcp_gclb"

  env                     = "poc"
  name                    = "devops"
  address_type            = "EXTERNAL"
  address_ip_version      = "IPV4"
  ssl_certificates        = [data.google_compute_ssl_certificate.pcln.self_link]
  ssl_policy              = data.google_compute_ssl_policy.pcln.self_link
  port_range              = "443"
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
```

where vX.Y.Z is the appropriate [semantic versioning](http://semver.org/).

## Dependencies
- SSL
  - google_compute_ssl_certificate
  - google_compute_ssl_policy
- Instance Groups
  - google_compute_region_instance_groups
- Backend Services
  - google_compute_backend_service
  - google_compute_https_health_check
- Security Policy
  - google_compute_security_policy

## GCLB

- Load Balancer(Module)
  - google_compute_global_address
  - google_compute_target_https_proxy
  - google_compute_global_forwarding_rule
  - google_compute_url_map
    - url_map_rules

## Testing
- must be in your GOPATH
- [Terratest Confluence](https://priceline.atlassian.net/wiki/spaces/Tech/pages/757072228/Terratest)

```
export GOOGLE_CLOUD_PROJECT=pcln-pl-devops-poc

cd test

dep ensure -v

go test -v -timeout 60m
````

### Usage
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_compute_global_forwarding_rule.pcln](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_global_forwarding_rule) | resource |
| [google_compute_global_address.pcln](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |
| [google_compute_target_https_proxy.pcln](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_target_https_proxy) | resource |
| [google_compute_url_map.pcln](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_url_map) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_ip_version"></a> [address\_ip\_version](#input\_address\_ip\_version) | n/a | `string` | `"IPV4"` | no |
| <a name="input_address_name"></a> [address\_name](#input\_address\_name) | Compute address name. Overrides standard naming convention | `string` | `""` | no |
| <a name="input_address_type"></a> [address\_type](#input\_address\_type) | n/a | `string` | `"EXTERNAL"` | no |
| <a name="input_custom_name_override"></a> [custom\_name\_override](#input\_custom\_name\_override) | n/a | `bool` | `false` | no |
| <a name="input_default_backend_service"></a> [default\_backend\_service](#input\_default\_backend\_service) | n/a | `string` | `""` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | `"poc"` | no |
| <a name="input_forwarding_rule_name"></a> [forwarding\_rule\_name](#input\_forwarding\_rule\_name) | n/a | `string` | `""` | no |
| <a name="input_fwd_rule_name"></a> [fwd\_rule\_name](#input\_fwd\_rule\_name) | Forwarding rule name. Overrides standard naming convention | `string` | `""` | no |
| <a name="input_ip_address_name"></a> [ip\_address\_name](#input\_ip\_address\_name) | n/a | `string` | `""` | no |
| <a name="input_load_balancer_name"></a> [load\_balancer\_name](#input\_load\_balancer\_name) | n/a | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"devops"` | no |
| <a name="input_port_range"></a> [port\_range](#input\_port\_range) | n/a | `string` | `"443"` | no |
| <a name="input_proxy_name"></a> [proxy\_name](#input\_proxy\_name) | HTTPS proxy name. Overrides standard naming convention | `string` | `""` | no |
| <a name="input_quic_override"></a> [quic\_override](#input\_quic\_override) | n/a | `string` | `"NONE"` | no |
| <a name="input_ssl_certificates"></a> [ssl\_certificates](#input\_ssl\_certificates) | n/a | `list` | `[]` | no |
| <a name="input_ssl_policy"></a> [ssl\_policy](#input\_ssl\_policy) | n/a | `string` | `""` | no |
| <a name="input_target_proxy_name"></a> [target\_proxy\_name](#input\_target\_proxy\_name) | n/a | `string` | `""` | no |
| <a name="input_url_host_rules"></a> [url\_host\_rules](#input\_url\_host\_rules) | n/a | <pre>list(object({<br>    hosts   = list(string)<br>    matcher = string<br>  }))</pre> | <pre>[<br>  {<br>    "hosts": [<br>      "region-env.priceline.com"<br>    ],<br>    "matcher": "name-global-region-env-pathmatcher"<br>  }<br>]</pre> | no |
| <a name="input_url_map_name"></a> [url\_map\_name](#input\_url\_map\_name) | Url map  name. Overrides standard naming convention | `string` | `""` | no |
| <a name="input_url_map_rules"></a> [url\_map\_rules](#input\_url\_map\_rules) | n/a | <pre>list(object({<br>    service_paths   = list(object({ service = string, path = list(string) }))<br>    default_service = string<br>    matcher         = string<br>  }))</pre> | <pre>[<br>  {<br>    "default_service": "service1",<br>    "matcher": "name-global-region-env-pathmatcher",<br>    "service_paths": [<br>      {<br>        "path": [<br>          "/*"<br>        ],<br>        "service": "service2"<br>      }<br>    ]<br>  }<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ip_address"></a> [ip\_address](#output\_ip\_address) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
