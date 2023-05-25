module "acm" {
  source           = "terraform-google-modules/kubernetes-engine/google//modules/acm"

  project_id       = "my-project-id"
  cluster_name     = "my-cluster-name"
  location         = module.gke.location
  sync_repo        = "git@github.com:GoogleCloudPlatform/anthos-config-management-samples.git"
  sync_branch      = "1.0.0"
  policy_dir       = "foo-corp"

  # ACM Policy Controller Policy Essentials Policy Bundle: https://cloud.google.com/anthos-config-management/docs/how-to/using-policy-essentials-v2022
  policy_bundles = ["https://github.com/GoogleCloudPlatform/acm-policy-controller-library/bundles/policy-essentials-v2022#e4094aacb91a35b0219f6f4cf6a31580e85b3c28"]

  create_metrics_gcp_sa = true
}
