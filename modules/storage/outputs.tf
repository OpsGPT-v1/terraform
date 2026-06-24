# modules/storage/outputs.tf

output "log_analytics_workspace_id" {
  value       = azurerm_log_analytics_workspace.workspace.id
  description = "The ID of the Log Analytics Workspace."
}

output "azure_monitor_workspace_id" {
  value       = azurerm_monitor_workspace.amw.id
  description = "The ID of the Azure Monitor Workspace."
}


output "key_vault_id" {
  value       = azurerm_key_vault.kv.id
  description = "The ID of the Key Vault."
}

output "key_vault_uri" {
  value       = azurerm_key_vault.kv.vault_uri
  description = "The URI of the Key Vault."
}

output "ai_foundry_id" {
  value       = azurerm_cognitive_account.ai.id
  description = "The ID of the AI Foundry (Cognitive) account."
}

output "ai_foundry_endpoint" {
  value       = azurerm_cognitive_account.ai.endpoint
  description = "The endpoint of the AI Foundry account."
}

output "service_bus_namespace" {
  value       = azurerm_servicebus_namespace.sb.name
  description = "The name of the Service Bus namespace."
}

output "service_bus_queue" {
  value       = azurerm_servicebus_queue.sb_queue.name
  description = "The name of the Service Bus queue."
}


output "action_group_id" {
  value       = azurerm_monitor_action_group.slack_alerts.id
  description = "The ID of the Monitor Action Group."
}
