locals {
  name          = "ibm-odf"
  bin_dir       = module.setup_clis.bin_dir
  yaml_dir      = "${path.cwd}/.tmp/${local.name}"
  tmp_dir       = "${path.cwd}/.tmp/tmp"
  values_file   = "value-${var.server_name}.yaml"
  values_content = {
    osdDevicePaths = var.osdDevicePaths
    osdStorageClassName = var.osdStorageClassName
    osdSize = var.osdSize
    numOfOsd = var.numOfOsd
    billingType = var.billingType
    ocsUpgrade = var.ocsUpgrade
    clusterEncryption = var.clusterEncryption
    workerNodes = var.workerNodes
    monSize = var.monSize
    monStorageClassName = var.monStorageClassName
    monDevicePaths = var.monDevicePaths
    autoDiscoverDevices = var.autoDiscoverDevices
    hpcsEncryption = var.hpcsEncryption
    hpcsServiceName = var.hpcsServiceName
    hpcsInstanceId = var.hpcsInstanceId
    hpcsSecretName = var.hpcsSecretName
    hpcsBaseUrl = var.hpcsBaseUrl
    hpcsTokenUrl = var.hpcsTokenUrl
  }
  layer = "infrastructure"
  type  = "base"
  application_branch = "main"
  namespace = var.namespace
  layer_config = var.gitops_config[local.layer]
}

module setup_clis {
  source  = "cloud-native-toolkit/clis/util"

  clis = ["kubectl", "jq", "igc"]
}

resource null_resource create_yaml {
  provisioner "local-exec" {
    command = "${path.module}/scripts/create-yaml.sh '${local.name}' '${local.yaml_dir}' '${local.values_file}'"

    environment = {
      VALUES_CONTENT = yamlencode(local.values_content)
      BIN_DIR = local.bin_dir
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

resource gitops_module module {
  depends_on = [null_resource.create_yaml, module.seal_secrets]

  name = local.name
  namespace = var.namespace
  content_dir = local.yaml_dir
  server_name = var.server_name
  layer = local.layer
  type = local.type
  branch = local.application_branch
  config = yamlencode(var.gitops_config)
  credentials = yamlencode(var.git_credentials)
  value_files = "values.yaml,${local.values_file}"
}
