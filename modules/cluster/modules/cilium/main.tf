resource "helm_release" "default" {
  name       = "cilium"
  repository = "https://helm.cilium.io/"
  chart      = "cilium"
  namespace  = "kube-system"
  version    = "1.13.1"

  values = [
    yamlencode(local.values)
  ]
}
