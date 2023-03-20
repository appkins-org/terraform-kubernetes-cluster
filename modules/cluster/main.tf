module "kubeadm" {
  source = "./modules/kubeadm"

  ssh = var.ssh
}

module "metallb" {
  source = "./modules/metallb"
}
