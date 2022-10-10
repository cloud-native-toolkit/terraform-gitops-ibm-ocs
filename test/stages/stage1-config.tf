module "config" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-cluster-config?ref=v1.1.1"

  banner_background_color = "purple"
  banner_text = "ODF Testing"
  banner_text_color = "#fff"
  git_credentials = module.gitops.git_credentials
  gitops_config = module.gitops.gitops_config
  namespace = module.gitops_namespace.name
  server_name = module.gitops.server_name
}
