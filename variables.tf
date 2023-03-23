variable "cluster" {
  description = "Cluster configuration."
  type = object({
    name = optional(string, "kubernetes")
    id   = optional(number, 1)
    ssh = object({
      user        = optional(string, "root")
      password    = optional(string, null)
      host        = optional(string, null)
      private_key = optional(string, null)
    })
    onepassword = object({
      credentials = optional(any, null)
      token       = optional(string, null)
    })
  })
}

variable "cloudflare" {
  type = object({
    api_key = string
    email   = string
    zone_id = string
    domain  = string
  })
  description = "(optional) describe your variable"
}

variable "ingress" {
  type = object({
    external_ips = list(string)
  })
  description = "Ingress configuration."
}

variable "github" {
  type = object({
    client_id     = string
    client_secret = string
    org           = string
  })
  description = "GitHub OAuth configuration"
}
