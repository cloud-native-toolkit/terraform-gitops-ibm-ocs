
# provider.tf variables
variable "region" {
  type        = string
  description = "The region where the cluster is deployed"
}

variable "ibmcloud_api_key" {
  type        = string
  description = "The api key for IBM Cloud access"
}

# provider.tf variables
variable "git_token" {
  type        = string
  description = "Git token"
}

variable "git_username" {
}

# stage0.tf variables
variable "name_prefix" {
  type        = string
  description = "Prefix name that should be used for the cluster and services. If not provided then resource_group_name will be used"
  default     = ""
}

# stage1-cluster.tf variables
# variable "worker_count" {
#   type        = number
#   description = "Number of worker nodes in cluster"
#   value       = 3
# }

# variable "flavor" {
#   type        = string
#   description = "Type of worker nodes"
#   value       = "bx2.16x64"
# }

# variable "ocp_version" {
#   type        = string
#   description = "Version of OpenShift"
#   value       = "4.10"
# }


# stage1-gitops-bootstrap.tf variables
# variable "bootstrap_prefix" {
#   type = string
#   default = ""
# }

# variable "kubeseal_namespace" {
#   default = "sealed-secrets"
# }

# stage1-gitops.tf variables
variable "namespace" {
  type        = string
  description = "Namespace for tools"
  default = "git-tools"
}

variable "git_repo" {
  default = "git-module-test"
}

variable "gitops_namespace" {
  default = "openshift-gitops"
}

# stage1-resource-group.tf variable
variable "resource_group_name" {
  type        = string
  description = "Existing resource group where the IKS cluster will be provisioned."
}

### ODF specific variables
variable "osdSize" {
  description = "Size of your storage devices. The total storage capacity of your ODF cluster is equivalent to the osdSize x 3 divided by the numOfOsd."
  type = string
  default = "250Gi"
}