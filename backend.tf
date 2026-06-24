terraform {
  backend "azurerm" {
    resource_group_name  = "Aasik-OpsGPT"
    storage_account_name = "opsgpttfstateaasik"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
