resource "helm_release" "default" {
  name       = "metallb"
  repository = "https://metallb.github.io/metallb"
  chart      = "metallb"
  namespace  = "metallb-system"
  version    = "0.13.9"
}

resource "kubectl_manifest" "ip"  {
  yaml_body = <<YAML
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: private-pool
  namespace: metallb-system
spec:
  addresses:
  - 192.168.50.75-192.168.50.77
YAML
}
