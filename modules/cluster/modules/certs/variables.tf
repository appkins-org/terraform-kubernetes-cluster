variable "ca" {
  description = "CA certificate configuration"
  type = object({
    common_name = optional(string, "kubernetes-ca")
    allowed_uses = optional(list(string), ["cert_signing", "crl_signing", "server_auth", "client_auth"])
  })
  default = {}
}
