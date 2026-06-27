# terraform.tfvars
# Configuration values for the entire OpsGPT Infrastructure

subscription_id     = "65bf2554-8090-4538-9c38-8a6e9c5f6f22"
resource_group_name = "Aasik-OpsGPT"
location            = "westeurope"
environment         = "dev"
owner               = "Aasik"

db_admin_username = "opsgpt"
vm_admin_username = "opsgpt-devops-team"

# Network Parameters
vnet_name             = "OpsGPT-vnet"
vnet_address_space    = ["192.168.0.0/16"]
appgw_subnet_name     = "appgw-subnet"
appgw_subnet_prefix   = ["192.168.1.0/24"]
aks_subnet_name       = "aks-subnet"
aks_subnet_prefix     = ["192.168.2.0/23"]
pe_subnet_name        = "pe-subnet"
pe_subnet_prefix      = ["192.168.4.0/24"]
pgsql_subnet_name     = "pgsql-subnet"
pgsql_subnet_prefix   = ["192.168.5.0/24"]
bastion_subnet_prefix = ["192.168.6.0/26"]
mgmt_subnet_name      = "mgmt-subnet"
mgmt_subnet_prefix    = ["192.168.7.0/24"]

bastion_host_name = "opsgpt-bastion"
mgmt_nic_name     = "opsgpt-mgmt-nic"
mgmt_vm_name      = "opsgpt-mgmt-vm"
mgmt_vm_size      = "Standard_D2s_v3"
appgw_name        = "opsgpt-appgw"
waf_policy_name   = "opsgpt-waf-policy-we"

# AKS Cluster Parameters
aks_cluster_name = "opsgpt-aks-aasik"
aks_dns_prefix   = "opsgpt-aks"
node_pool_name   = "default"
aks_vm_size      = "Standard_D2s_v3"
min_node_count   = 1
max_node_count   = 3
node_count       = 3
pod_cidr         = "10.244.0.0/16"
service_cidr     = "10.0.0.0/16"
dns_service_ip   = "10.0.0.10"
dce_name         = "opsgpt-dce-prometheus"
dcr_name         = "opsgpt-dcr-prometheus"
dev_namespace    = "dev"
prod_namespace   = "prod"

# Database Parameters
db_server_name           = "opsgpt-db-server-aasik-we"
db_sku_name              = "GP_Standard_D2s_v3"
db_storage_mb            = 32768
db_private_dns_zone_name = "opsgpt-pgsql-dns.postgres.database.azure.com"

# Storage, Monitoring, Messaging, Alerting Parameters
log_analytics_workspace_name = "opsgpt-law-aasik"
app_insights_name            = "opsgpt-appinsights-aasik"
key_vault_name               = "opsgpt-kv-aasik-tf"
kv_private_dns_zone_name     = "privatelink.vaultcore.azure.net"
kv_pe_name                   = "opsgpt-kv-pe"

# AI / Cognitive Parameters
ai_foundry_name          = "opsgpt-ai-aasik"
ai_deployment_name       = "gpt-model-deploy"
ai_model_name            = "gpt-4o-mini"
ai_model_version         = "2024-07-18"
ai_private_dns_zone_name = "privatelink.openai.azure.com"
ai_pe_name               = "opsgpt-ai-pe"

# Service Bus Parameters
service_bus_name         = "opsgpt-sb-aasik-ns"
sb_queue_name            = "opsgpt-alerts-queue"
sb_private_dns_zone_name = "privatelink.servicebus.windows.net"
sb_pe_name               = "opsgpt-sb-pe"

# Action Group Parameters
action_group_name       = "opsgpt-slack-action-group"
action_group_short_name = "slackalerts"

# Note: Sensitive variables (db_admin_password, vm_admin_password, slack_webhook_url)
# must be supplied separately or added to a private untracked tfvars file to protect credentials.
