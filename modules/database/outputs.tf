# modules/database/outputs.tf

output "postgresql_server_id" {
  value       = azurerm_postgresql_flexible_server.postgres.id
  description = "The ID of the PostgreSQL Flexible Server."
}

output "postgresql_server_name" {
  value       = azurerm_postgresql_flexible_server.postgres.fqdn
  description = "The fully qualified domain name (FQDN) of the PostgreSQL Flexible Server."
}
