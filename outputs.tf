
output "name" {
  description = "The name of the module"
  value       = local.name
  depends_on  = [gitops_module.module]
}

output "branch" {
  description = "The branch where the module config has been placed"
  value       = local.application_branch
  depends_on  = [gitops_module.module]
}

output "namespace" {
  description = "The namespace where the module will be deployed"
  value       = local.namespace
  depends_on  = [gitops_module.module]
}

output "server_name" {
  description = "The server where the module will be deployed"
  value       = var.server_name
  depends_on  = [gitops_module.module]
}

output "layer" {
  description = "The layer where the module is deployed"
  value       = local.layer
  depends_on  = [gitops_module.module]
}

output "type" {
  description = "The type of module where the module is deployed"
  value       = local.type
  depends_on  = [gitops_module.module]
}

output "rwo_storage_class" {
  value       = var.default_rwo_storage_class
  depends_on  = [gitops_module.module]
}

output "file_storage_class" {
  value       = var.default_file_storage_class
  depends_on  = [gitops_module.module]
}

output "block_storage_class" {
  value       = var.default_block_storage_class
  depends_on  = [gitops_module.module]
}

output "storage_classes_provided" {
  value      = []
  depends_on  = [gitops_module.module]
}
