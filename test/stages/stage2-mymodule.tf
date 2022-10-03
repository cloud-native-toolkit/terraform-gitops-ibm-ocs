module "gitops_module" {
  source = "../../"

  gitops_config = module.gitops.gitops_config
  git_credentials = module.gitops.git_credentials
  server_name = module.gitops.server_name
  namespace = module.gitops_namespace.name
  kubeseal_cert = module.gitops.sealed_secrets_cert
  ibmcloud_api_key = var.ibmcloud_api_key
  osdStorageClassName = var.osdStorageClassName
  osdSize = var.osdSize
  numOfOsd = var.numOfOsd
  billingType = var.billingType
  ocsUpgrade = var.ocsUpgrade
  clusterEncryption = var.clusterEncryption
  monSize = var.monSize
  monStorageClassName = var.monStorageClassName
  hpcsServiceName = var.hpcsServiceName
  hpcsInstanceId = var.hpcsInstanceId
  hpcsSecretName = var.hpcsSecretName
  hpcsBaseUrl = var.hpcsBaseUrl
  hpcsTokenUrl = var.hpcsTokenUrl
}
