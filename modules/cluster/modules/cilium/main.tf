resource "helm_release" "default" {
  name       = "cilium"
  repository = "https://helm.cilium.io/"
  chart      = "cilium"
  namespace  = "kube-system"
  version    = "1.14.0-snapshot.0"

  values = [
    yamlencode(local.values)
  ]
}
