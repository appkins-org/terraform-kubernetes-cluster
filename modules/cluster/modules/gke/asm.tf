module "asm" {
  source                    = "terraform-google-modules/kubernetes-engine/google//modules/fleet-membership"
  project_id                = var.project_id
  cluster_name              = module.gke.name
  cluster_location          = module.gke.location
  multicluster_mode         = "connected"
  enable_cni                = true
  enable_fleet_registration = true
  enable_mesh_feature       = true
}
