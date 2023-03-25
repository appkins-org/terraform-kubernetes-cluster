resource "kubernetes_config_map" "bgp_config" {
  metadata {
    name = "bgp-config"
    namespace = "kube-system"
  }

  data = {
    "config.yaml" = yamlencode(local.bgp_config)
  }
}

resource "helm_release" "default" {
  name       = "cilium"
  repository = "https://helm.cilium.io/"
  chart      = "cilium"
  namespace  = "kube-system"
  version    = "1.14.0-snapshot.0"

  values = [
    yamlencode(local.values)
  ]

  depends_on = [
    kubernetes_config_map.bgp_config
  ]
}

resource "kubectl_manifest" "pools" {
  yaml_body = yamlencode(local.pools)

  depends_on = [helm_release.default]
}
