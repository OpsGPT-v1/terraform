# modules/storage/main.tf
# Provisions Key Vault, AI Foundry, Service Bus, Log Analytics, Application Insights, Private Endpoints, and Slack Action Group

# Get current client config to retrieve tenant ID dynamically
data "azurerm_client_config" "current" {}

# --- Log Analytics Workspace, Monitor Workspace & App Insights ---
resource "azurerm_monitor_workspace" "amw" {
  name                = "opsgpt-amw-aasik" # Note: Monitor Workspace name must be globally unique
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

resource "azurerm_log_analytics_workspace" "workspace" {
  name                = var.log_analytics_workspace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = var.tags
}

resource "azurerm_application_insights" "app_insights" {
  name                = var.app_insights_name
  location            = var.location
  resource_group_name = var.resource_group_name
  workspace_id        = azurerm_log_analytics_workspace.workspace.id
  application_type    = "web"
  tags                = var.tags
}

# --- Azure Key Vault (Private) ---
resource "azurerm_key_vault" "kv" {
  name                          = var.key_vault_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  sku_name                      = "standard"
  public_network_access_enabled = false

  network_acls {
    bypass         = "AzureServices"
    default_action = "Deny"
  }

  tags = var.tags
}

# Key Vault Private DNS Zone & Link
resource "azurerm_private_dns_zone" "kv_dns" {
  name                = var.kv_private_dns_zone_name
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "kv_dns_link" {
  name                  = "kv-dns-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.kv_dns.name
  virtual_network_id    = var.vnet_id
  tags                  = var.tags
}

# Key Vault Private Endpoint
resource "azurerm_private_endpoint" "kv_pe" {
  name                = var.kv_pe_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.pe_subnet_id

  private_service_connection {
    name                           = "kv-privatelink"
    private_connection_resource_id = azurerm_key_vault.kv.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }

  private_dns_zone_group {
    name                 = "kv-dns-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.kv_dns.id]
  }

  tags = var.tags
}

# --- Azure AI Foundry / Cognitive Services (Private) ---
resource "azurerm_cognitive_account" "ai" {
  name                          = var.ai_foundry_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  kind                          = "OpenAI"
  sku_name                      = "S0"
  public_network_access_enabled = false
  custom_subdomain_name         = var.ai_foundry_name

  tags = var.tags
}

# Model Deployment (GPT-3.5 Turbo)
resource "azurerm_cognitive_deployment" "gpt_model" {
  name                 = var.ai_deployment_name
  cognitive_account_id = azurerm_cognitive_account.ai.id

  model {
    format  = "OpenAI"
    name    = var.ai_model_name
    version = var.ai_model_version
  }

  sku {
    name     = var.ai_sku_name
    capacity = 10
  }
}

# AI Foundry Private DNS Zone & Link
resource "azurerm_private_dns_zone" "ai_dns" {
  name                = var.ai_private_dns_zone_name
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Link private zone
resource "azurerm_private_dns_zone_virtual_network_link" "ai_dns_link" {
  name                  = "ai-dns-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.ai_dns.name
  virtual_network_id    = var.vnet_id
  tags                  = var.tags
}

# AI Private Endpoint
resource "azurerm_private_endpoint" "ai_pe" {
  name                = var.ai_pe_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.pe_subnet_id

  private_service_connection {
    name                           = "ai-privatelink"
    private_connection_resource_id = azurerm_cognitive_account.ai.id
    is_manual_connection           = false
    subresource_names              = ["account"]
  }

  private_dns_zone_group {
    name                 = "ai-dns-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.ai_dns.id]
  }

  tags = var.tags
}

# --- Azure Service Bus Namespace & Queue (Private) ---
resource "azurerm_servicebus_namespace" "sb" {
  name                         = var.service_bus_name
  location                     = var.location
  resource_group_name          = var.resource_group_name
  sku                          = "Premium" # Premium required for Private Endpoint support
  capacity                     = 1
  premium_messaging_partitions = 1
  tags                         = var.tags
}

resource "azurerm_servicebus_queue" "sb_queue" {
  name         = var.sb_queue_name
  namespace_id = azurerm_servicebus_namespace.sb.id
}

# Service Bus Private DNS Zone & Link
resource "azurerm_private_dns_zone" "sb_dns" {
  name                = var.sb_private_dns_zone_name
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Link
resource "azurerm_private_dns_zone_virtual_network_link" "sb_dns_link" {
  name                  = "sb-dns-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.sb_dns.name
  virtual_network_id    = var.vnet_id
  tags                  = var.tags
}

# Service Bus Private Endpoint
resource "azurerm_private_endpoint" "sb_pe" {
  name                = var.sb_pe_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.pe_subnet_id

  private_service_connection {
    name                           = "sb-privatelink"
    private_connection_resource_id = azurerm_servicebus_namespace.sb.id
    is_manual_connection           = false
    subresource_names              = ["namespace"]
  }

  private_dns_zone_group {
    name                 = "sb-dns-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.sb_dns.id]
  }

  tags = var.tags
}

# --- Monitor Action Group for Slack alerts ---
resource "azurerm_monitor_action_group" "slack_alerts" {
  name                = var.action_group_name
  resource_group_name = var.resource_group_name
  short_name          = var.action_group_short_name

  webhook_receiver {
    name                    = "slackwebhook"
    service_uri             = var.slack_webhook_url
    use_common_alert_schema = true
  }

  tags = var.tags
}
