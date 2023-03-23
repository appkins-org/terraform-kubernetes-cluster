module "cluster" {
  source = "./modules/cluster"

  ssh = var.cluster.ssh
  onepassword = var.cluster.onepassword
}

module "core" {
  source = "./modules/core"

  cluster_id = var.cluster.name
  cloudflare = var.cloudflare
  ingress    = var.ingress

  depends_on = [module.cluster]
}

module "services" {
  source = "./modules/services"

  cluster_id = var.cluster.name
  cloudflare = var.cloudflare
  ingress    = var.ingress
  github     = var.github

  depends_on = [module.core]
}
