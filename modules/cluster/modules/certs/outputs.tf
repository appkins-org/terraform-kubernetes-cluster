output "ca" {
  value = {
    crt = tls_self_signed_cert.kubernetes_ca.cert_pem
    key = tls_private_key.kubernetes_ca.private_key_pem
  }
}

output "admin" {
  value = {
    crt = tls_self_signed_cert.kubernetes_admin.cert_pem
    key = tls_private_key.kubernetes_admin.private_key_pem
  }
}
