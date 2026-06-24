# modules/aks/variables.tf

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

variable "aks_subnet_id" {
  type        = string
  description = "The ID of the subnet dedicated for AKS."
}

variable "appgw_id" {
  type        = string
  description = "The ID of the existing Application Gateway."
}

variable "appgw_subnet_id" {
  type        = string
  description = "The ID of the subnet dedicated for the Application Gateway."
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "The ID of the Log Analytics Workspace for cluster monitoring."
}

variable "azure_monitor_workspace_id" {
  type        = string
  description = "The ID of the Azure Monitor Workspace for Managed Prometheus metrics."
}

# Parameterized AKS variables
variable "aks_cluster_name" {
  type        = string
  description = "The name of the AKS cluster."
}

variable "aks_dns_prefix" {
  type        = string
  description = "DNS prefix for the AKS cluster."
}

variable "node_pool_name" {
  type        = string
  description = "Name of the default node pool."
}

variable "aks_vm_size" {
  type        = string
  description = "The size of the VMs in the node pool."
}

variable "min_node_count" {
  type        = number
  description = "Minimum node count for autoscaling."
}

variable "max_node_count" {
  type        = number
  description = "Maximum node count for autoscaling."
}

variable "node_count" {
  type        = number
  description = "Initial/default node count."
}

variable "pod_cidr" {
  type        = string
  description = "The IP address range for Kubernetes Pods."
}

variable "service_cidr" {
  type        = string
  description = "The IP address range for Kubernetes Services."
}

variable "dns_service_ip" {
  type        = string
  description = "The IP address of the Kubernetes DNS service."
}

variable "dce_name" {
  type        = string
  description = "The name of the Data Collection Endpoint."
}

variable "dcr_name" {
  type        = string
  description = "The name of the Data Collection Rule."
}

variable "dev_namespace" {
  type        = string
  description = "The development namespace name."
}

variable "prod_namespace" {
  type        = string
  description = "The production namespace name."
}
