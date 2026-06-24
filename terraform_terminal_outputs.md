# Terraform Terminal Execution Outputs

Here are the terminal logs from the successful `terraform plan` and `terraform apply` executions for the OpsGPT infrastructure deployment in `westeurope`.

---

## 1. Terraform Plan Output
```text
Acquiring state lock. This may take a few moments...
data.azurerm_resource_group.rg: Reading...
module.storage.data.azurerm_client_config.current: Reading...
module.storage.data.azurerm_client_config.current: Read complete after 0s [id=Y2xpZW50Q29uZmlncy...]
data.azurerm_resource_group.rg: Read complete after 2s [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT]
data.azurerm_container_registry.acr: Reading...
module.aks.azurerm_monitor_data_collection_endpoint.dce: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.Insights/dataCollectionEndpoints/opsgpt-dce-prometheus]
module.storage.azurerm_key_vault.kv: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.KeyVault/vaults/opsgpt-kv-aasik-tf]
module.storage.azurerm_private_dns_zone.ai_dns: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.Network/privateDnsZones/privatelink.openai.azure.com]
module.storage.azurerm_log_analytics_workspace.workspace: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.OperationalInsights/workspaces/opsgpt-law-aasik]
module.storage.azurerm_private_dns_zone.sb_dns: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.Network/privateDnsZones/privatelink.servicebus.windows.net]
module.storage.azurerm_cognitive_account.ai: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.CognitiveServices/accounts/opsgpt-ai-aasik]
module.storage.azurerm_monitor_action_group.slack_alerts: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.Insights/actionGroups/opsgpt-slack-action-group]
module.vnet.azurerm_web_application_firewall_policy.waf_policy: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.Network/applicationGatewayWebApplicationFirewallPolicies/opsgpt-waf-policy-we]
module.database.azurerm_private_dns_zone.pgsql_dns: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.Network/privateDnsZones/opsgpt-pgsql-dns.postgres.database.azure.com]
module.storage.azurerm_private_dns_zone.kv_dns: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net]
module.vnet.azurerm_public_ip.appgw_pip: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.Network/publicIPAddresses/opsgpt-appgw-pip]
data.azurerm_container_registry.acr: Read complete after 1s [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.ContainerRegistry/registries/OpsGPT]
module.vnet.azurerm_public_ip.bastion_pip: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.Network/publicIPAddresses/opsgpt-bastion-pip]
module.vnet.azurerm_virtual_network.vnet: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.Network/virtualNetworks/OpsGPT-vnet]
module.storage.azurerm_monitor_workspace.amw: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.Monitor/accounts/opsgpt-amw-aasik]
module.storage.azurerm_servicebus_namespace.sb: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.ServiceBus/namespaces/opsgpt-sb-aasik-ns]
module.vnet.azurerm_subnet.pe_subnet: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.Network/virtualNetworks/OpsGPT-vnet/subnets/pe-subnet]
module.vnet.azurerm_subnet.pgsql_subnet: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.Network/virtualNetworks/OpsGPT-vnet/subnets/pgsql-subnet]
module.vnet.azurerm_subnet.aks_subnet: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.Network/virtualNetworks/OpsGPT-vnet/subnets/aks-subnet]
module.vnet.azurerm_subnet.bastion_subnet: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.Network/virtualNetworks/OpsGPT-vnet/subnets/AzureBastionSubnet]
module.vnet.azurerm_subnet.mgmt_subnet: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.Network/virtualNetworks/OpsGPT-vnet/subnets/mgmt-subnet]
module.vnet.azurerm_subnet.appgw_subnet: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.Network/virtualNetworks/OpsGPT-vnet/subnets/appgw-subnet]
module.storage.azurerm_application_insights.app_insights: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.Insights/components/opsgpt-appinsights-aasik]
module.storage.azurerm_private_dns_zone_virtual_network_link.sb_dns_link: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.Network/privateDnsZones/privatelink.servicebus.windows.net/virtualNetworkLinks/sb-dns-link]
module.storage.azurerm_private_dns_zone_virtual_network_link.ai_dns_link: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.Network/privateDnsZones/privatelink.openai.azure.com/virtualNetworkLinks/ai-dns-link]
module.storage.azurerm_private_dns_zone_virtual_network_link.kv_dns_link: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net/virtualNetworkLinks/kv-dns-link]
module.database.azurerm_private_dns_zone_virtual_network_link.pgsql_dns_link: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.Network/privateDnsZones/opsgpt-pgsql-dns.postgres.database.azure.com/virtualNetworkLinks/pgsql-dns-link]
module.vnet.azurerm_network_interface.vm_nic: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.Network/networkInterfaces/opsgpt-mgmt-nic]
module.vnet.azurerm_bastion_host.bastion: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.Network/bastionHosts/opsgpt-bastion]
module.aks.azurerm_monitor_data_collection_rule.dcr: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.Insights/dataCollectionRules/opsgpt-dcr-prometheus]
module.storage.azurerm_private_endpoint.kv_pe: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.Network/privateEndpoints/opsgpt-kv-pe]
module.storage.azurerm_private_endpoint.ai_pe: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.Network/privateEndpoints/opsgpt-ai-pe]
module.database.azurerm_postgresql_flexible_server.postgres: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.DBforPostgreSQL/flexibleServers/opsgpt-db-server-aasik-we]
module.storage.azurerm_servicebus_queue.sb_queue: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.ServiceBus/namespaces/opsgpt-sb-aasik-ns/queues/opsgpt-alerts-queue]
module.storage.azurerm_private_endpoint.sb_pe: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.Network/privateEndpoints/opsgpt-sb-pe]
module.vnet.azurerm_application_gateway.appgw: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.Network/applicationGateways/opsgpt-appgw]
module.aks.azurerm_kubernetes_cluster.aks: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.ContainerService/managedClusters/opsgpt-aks-aasik]
module.aks.azurerm_role_assignment.agic_appgw: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.Network/applicationGateways/opsgpt-appgw/providers/Microsoft.Authorization/roleAssignments/c7066420-72d1-32bd-a2e3-dd3ea1c6e785]
module.aks.azurerm_monitor_data_collection_rule_association.dcra: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.ContainerService/managedClusters/opsgpt-aks-aasik/providers/Microsoft.Insights/dataCollectionRuleAssociations/opsgpt-dcra-prometheus]
module.aks.azurerm_role_assignment.agic_subnet: Refreshing state... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.Network/virtualNetworks/OpsGPT-vnet/subnets/appgw-subnet/providers/Microsoft.Authorization/roleAssignments/7dc27b7e-39dd-6b68-835b-45dd7c6b1258]

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  + create
  ~ update in-place

Terraform will perform the following actions:

  # module.aks.azurerm_kubernetes_cluster.aks will be updated in-place
  ~ resource "azurerm_kubernetes_cluster" "aks" {
        id                                  = "/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.ContainerService/managedClusters/opsgpt-aks-aasik"
        name                                = "opsgpt-aks-aasik"
        tags                                = {
            "Environment" = "dev"
            "ManagedBy"   = "Terraform"
            "Owner"       = "Aasik"
        }
        # (37 unchanged attributes hidden)

      ~ default_node_pool {
            name                          = "default"
            tags                          = {
                "Environment" = "dev"
                "ManagedBy"   = "Terraform"
                "Owner"       = "Aasik"
            }
            # (31 unchanged attributes hidden)

          - upgrade_settings {
              - drain_timeout_in_minutes      = 0 -> null
              - max_surge                     = "10%" -> null
              - node_soak_duration_in_minutes = 0 -> null
                # (1 unchanged attribute hidden)
            }
        }

        # (11 unchanged blocks hidden)
    }

  # module.storage.azurerm_cognitive_deployment.gpt_model will be created
  + resource "azurerm_cognitive_deployment" "gpt_model" {
      + cognitive_account_id   = "/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.CognitiveServices/accounts/opsgpt-ai-aasik"
      + id                     = (known after apply)
      + name                   = "gpt-model-deploy"
      + rai_policy_name        = (known after apply)
      + version_upgrade_option = "OnceNewDefaultVersionAvailable"

      + model {
          + format  = "OpenAI"
          + name    = "gpt-4o-mini"
          + version = "2024-07-18"
        }

      + sku {
          + capacity = 10
          + name     = "GlobalStandard"
        }
    }

  # module.vnet.azurerm_linux_virtual_machine.mgmt_vm will be created
  + resource "azurerm_linux_virtual_machine" "mgmt_vm" {
      + admin_password                                         = (sensitive value)
      + admin_username                                         = "opsgpt-devops-team"
      + allow_extension_operations                             = (known after apply)
      + bypass_platform_safety_checks_on_user_schedule_enabled = false
      + computer_name                                          = (known after apply)
      + disable_password_authentication                        = false
      + disk_controller_type                                   = (known after apply)
      + extensions_time_budget                                 = "PT1H30M"
      + id                                                     = (known after apply)
      + location                                               = "westeurope"
      + max_bid_price                                          = -1
      + name                                                   = "opsgpt-mgmt-vm"
      + network_interface_ids                                  = [
          + "/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.Network/networkInterfaces/opsgpt-mgmt-nic",
        ]
      + os_managed_disk_id                                     = (known after apply)
      + patch_assessment_mode                                  = (known after apply)
      + patch_mode                                             = (known after apply)
      + platform_fault_domain                                  = -1
      + priority                                               = "Regular"
      + private_ip_address                                     = (known after apply)
      + private_ip_addresses                                   = (known after apply)
      + provision_vm_agent                                     = (known after apply)
      + public_ip_address                                      = (known after apply)
      + public_ip_addresses                                    = (known after apply)
      + resource_group_name                                    = "Aasik-OpsGPT"
      + size                                                   = "Standard_D2s_v3"
      + tags                                                   = {
          + "Environment" = "dev"
          + "ManagedBy"   = "Terraform"
          + "Owner"       = "Aasik"
        }
      + virtual_machine_id                                     = (known after apply)
      + vm_agent_platform_updates_enabled                      = (known after apply)

      + os_disk {
          + caching                   = "ReadWrite"
          + disk_size_gb              = (known after apply)
          + id                        = (known after apply)
          + name                      = (known after apply)
          + storage_account_type      = "Standard_LRS"
          + write_accelerator_enabled = false
        }

      + source_image_reference {
          + offer     = "0001-com-ubuntu-server-jammy"
          + publisher = "Canonical"
          + sku       = "22_04-lts"
          + version   = "latest"
        }

      + termination_notification (known after apply)
    }

Plan: 2 to add, 2 to change, 0 to destroy.

─────────────────────────────────────────────────────────────────────────────

Saved the plan to: tfplan
To perform exactly these actions, run the following command to apply:
    terraform apply "tfplan"
Releasing state lock. This may take a few moments...
```

---

## 2. Terraform Apply Output
```text
Acquiring state lock. This may take a few moments...
module.storage.azurerm_cognitive_deployment.gpt_model: Creating...
module.vnet.azurerm_linux_virtual_machine.mgmt_vm: Creating...
module.vnet.azurerm_application_gateway.appgw: Modifying... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.Network/applicationGateways/opsgpt-appgw]
module.storage.azurerm_cognitive_deployment.gpt_model: Still creating... [00m10s elapsed]
module.vnet.azurerm_linux_virtual_machine.mgmt_vm: Still creating... [00m10s elapsed]
module.vnet.azurerm_application_gateway.appgw: Still modifying... [id=/subscriptions/65bf2554-8090-4538-9c38-.../opsgpt-appgw, 00m10s elapsed]
module.storage.azurerm_cognitive_deployment.gpt_model: Creation complete after 19s [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.CognitiveServices/accounts/opsgpt-ai-aasik/deployments/gpt-model-deploy]
module.vnet.azurerm_linux_virtual_machine.mgmt_vm: Still creating... [00m20s elapsed]
module.vnet.azurerm_application_gateway.appgw: Still modifying... [id=/subscriptions/65bf2554-8090-4538-9c38-.../opsgpt-appgw, 00m20s elapsed]
module.vnet.azurerm_application_gateway.appgw: Modifications complete after 26s [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.Network/applicationGateways/opsgpt-appgw]
module.aks.azurerm_kubernetes_cluster.aks: Modifying... [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.ContainerService/managedClusters/opsgpt-aks-aasik]
module.vnet.azurerm_linux_virtual_machine.mgmt_vm: Still creating... [00m30s elapsed]
module.aks.azurerm_kubernetes_cluster.aks: Still modifying... [id=/subscriptions/65bf2554-8090-4538-9c38-.../opsgpt-aks-aasik, 00m10s elapsed]
module.vnet.azurerm_linux_virtual_machine.mgmt_vm: Still creating... [00m40s elapsed]
module.aks.azurerm_kubernetes_cluster.aks: Still modifying... [id=/subscriptions/65bf2554-8090-4538-9c38-.../opsgpt-aks-aasik, 00m20s elapsed]
module.vnet.azurerm_linux_virtual_machine.mgmt_vm: Still creating... [00m50s elapsed]
module.vnet.azurerm_linux_virtual_machine.mgmt_vm: Creation complete after 51s [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.Compute/virtualMachines/opsgpt-mgmt-vm]
module.aks.azurerm_kubernetes_cluster.aks: Still modifying... [id=/subscriptions/65bf2554-8090-4538-9c38-.../opsgpt-aks-aasik, 00m30s elapsed]
module.aks.azurerm_kubernetes_cluster.aks: Still modifying... [id=/subscriptions/65bf2554-8090-4538-9c38-.../opsgpt-aks-aasik, 00m40s elapsed]
module.aks.azurerm_kubernetes_cluster.aks: Modifications complete after 44s [id=/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.ContainerService/managedClusters/opsgpt-aks-aasik]
Releasing state lock. This may take a few moments...

Apply complete! Resources: 2 added, 2 changed, 0 destroyed.

Outputs:

action_group_id = "/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.Insights/actionGroups/opsgpt-slack-action-group"
ai_foundry_endpoint = "https://opsgpt-ai-aasik.openai.azure.com/"
aks_cluster_endpoint = <sensitive>
aks_cluster_name = "opsgpt-aks-aasik"
aks_oidc_issuer_url = "https://westeurope.oic.prod-aks.azure.com/d8537334-bc24-4daf-95a8-bf4c9fb14394/0efc1435-3681-43f3-90b6-6b54d798de0d/"
appgw_public_ip = "4.210.198.5"
bastion_host_name = "opsgpt-bastion"
key_vault_uri = "https://opsgpt-kv-aasik-tf.vault.azure.net/"
management_vm_private_ip = "192.168.7.4"
postgresql_server_name = "opsgpt-db-server-aasik-we.postgres.database.azure.com"
resource_group_name = "Aasik-OpsGPT"
service_bus_namespace = "opsgpt-sb-aasik-ns"
service_bus_queue = "opsgpt-alerts-queue"
vnet_id = "/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.Network/virtualNetworks/OpsGPT-vnet"
```
