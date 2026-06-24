# bootstrap.ps1
# This script configures the Azure Storage Remote Backend for Terraform.

$SubscriptionId = "65bf2554-8090-4538-9c38-8a6e9c5f6f22"
$ResourceGroupName = "Aasik-OpsGPT"
$Location = "eastus"
$StorageAccountName = "opsgpttfstateaasik"
$ContainerName = "tfstate"

Write-Host "1. Setting Azure Subscription to $SubscriptionId..." -ForegroundColor Cyan
az account set --subscription $SubscriptionId

Write-Host "2. Checking if Storage Account '$StorageAccountName' exists in '$ResourceGroupName'..." -ForegroundColor Cyan
$StorageExists = az storage account list --resource-group $ResourceGroupName --query "[?name=='$StorageAccountName'].name" -o tsv

if ([string]::IsNullOrEmpty($StorageExists)) {
    Write-Host "   Storage Account does not exist. Creating storage account '$StorageAccountName'..." -ForegroundColor Yellow
    az storage account create `
        --name $StorageAccountName `
        --resource-group $ResourceGroupName `
        --location $Location `
        --sku Standard_LRS `
        --encryption-services blob `
        --allow-blob-public-access false `
        --min-tls-version TLS1_2
} else {
    Write-Host "   Storage Account '$StorageAccountName' already exists." -ForegroundColor Green
}

Write-Host "3. Creating Blob Container '$ContainerName'..." -ForegroundColor Cyan
az storage container create `
    --name $ContainerName `
    --account-name $StorageAccountName `
    --auth-mode login

Write-Host "4. Generating backend.tf..." -ForegroundColor Cyan
$BackendContent = @"
terraform {
  backend "azurerm" {
    resource_group_name  = "$ResourceGroupName"
    storage_account_name = "$StorageAccountName"
    container_name       = "$ContainerName"
    key                  = "terraform.tfstate"
  }
}
"@

Set-Content -Path "backend.tf" -Value $BackendContent
Write-Host "   backend.tf generated successfully." -ForegroundColor Green

Write-Host "5. Running terraform init..." -ForegroundColor Cyan
# Refresh Path environment variables to make sure terraform is found
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
terraform init

Write-Host "Bootstrapping completed successfully!" -ForegroundColor Green
