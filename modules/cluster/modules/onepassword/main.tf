resource "helm_release" "default" {
  name       = "connect"
  repository = "https://1password.github.io/connect-helm-charts/"
  chart      = "connect"
  namespace  = "kube-system"

  values = [
    yamlencode(local.values)
  ]
}
