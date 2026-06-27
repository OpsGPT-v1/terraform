# main.tf
# Root entrypoint for the OpsGPT Infrastructure

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.71.0"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
  subscription_id = var.subscription_id
}

# Reference existing resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = "eastus"
  tags     = local.tags
}

# Reference existing Container Registry
resource "azurerm_container_registry" "acr" {
  name                = "OpsGPT"
  resource_group_name = azurerm_resource_group.rg.name
  location            = "eastus"
  sku                 = "Standard"
  admin_enabled       = true
  tags                = local.tags
}

# Local variables for common tags
locals {
  tags = {
    Environment = var.environment
    Owner       = var.owner
    ManagedBy   = "Terraform"
  }
}

# 1. Network & Virtual Machine Module
module "vnet" {
  source                = "./modules/vnet"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = var.location
  tags                  = local.tags
  vm_admin_username     = var.vm_admin_username
  vm_admin_password     = var.vm_admin_password
  vnet_name             = var.vnet_name
  vnet_address_space    = var.vnet_address_space
  appgw_subnet_name     = var.appgw_subnet_name
  appgw_subnet_prefix   = var.appgw_subnet_prefix
  aks_subnet_name       = var.aks_subnet_name
  aks_subnet_prefix     = var.aks_subnet_prefix
  pe_subnet_name        = var.pe_subnet_name
  pe_subnet_prefix      = var.pe_subnet_prefix
  pgsql_subnet_name     = var.pgsql_subnet_name
  pgsql_subnet_prefix   = var.pgsql_subnet_prefix
  bastion_subnet_prefix = var.bastion_subnet_prefix
  mgmt_subnet_name      = var.mgmt_subnet_name
  mgmt_subnet_prefix    = var.mgmt_subnet_prefix
  bastion_host_name     = var.bastion_host_name
  mgmt_nic_name         = var.mgmt_nic_name
  mgmt_vm_name          = var.mgmt_vm_name
  mgmt_vm_size          = var.mgmt_vm_size
  appgw_name            = var.appgw_name
  waf_policy_name       = var.waf_policy_name
}

# 2. Database Module
module "database" {
  source                   = "./modules/database"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  tags                     = local.tags
  vnet_id                  = module.vnet.vnet_id
  pgsql_subnet_id          = module.vnet.pgsql_subnet_id
  db_admin_username        = var.db_admin_username
  db_admin_password        = var.db_admin_password
  db_server_name           = var.db_server_name
  db_sku_name              = var.db_sku_name
  db_storage_mb            = var.db_storage_mb
  db_private_dns_zone_name = var.db_private_dns_zone_name
}

# 3. Storage and Monitoring Module (Key Vault, AI Foundry, App Insights, Alerts, Service Bus)
module "storage" {
  source                       = "./modules/storage"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = var.location
  tags                         = local.tags
  vnet_id                      = module.vnet.vnet_id
  pe_subnet_id                 = module.vnet.pe_subnet_id
  slack_webhook_url            = var.slack_webhook_url
  ai_model_name                = var.ai_model_name
  ai_model_version             = var.ai_model_version
  ai_sku_name                  = var.ai_sku_name
  log_analytics_workspace_name = var.log_analytics_workspace_name
  app_insights_name            = var.app_insights_name
  key_vault_name               = var.key_vault_name
  kv_private_dns_zone_name     = var.kv_private_dns_zone_name
  kv_pe_name                   = var.kv_pe_name
  ai_foundry_name              = var.ai_foundry_name
  ai_deployment_name           = var.ai_deployment_name
  ai_private_dns_zone_name     = var.ai_private_dns_zone_name
  ai_pe_name                   = var.ai_pe_name
  #   service_bus_name             = var.service_bus_name
  #   sb_queue_name                = var.sb_queue_name
  #   sb_private_dns_zone_name     = var.sb_private_dns_zone_name
  #   sb_pe_name                   = var.sb_pe_name
  action_group_name       = var.action_group_name
  action_group_short_name = var.action_group_short_name
}

# 4. AKS Cluster Module
module "aks" {
  source                     = "./modules/aks"
  resource_group_name        = azurerm_resource_group.rg.name
  location                   = var.location
  tags                       = local.tags
  aks_subnet_id              = module.vnet.aks_subnet_id
  appgw_id                   = module.vnet.appgw_id
  appgw_subnet_id            = module.vnet.appgw_subnet_id
  log_analytics_workspace_id = module.storage.log_analytics_workspace_id
  azure_monitor_workspace_id = module.storage.azure_monitor_workspace_id
  aks_cluster_name           = var.aks_cluster_name
  aks_dns_prefix             = var.aks_dns_prefix
  node_pool_name             = var.node_pool_name
  aks_vm_size                = var.aks_vm_size
  min_node_count             = var.min_node_count
  max_node_count             = var.max_node_count
  node_count                 = var.node_count
  pod_cidr                   = var.pod_cidr
  service_cidr               = var.service_cidr
  dns_service_ip             = var.dns_service_ip
  dce_name                   = var.dce_name
  dcr_name                   = var.dcr_name
  dev_namespace              = var.dev_namespace
  prod_namespace             = var.prod_namespace
}

# Configure kubernetes provider to deploy namespaces inside AKS cluster dynamically
provider "kubernetes" {
  host                   = module.aks.aks_cluster_endpoint
  client_certificate     = base64decode(module.aks.client_certificate)
  client_key             = base64decode(module.aks.client_key)
  cluster_ca_certificate = base64decode(module.aks.cluster_ca_certificate)
}
