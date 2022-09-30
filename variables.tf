
variable "gitops_config" {
  type        = object({
    boostrap = object({
      argocd-config = object({
        project = string
        repo = string
        url = string
        path = string
      })
    })
    infrastructure = object({
      argocd-config = object({
        project = string
        repo = string
        url = string
        path = string
      })
      payload = object({
        repo = string
        url = string
        path = string
      })
    })
    services = object({
      argocd-config = object({
        project = string
        repo = string
        url = string
        path = string
      })
      payload = object({
        repo = string
        url = string
        path = string
      })
    })
    applications = object({
      argocd-config = object({
        project = string
        repo = string
        url = string
        path = string
      })
      payload = object({
        repo = string
        url = string
        path = string
      })
    })
  })
  description = "Config information regarding the gitops repo structure"
}

variable "git_credentials" {
  type = list(object({
    repo = string
    url = string
    username = string
    token = string
  }))
  description = "The credentials for the gitops repo(s)"
  sensitive   = true
}

variable "namespace" {
  type        = string
  description = "The namespace where the application should be deployed"
}

variable "kubeseal_cert" {
  type        = string
  description = "The certificate/public key used to encrypt the sealed secrets"
  default     = ""
}

variable "server_name" {
  type        = string
  description = "The name of the server"
  default     = "default"
}

variable "ibmcloud_api_key" {
  type        = string
  description = "The api key for IBM Cloud access"
}

variable "osdStorageClassName" {
  description = "Storage class that you want to use for your OSD devices"
  type = string
  default = "ibmc-vpc-block-metro-10iops-tier"
}

variable "osdSize" {
  description = "Size of your storage devices. The total storage capacity of your ODF cluster is equivalent to the osdSize x 3 divided by the numOfOsd."
  type = string
  default = "250Gi"
}

variable "numOfOsd" {
  description = "Number object storage daemons (OSDs) that you want to create. ODF creates three times the numOfOsd value."
  default = 1
}

variable "billingType" {
  description = "Billing Type for your ODF deployment (`essentials` or `advanced`)."
  type = string
  default = "advanced"
}

variable "ocsUpgrade" {
  description = "Whether to upgrade the major version of your ODF deployment."
  type = bool
  default = false
}

variable "clusterEncryption" {
  description = "Enable encryption of storage cluster"
  type = bool
  default = false
}

# Options available for Openshift 4.7 only. https://cloud.ibm.com/docs/openshift?topic=openshift-deploy-odf-vpc&interface=cli#odf-vpc-params-47
variable "monSize" {
  description = "Size of the storage devices that you want to provision for the monitor pods. The devices must be at least 20Gi each"
  type = string
  default = "20Gi"
}

variable "monStorageClassName" {
  description = "Storage class to use for your Monitor pods. For VPC clusters you must specify a block storage class"
  type = string
  default = "ibmc-vpc-block-metro-10iops-tier"
}

# Options available for Openshift 4.10 only.  See https://cloud.ibm.com/docs/openshift?topic=openshift-deploy-odf-vpc&interface=cli#odf-vpc-params-410
variable "hpcsServiceName" {
  description = "Enter the name of your Hyper Protect Crypto Services instance. For example: Hyper-Protect-Crypto-Services-eugb"
  type = string
  default = "false"
}

variable "hpcsInstanceId" {
  description = "Enter your Hyper Protect Crypto Services instance ID. For example: d11a1a43-aa0a-40a3-aaa9-5aaa63147aaa"
  type = string
  default = "false"
}

variable "hpcsSecretName" {
  description = "Enter the name of the secret that you created by using your Hyper Protect Crypto Services credentials. For example: ibm-hpcs-secret"
  type = string
  default = "false"
}

variable "hpcsBaseUrl" {
  description = "Enter the public endpoint of your Hyper Protect Crypto Services instance. For example: https://api.eu-gb.hs-crypto.cloud.ibm.com:8389"
  type = string
  default = "false"
}

variable "hpcsTokenUrl" {
  description = "Enter https://iam.cloud.ibm.com/oidc/token"
  type = string
  default = "false"
}