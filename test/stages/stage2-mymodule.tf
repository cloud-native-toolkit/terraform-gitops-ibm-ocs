module "odf_module" {
  source = "./module"
#   source = "../../"

  depends_on = [ module.cluster ]

  ibmcloud_api_key    = var.ibmcloud_api_key
  cluster_name        = module.cluster.name

  autoDiscoverDevices = var.autoDiscoverDevices
  osdStorageClassName = var.osdStorageClassName
  osdSize = var.osdSize
  osdDevicePaths = var.osdDevicePaths
  workerNodes = var.workerNodes
  numOfOsd = var.numOfOsd
  billingType = var.billingType
  ocsUpgrade = var.ocsUpgrade
  clusterEncryption = var.clusterEncryption
  monSize = var.monSize
  monStorageClassName = var.monStorageClassName
  monDevicePaths = var.monDevicePaths
  hpcsEncryption = var.hpcsEncryption
  hpcsServiceName = var.hpcsServiceName
  hpcsInstanceId = var.hpcsInstanceId
  hpcsSecretName = var.hpcsSecretName
  hpcsBaseUrl = var.hpcsBaseUrl
  hpcsTokenUrl = var.hpcsTokenUrl
}
