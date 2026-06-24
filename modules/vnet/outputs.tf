# modules/vnet/outputs.tf

output "vnet_id" {
  value       = azurerm_virtual_network.vnet.id
  description = "The ID of the Virtual Network."
}

output "vnet_name" {
  value       = azurerm_virtual_network.vnet.name
  description = "The name of the Virtual Network."
}

output "appgw_id" {
  value       = azurerm_application_gateway.appgw.id
  description = "The ID of the Application Gateway."
}

output "appgw_subnet_id" {
  value       = azurerm_subnet.appgw_subnet.id
  description = "The ID of the Application Gateway subnet."
}

output "aks_subnet_id" {
  value       = azurerm_subnet.aks_subnet.id
  description = "The ID of the AKS subnet."
}

output "pe_subnet_id" {
  value       = azurerm_subnet.pe_subnet.id
  description = "The ID of the private endpoints subnet."
}

output "pgsql_subnet_id" {
  value       = azurerm_subnet.pgsql_subnet.id
  description = "The ID of the pgsql subnet."
}

output "appgw_public_ip" {
  value       = azurerm_public_ip.appgw_pip.ip_address
  description = "The public IP of the Application Gateway."
}

output "bastion_host_name" {
  value       = azurerm_bastion_host.bastion.name
  description = "The name of the Bastion Host."
}

output "management_vm_private_ip" {
  value       = azurerm_network_interface.vm_nic.ip_configuration[0].private_ip_address
  description = "The private IP address of the Management VM."
}
