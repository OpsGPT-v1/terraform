# modules/aks/main.tf
# Provisions private AKS cluster with CNI Overlay, Key Vault CSI, Prometheus, AGIC, and namespaces

resource "azurerm_kubernetes_cluster" "aks" {
  name                      = var.aks_cluster_name
  location                  = var.location
  resource_group_name       = var.resource_group_name
  dns_prefix                = var.aks_dns_prefix
  private_cluster_enabled   = true
  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  default_node_pool {
    name                 = var.node_pool_name
    vm_size              = var.aks_vm_size
    vnet_subnet_id       = var.aks_subnet_id
    auto_scaling_enabled = true
    min_count            = var.min_node_count
    max_count            = var.max_node_count
    node_count           = var.node_count
    tags                 = var.tags
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    network_policy      = null # network policy engine none
    pod_cidr            = var.pod_cidr
    service_cidr        = var.service_cidr
    dns_service_ip      = var.dns_service_ip
  }

  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  # Container insights logging integration
  oms_agent {
    log_analytics_workspace_id = var.log_analytics_workspace_id
  }

  # Prometheus metrics integration
  monitor_metrics {}

  # AGIC Integration
  ingress_application_gateway {
    gateway_id = var.appgw_id
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      default_node_pool[0].upgrade_settings
    ]
  }
}

# --- AGIC Role Assignments ---
# 1. AGIC Identity requires Contributor access to the Application Gateway to configure routes
resource "azurerm_role_assignment" "agic_appgw" {
  scope                = var.appgw_id
  role_definition_name = "Contributor"
  principal_id         = azurerm_kubernetes_cluster.aks.ingress_application_gateway[0].ingress_application_gateway_identity[0].object_id
}

# 2. AGIC Identity requires Network Contributor access to the App Gateway's subnet
resource "azurerm_role_assignment" "agic_subnet" {
  scope                = var.appgw_subnet_id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_kubernetes_cluster.aks.ingress_application_gateway[0].ingress_application_gateway_identity[0].object_id
}

# --- Managed Prometheus Monitoring (DCR, DCE, DCRA) ---
resource "azurerm_monitor_data_collection_endpoint" "dce" {
  name                = var.dce_name
  resource_group_name = var.resource_group_name
  location            = var.location
  kind                = "Linux"
  tags                = var.tags
}

resource "azurerm_monitor_data_collection_rule" "dcr" {
  name                        = var.dcr_name
  resource_group_name         = var.resource_group_name
  location                    = var.location
  data_collection_endpoint_id = azurerm_monitor_data_collection_endpoint.dce.id
  kind                        = "Linux"

  destinations {
    monitor_account {
      monitor_account_id = var.azure_monitor_workspace_id
      name               = "PrometheusWorkspace"
    }
  }

  data_flow {
    streams      = ["Microsoft-PrometheusMetrics"]
    destinations = ["PrometheusWorkspace"]
  }

  data_sources {
    prometheus_forwarder {
      streams = ["Microsoft-PrometheusMetrics"]
      name    = "PrometheusDataSource"
    }
  }

  tags = var.tags
}

resource "azurerm_monitor_data_collection_rule_association" "dcra" {
  name                    = "opsgpt-dcra-prometheus"
  target_resource_id      = azurerm_kubernetes_cluster.aks.id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.dcr.id
}
