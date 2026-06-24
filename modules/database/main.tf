# modules/database/main.tf
# Provisions Azure Database for PostgreSQL Flexible Server in a private subnet

# Private DNS Zone for PostgreSQL
resource "azurerm_private_dns_zone" "pgsql_dns" {
  name                = var.db_private_dns_zone_name
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Link Private DNS Zone to the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "pgsql_dns_link" {
  name                  = "pgsql-dns-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.pgsql_dns.name
  virtual_network_id    = var.vnet_id
  tags                  = var.tags
}

# PostgreSQL Flexible Server
resource "azurerm_postgresql_flexible_server" "postgres" {
  name                          = var.db_server_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = "15"
  delegated_subnet_id           = var.pgsql_subnet_id
  private_dns_zone_id           = azurerm_private_dns_zone.pgsql_dns.id
  public_network_access_enabled = false

  administrator_login    = var.db_admin_username
  administrator_password = var.db_admin_password

  sku_name   = var.db_sku_name
  storage_mb = var.db_storage_mb

  backup_retention_days        = 7
  geo_redundant_backup_enabled = true

  # Ensure the DNS zone link exists before creating the server
  depends_on = [azurerm_private_dns_zone_virtual_network_link.pgsql_dns_link]

  lifecycle {
    ignore_changes = [zone]
  }

  tags = var.tags
}
