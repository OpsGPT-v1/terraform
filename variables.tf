# variables.tf
# Root variables for the OpsGPT Infrastructure

variable "subscription_id" {
  type        = string
  description = "The Azure subscription ID to deploy resources to."
  default     = "65bf2554-8090-4538-9c38-8a6e9c5f6f22"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the existing Resource Group."
  default     = "Aasik-OpsGPT"
}

variable "location" {
  type        = string
  description = "The Azure region for the resource deployment."
  default     = "eastus"
}

variable "environment" {
  type        = string
  description = "The deployment environment (e.g. dev, prod)."
  default     = "dev"
}

variable "owner" {
  type        = string
  description = "The owner/team responsible for the resources."
  default     = "Aasik"
}

# PostgreSQL credentials
variable "db_admin_username" {
  type        = string
  description = "Admin username for PostgreSQL Flexible Server."
  default     = "pgsqladmin"
}

variable "db_admin_password" {
  type        = string
  description = "Admin password for PostgreSQL Flexible Server."
  sensitive   = true
}

# VM credentials
variable "vm_admin_username" {
  type        = string
  description = "Admin username for the Management VM."
  default     = "opsgptadmin"
}

variable "vm_admin_password" {
  type        = string
  description = "Admin password for the Management VM."
  sensitive   = true
}

# Monitoring alerts
variable "slack_webhook_url" {
  type        = string
  description = "Slack webhook URL for routing infrastructure monitor alerts."
  sensitive   = true
}

# Network Variables
variable "vnet_name" {
  type        = string
  description = "The name of the virtual network."
  default     = "OpsGPT-vnet"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "The address space of the virtual network."
  default     = ["192.168.0.0/16"]
}

variable "appgw_subnet_name" {
  type        = string
  description = "Subnet name for the Application Gateway."
  default     = "appgw-subnet"
}

variable "appgw_subnet_prefix" {
  type        = list(string)
  description = "Subnet address prefix for the Application Gateway."
  default     = ["192.168.1.0/24"]
}

variable "aks_subnet_name" {
  type        = string
  description = "Subnet name for the AKS cluster."
  default     = "aks-subnet"
}

variable "aks_subnet_prefix" {
  type        = list(string)
  description = "Subnet address prefix for the AKS cluster."
  default     = ["192.168.2.0/23"]
}

variable "pe_subnet_name" {
  type        = string
  description = "Subnet name for private endpoints."
  default     = "pe-subnet"
}

variable "pe_subnet_prefix" {
  type        = list(string)
  description = "Subnet address prefix for private endpoints."
  default     = ["192.168.4.0/24"]
}

variable "pgsql_subnet_name" {
  type        = string
  description = "Subnet name for PostgreSQL flexible server."
  default     = "pgsql-subnet"
}

variable "pgsql_subnet_prefix" {
  type        = list(string)
  description = "Subnet address prefix for PostgreSQL flexible server."
  default     = ["192.168.5.0/24"]
}

variable "bastion_subnet_prefix" {
  type        = list(string)
  description = "Subnet address prefix for Bastion."
  default     = ["192.168.6.0/26"]
}

variable "mgmt_subnet_name" {
  type        = string
  description = "Subnet name for management VM."
  default     = "mgmt-subnet"
}

variable "mgmt_subnet_prefix" {
  type        = list(string)
  description = "Subnet address prefix for management VM."
  default     = ["192.168.7.0/24"]
}

variable "bastion_host_name" {
  type        = string
  description = "The name of the Bastion Host."
  default     = "opsgpt-bastion"
}

variable "mgmt_nic_name" {
  type        = string
  description = "The name of the management NIC."
  default     = "opsgpt-mgmt-nic"
}

variable "mgmt_vm_name" {
  type        = string
  description = "The name of the management VM."
  default     = "opsgpt-mgmt-vm"
}

variable "mgmt_vm_size" {
  type        = string
  description = "The VM size of the management VM."
  default     = "Standard_B2s"
}

variable "appgw_name" {
  type        = string
  description = "The name of the Application Gateway."
  default     = "opsgpt-appgw"
}

variable "waf_policy_name" {
  type        = string
  description = "The name of the WAF policy."
  default     = "opsgpt-waf-policy"
}

# AKS Variables
variable "aks_cluster_name" {
  type        = string
  description = "The name of the AKS cluster."
  default     = "opsgpt-aks-aasik"
}

variable "aks_dns_prefix" {
  type        = string
  description = "DNS prefix for the AKS cluster."
  default     = "opsgpt-aks"
}

variable "node_pool_name" {
  type        = string
  description = "Name of the default node pool."
  default     = "default"
}

variable "aks_vm_size" {
  type        = string
  description = "The size of the VMs in the node pool."
  default     = "Standard_D2s_v3"
}

variable "min_node_count" {
  type        = number
  description = "Minimum node count for autoscaling."
  default     = 1
}

variable "max_node_count" {
  type        = number
  description = "Maximum node count for autoscaling."
  default     = 3
}

variable "node_count" {
  type        = number
  description = "Initial/default node count."
  default     = 2
}

variable "pod_cidr" {
  type        = string
  description = "The IP address range for Kubernetes Pods."
  default     = "10.244.0.0/16"
}

variable "service_cidr" {
  type        = string
  description = "The IP address range for Kubernetes Services."
  default     = "10.0.0.0/16"
}

variable "dns_service_ip" {
  type        = string
  description = "The IP address of the Kubernetes DNS service."
  default     = "10.0.0.10"
}

variable "dce_name" {
  type        = string
  description = "The name of the Data Collection Endpoint."
  default     = "opsgpt-dce-prometheus"
}

variable "dcr_name" {
  type        = string
  description = "The name of the Data Collection Rule."
  default     = "opsgpt-dcr-prometheus"
}

variable "dev_namespace" {
  type        = string
  description = "The development namespace name."
  default     = "dev"
}

variable "prod_namespace" {
  type        = string
  description = "The production namespace name."
  default     = "prod"
}

# Database Variables
variable "db_server_name" {
  type        = string
  description = "The name of the PostgreSQL flexible server."
  default     = "opsgpt-db-server-aasik"
}

variable "db_sku_name" {
  type        = string
  description = "The SKU name of the PostgreSQL server."
  default     = "GP_Standard_D2s_v3"
}

variable "db_storage_mb" {
  type        = number
  description = "The storage capacity of the database (in MB)."
  default     = 32768
}

variable "db_private_dns_zone_name" {
  type        = string
  description = "The Private DNS Zone name for PostgreSQL."
  default     = "opsgpt-pgsql-dns.postgres.database.azure.com"
}

# Storage and Monitoring Variables
variable "log_analytics_workspace_name" {
  type        = string
  description = "The name of the Log Analytics Workspace."
  default     = "opsgpt-law-aasik"
}

variable "app_insights_name" {
  type        = string
  description = "The name of the Application Insights resource."
  default     = "opsgpt-appinsights-aasik"
}

variable "key_vault_name" {
  type        = string
  description = "The name of the Key Vault."
  default     = "opsgpt-kv-aasik-tf"
}

variable "kv_private_dns_zone_name" {
  type        = string
  description = "The Private DNS Zone name for Key Vault."
  default     = "privatelink.vaultcore.azure.net"
}

variable "kv_pe_name" {
  type        = string
  description = "The name of the Key Vault Private Endpoint."
  default     = "opsgpt-kv-pe"
}

# OpenAI / AI Foundry Variables
variable "ai_foundry_name" {
  type        = string
  description = "The name of the AI Foundry account."
  default     = "opsgpt-ai-aasik"
}

variable "ai_deployment_name" {
  type        = string
  description = "The name of the AI model deployment."
  default     = "gpt-model-deploy"
}

variable "ai_model_name" {
  type        = string
  description = "The model name to deploy in the AI Foundry account."
  default     = "gpt-35-turbo"
}

variable "ai_model_version" {
  type        = string
  description = "The model version to deploy."
  default     = "0613"
}

variable "ai_private_dns_zone_name" {
  type        = string
  description = "The Private DNS Zone name for AI Foundry."
  default     = "privatelink.cognitiveservices.azure.com"
}

variable "ai_pe_name" {
  type        = string
  description = "The name of the AI Private Endpoint."
  default     = "opsgpt-ai-pe"
}

# Service Bus Variables
variable "service_bus_name" {
  type        = string
  description = "The name of the Service Bus namespace."
  default     = "opsgpt-sb-aasik-ns"
}

variable "sb_queue_name" {
  type        = string
  description = "The name of the Service Bus queue."
  default     = "opsgpt-alerts-queue"
}

variable "sb_private_dns_zone_name" {
  type        = string
  description = "The Private DNS Zone name for Service Bus."
  default     = "privatelink.servicebus.windows.net"
}

variable "sb_pe_name" {
  type        = string
  description = "The name of the Service Bus Private Endpoint."
  default     = "opsgpt-sb-pe"
}

# Action Group Variables
variable "action_group_name" {
  type        = string
  description = "The name of the Monitor Action Group."
  default     = "opsgpt-slack-action-group"
}

variable "action_group_short_name" {
  type        = string
  description = "The short name of the Monitor Action Group."
  default     = "slackalerts"
}

variable "ai_sku_name" {
  type        = string
  description = "The SKU name for the AI model deployment."
  default     = "GlobalStandard"
}
