# modules/storage/variables.tf

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group."
}

variable "location" {
  type        = string
  description = "The location of resources."
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resources."
}

variable "vnet_id" {
  type        = string
  description = "The ID of the Virtual Network."
}

variable "pe_subnet_id" {
  type        = string
  description = "The ID of the private endpoints subnet."
}

variable "slack_webhook_url" {
  type        = string
  description = "Slack webhook URL for alerts."
  sensitive   = true
}

variable "ai_model_name" {
  type        = string
  description = "AI Foundry Model Name."
}

variable "ai_model_version" {
  type        = string
  description = "AI Foundry Model Version."
}

# Parameterized Storage, Monitoring, Messaging, Alerting Variables
variable "log_analytics_workspace_name" {
  type        = string
  description = "The name of the Log Analytics Workspace."
}

variable "app_insights_name" {
  type        = string
  description = "The name of the Application Insights resource."
}

variable "key_vault_name" {
  type        = string
  description = "The name of the Key Vault."
}

variable "kv_private_dns_zone_name" {
  type        = string
  description = "The Private DNS Zone name for Key Vault."
}

variable "kv_pe_name" {
  type        = string
  description = "The name of the Key Vault Private Endpoint."
}

variable "ai_foundry_name" {
  type        = string
  description = "The name of the AI Foundry account."
}

variable "ai_deployment_name" {
  type        = string
  description = "The name of the AI model deployment."
}

variable "ai_private_dns_zone_name" {
  type        = string
  description = "The Private DNS Zone name for AI Foundry."
}

variable "ai_pe_name" {
  type        = string
  description = "The name of the AI Private Endpoint."
}

variable "service_bus_name" {
  type        = string
  description = "The name of the Service Bus namespace."
}

variable "sb_queue_name" {
  type        = string
  description = "The name of the Service Bus queue."
}

variable "sb_private_dns_zone_name" {
  type        = string
  description = "The Private DNS Zone name for Service Bus."
}

variable "sb_pe_name" {
  type        = string
  description = "The name of the Service Bus Private Endpoint."
}

variable "action_group_name" {
  type        = string
  description = "The name of the Monitor Action Group."
}

variable "action_group_short_name" {
  type        = string
  description = "The short name of the Monitor Action Group."
}

variable "ai_sku_name" {
  type        = string
  description = "SKU name for the AI model deployment."
  default     = "GlobalStandard"
}
