locals {
  name          = "ibm-odf"
  bin_dir       = module.setup_clis.bin_dir
  yaml_dir      = "${path.cwd}/.tmp/${local.name}"
  tmp_dir      = "${path.cwd}/.tmp/tmp"

  values_content = {
    image = var.job_container_image
    imageTag = var.job_container_image_tag
    cluster = var.cluster_name
    region = var.region
  }

  layer = "infrastructure"
  type  = "base"
  application_branch = "main"
  namespace = var.namespace
  layer_config = var.gitops_config[local.layer]
}

module setup_clis {
  source  = "cloud-native-toolkit/clis/util"
  version = "1.13.0"

  clis = ["kubectl", "jq", "igc"]
}

resource null_resource create_yaml {
  provisioner "local-exec" {
    command = "${path.module}/scripts/create-yaml.sh '${local.name}' '${local.yaml_dir}/'"

    environment = {
      VALUES_CONTENT = yamlencode(local.values_content)
    }
  }
}

resource null_resource create_secrets {
  provisioner "local-exec" {
    command = "${path.module}/scripts/create-secrets.sh '${var.namespace}' '${local.tmp_dir}'"

    environment = {
      BIN_DIR = module.setup_clis.bin_dir
      IBMCLOUD_API_KEY = var.ibmcloud_api_key
      NAMESPACE = var.namespace
    }
  }
}

module seal_secrets {
  depends_on = [null_resource.create_secrets,null_resource.create_yaml]

  source = "github.com/cloud-native-toolkit/terraform-util-seal-secrets.git"

  source_dir    = local.tmp_dir
  dest_dir      = "${local.yaml_dir}/templates"
  kubeseal_cert = var.kubeseal_cert
  label         = "odf-key"
}

resource null_resource setup_gitops {
  depends_on = [null_resource.create_yaml, module.seal_secrets]

  triggers = {
    name = local.name
    namespace = var.namespace
    yaml_dir = local.yaml_dir
    server_name = var.server_name
    layer = local.layer
    type = local.type
    git_credentials = yamlencode(var.git_credentials)
    gitops_config   = yamlencode(var.gitops_config)
    bin_dir = local.bin_dir
  }

  provisioner "local-exec" {
    command = "${self.triggers.bin_dir}/igc gitops-module '${self.triggers.name}' -n '${self.triggers.namespace}' --contentDir '${self.triggers.yaml_dir}' --serverName '${self.triggers.server_name}' -l '${self.triggers.layer}' --type '${self.triggers.type}'"

    environment = {
      GIT_CREDENTIALS = nonsensitive(self.triggers.git_credentials)
      GITOPS_CONFIG   = self.triggers.gitops_config
    }
  }

  provisioner "local-exec" {
    when = destroy
    command = "${self.triggers.bin_dir}/igc gitops-module '${self.triggers.name}' -n '${self.triggers.namespace}' --delete --contentDir '${self.triggers.yaml_dir}' --serverName '${self.triggers.server_name}' -l '${self.triggers.layer}' --type '${self.triggers.type}' --debug"

    environment = {
      GIT_CREDENTIALS = nonsensitive(self.triggers.git_credentials)
      GITOPS_CONFIG   = self.triggers.gitops_config
    }
  }
}

