module "k3s" {
  source = "./modules/k3s"

  ssh = var.ssh
}

module "cilium" {
  source = "./modules/cilium"

  depends_on = [
    module.k3s
  ]
}

/* module "metallb" {
  source = "./modules/metallb"

  depends_on = [
    module.kubeadm,
    module.cilium
  ]
} */

module "onepassword" {
  count = var.onepassword != null ? 1 : 0

  source = "./modules/onepassword"

  token = var.onepassword.token
  credentials = var.onepassword.credentials

  depends_on = [
    module.k3s,
    module.cilium
  ]

}
