resource "kubernetes_namespace" "default" {
  metadata {
    name = "metallb-system"
  }
}

resource "helm_release" "default" {
  name       = "metallb"
  repository = "https://metallb.github.io/metallb"
  chart      = "metallb"
  namespace  = "metallb-system"
  version    = "0.13.9"

  atomic = true

  depends_on = [kubernetes_namespace.default]
}

resource "kubectl_manifest" "ip" {
  yaml_body = yamlencode(local.address_pools)

  depends_on = [helm_release.default]
}
