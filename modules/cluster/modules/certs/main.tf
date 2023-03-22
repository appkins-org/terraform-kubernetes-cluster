# create certificates for the trust anchor and issuer
resource "tls_private_key" "kubernetes_ca" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Control Plane TLS Credentials
resource "tls_self_signed_cert" "kubernetes_ca" {
  private_key_pem   = tls_private_key.kubernetes_ca.private_key_pem
  is_ca_certificate = true

  validity_period_hours = 17520 # 2 years

  allowed_uses = ["cert_signing", "crl_signing", "server_auth", "client_auth"]

  subject {
    common_name = "kubernetes-ca"
  }
}

resource "tls_private_key" "kubernetes_admin" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_self_signed_cert" "kubernetes_admin" {
  private_key_pem = tls_private_key.kubernetes_admin.private_key_pem

  subject {
    common_name  = "kubernetes-admin"
    organization = "system:masters"
  }

  validity_period_hours = 12

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
    "client_auth"
  ]
}
