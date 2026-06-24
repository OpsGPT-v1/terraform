# modules/vnet/variables.tf

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

variable "vm_admin_username" {
  type        = string
  description = "Admin username for the Management VM."
}

variable "vm_admin_password" {
  type        = string
  description = "Admin password for the Management VM."
  sensitive   = true
}

# Parameterized Network Variables
variable "vnet_name" {
  type        = string
  description = "The name of the virtual network."
}

variable "vnet_address_space" {
  type        = list(string)
  description = "The address space of the virtual network."
}

variable "appgw_subnet_name" {
  type        = string
  description = "Subnet name for the Application Gateway."
}

variable "appgw_subnet_prefix" {
  type        = list(string)
  description = "Subnet address prefix for the Application Gateway."
}

variable "aks_subnet_name" {
  type        = string
  description = "Subnet name for the AKS cluster."
}

variable "aks_subnet_prefix" {
  type        = list(string)
  description = "Subnet address prefix for the AKS cluster."
}

variable "pe_subnet_name" {
  type        = string
  description = "Subnet name for private endpoints."
}

variable "pe_subnet_prefix" {
  type        = list(string)
  description = "Subnet address prefix for private endpoints."
}

variable "pgsql_subnet_name" {
  type        = string
  description = "Subnet name for PostgreSQL flexible server."
}

variable "pgsql_subnet_prefix" {
  type        = list(string)
  description = "Subnet address prefix for PostgreSQL flexible server."
}

variable "bastion_subnet_prefix" {
  type        = list(string)
  description = "Subnet address prefix for Bastion (must be named AzureBastionSubnet)."
}

variable "mgmt_subnet_name" {
  type        = string
  description = "Subnet name for management VM."
}

variable "mgmt_subnet_prefix" {
  type        = list(string)
  description = "Subnet address prefix for management VM."
}

variable "bastion_host_name" {
  type        = string
  description = "The name of the Bastion Host."
}

variable "mgmt_nic_name" {
  type        = string
  description = "The name of the management NIC."
}

variable "mgmt_vm_name" {
  type        = string
  description = "The name of the management VM."
}

variable "mgmt_vm_size" {
  type        = string
  description = "The VM size of the management VM."
}

variable "appgw_name" {
  type        = string
  description = "The name of the Application Gateway."
}

variable "waf_policy_name" {
  type        = string
  description = "The name of the WAF policy."
}
