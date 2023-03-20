resource "helm_release" "default" {
  name       = "metallb"
  repository = "https://metallb.github.io/metallb"
  chart      = "metallb"
  namespace  = "kube-system"
  version    = "0.13.9"
}
