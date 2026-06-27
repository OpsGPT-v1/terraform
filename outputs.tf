# outputs.tf
# Root outputs for the OpsGPT Infrastructure

output "resource_group_name" {
  value       = var.resource_group_name
  description = "The target Resource Group."
}

output "vnet_id" {
  value       = module.vnet.vnet_id
  description = "The ID of the Virtual Network."
}

output "appgw_public_ip" {
  value       = module.vnet.appgw_public_ip
  description = "The public IP address of the Application Gateway (ingress entrypoint)."
}

output "bastion_host_name" {
  value       = module.vnet.bastion_host_name
  description = "The name of the Azure Bastion Host."
}

output "management_vm_private_ip" {
  value       = module.vnet.management_vm_private_ip
  description = "The private IP address of the Management VM."
}

output "aks_cluster_name" {
  value       = module.aks.aks_cluster_name
  description = "The name of the AKS cluster."
}

output "aks_cluster_endpoint" {
  value       = module.aks.aks_cluster_endpoint
  sensitive   = true
  description = "The endpoint URL for the private AKS cluster."
}


output "aks_oidc_issuer_url" {
  value       = module.aks.aks_oidc_issuer_url
  description = "The OIDC issuer URL for configuring workload identities."
}

output "postgresql_server_name" {
  value       = module.database.postgresql_server_name
  description = "The domain name of the PostgreSQL Flexible Server."
}

output "key_vault_uri" {
  value       = module.storage.key_vault_uri
  description = "The URI of the Key Vault."
}

output "ai_foundry_endpoint" {
  value       = module.storage.ai_foundry_endpoint
  description = "The endpoint URL of the AI Foundry (Cognitive) resource."
}

# output "service_bus_namespace" {
#   value       = module.storage.service_bus_namespace
#   description = "The name of the Service Bus namespace."
# }
# 
# output "service_bus_queue" {
#   value       = module.storage.service_bus_queue
#   description = "The name of the Service Bus queue."
# }

output "action_group_id" {
  value       = module.storage.action_group_id
  description = "The ID of the Monitor Action Group for Slack alerts."
}

output "grafana_endpoint" {
  value       = module.storage.grafana_endpoint
  description = "The endpoint URL of the Azure Managed Grafana workspace."
}
