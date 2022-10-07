module "cluster" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-ocp-vpc.git"

  depends_on = [ module.cos, module.subnets, module.vpc ]

  resource_group_name = module.resource_group.name
  region              = var.region
  ibmcloud_api_key    = var.ibmcloud_api_key
  worker_count        = 3 # var.worker_count
  ocp_version         = "4.10" # var.ocp_version
  flavor              = "bx2.16x64" # var.flavor
  exists              = "false"
  name_prefix         = local.name_prefix_test
  vpc_name            = module.subnets.vpc_name
  vpc_subnets         = module.subnets.subnets
  vpc_subnet_count    = module.subnets.count
  cos_id              = module.cos.id
  login               = "true"
  force_delete_storage = "true"
}

module "dev_cluster" {
  source = "github.com/cloud-native-toolkit/terraform-ocp-login.git"

  server_url = module.cluster.server_url
  login_user = "apikey"
  login_password = var.ibmcloud_api_key
  login_token = ""
}

resource null_resource output_kubeconfig {
  provisioner "local-exec" {
    command = "echo '${module.dev_cluster.platform.kubeconfig}' > .kubeconfig"
  }
}

