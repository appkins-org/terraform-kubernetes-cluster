module "kubeadm" {
  source = "./modules/kubeadm"

  ssh = var.ssh
}

module "cilium" {
  source = "./modules/cilium"

  depends_on = [
    module.kubeadm
  ]
}

module "metallb" {
  source = "./modules/metallb"

  depends_on = [
    module.kubeadm,
    module.cilium
  ]
}
