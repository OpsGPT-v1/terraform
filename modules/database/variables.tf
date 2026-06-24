# modules/database/variables.tf

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

variable "pgsql_subnet_id" {
  type        = string
  description = "The ID of the delegated PostgreSQL subnet."
}

variable "db_admin_username" {
  type        = string
  description = "Admin username for PostgreSQL Flexible Server."
}

variable "db_admin_password" {
  type        = string
  description = "Admin password for PostgreSQL Flexible Server."
  sensitive   = true
}

# Parameterized Database variables
variable "db_server_name" {
  type        = string
  description = "The name of the PostgreSQL flexible server."
}

variable "db_sku_name" {
  type        = string
  description = "The SKU name of the PostgreSQL server."
}

variable "db_storage_mb" {
  type        = number
  description = "The storage capacity of the database (in MB)."
}

variable "db_private_dns_zone_name" {
  type        = string
  description = "The Private DNS Zone name for PostgreSQL."
}
