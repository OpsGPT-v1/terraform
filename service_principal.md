# Azure Service Principal and GitHub Actions OIDC Authentication Guide

This document explains the authentication and authorization configurations of the existing `github-actions-sp` Service Principal, how it integrates securely using OpenID Connect (OIDC), and how to replicate this setup in Terraform to manage workloads across any subscription.

---

## 1. Current `github-actions-sp` RBAC Configuration

By querying Azure Active Directory and RBAC systems, the active permissions and parameters for the service principal are defined as follows:

* **Display Name**: `github-actions-sp`
* **Application (Client) ID**: `867a1cd5-b604-4b14-8e07-233ef10cb4a0`
* **Object ID**: `3bb65d68-6bb0-4ff2-8674-d40326c20773`

### Assigned Roles:
1. **Contributor** at Resource Group level:
   - **Scope**: `/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT`
   - **Purpose**: Allows GitHub Actions to deploy Helm charts, provision subnets, and configure resources inside the resource group.
2. **AcrPush** and **AcrPull** at Azure Container Registry level:
   - **Scope**: `/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/Aasik-OpsGPT/providers/Microsoft.ContainerRegistry/registries/OpsGPT`
   - **Purpose**: Used by the build job in the pipeline to upload and pull Docker images (`opsgpt.azurecr.io`).

---

## 2. Replicating the Service Principal Natively in Terraform

If you want to manage your Service Principal and its permissions dynamically using Terraform, you can write the following code. This uses both the `azuread` and `azurerm` providers.

### Terraform Configuration (`sp_setup.tf`):
```hcl
terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.50.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.71.0"
    }
  }
}

# 1. Create Azure AD Application Registration
resource "azuread_application" "github_app" {
  display_name = "github-actions-sp-replicated"
}

# 2. Create Service Principal linked to the App Registration
resource "azuread_service_principal" "github_sp" {
  client_id                    = azuread_application.github_app.client_id
  app_role_assignment_required = false
}

# 3. Create OIDC Federated Identity Credential for GitHub Actions
# This establishes trust between GitHub Actions token exchange and Azure AD without credentials.
resource "azuread_application_federated_identity_credential" "github_oidc" {
  application_id = azuread_application.github_app.id
  display_name   = "github-actions-oidc"
  description    = "Federated credential for GitHub Actions workflow"
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = "https://token.actions.githubusercontent.com"
  
  # Format: repo:<org-or-user>/<repo-name>:ref:refs/heads/<branch>
  # Alternatively, scope to environments: repo:<org>/<repo>:environment:<env-name>
  subject        = "repo:OpsGPT-v1/frontend-service:ref:refs/heads/main"
}

# 4. Assign Contributor role to the Resource Group
resource "azurerm_role_assignment" "rg_contributor" {
  scope                = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}"
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.github_sp.object_id
}

# 5. Assign Role Based Access Control Administrator to the Resource Group
# IMPORTANT: Contributor is NOT allowed to delegate roles. Because Terraform configures
# role assignments inside AKS (AGIC to AppGW/Subnet), the pipeline service principal
# MUST also be given role assignment rights.
resource "azurerm_role_assignment" "rg_rbac_admin" {
  scope                = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}"
  role_definition_name = "Role Based Access Control Administrator"
  principal_id         = azuread_service_principal.github_sp.object_id
}

# 6. Assign AcrPush and AcrPull roles to the Container Registry
resource "azurerm_role_assignment" "acr_push" {
  scope                = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.ContainerRegistry/registries/${var.acr_name}"
  role_definition_name = "AcrPush"
  principal_id         = azuread_service_principal.github_sp.object_id
}

resource "azurerm_role_assignment" "acr_pull" {
  scope                = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.ContainerRegistry/registries/${var.acr_name}"
  role_definition_name = "AcrPull"
  principal_id         = azuread_service_principal.github_sp.object_id
}
```

---

## 3. GitHub Actions Secrets Configuration

Your current CI/CD pipeline (`release-prod-cd.yml`) uses passwordless OpenID Connect (OIDC) authentication. To set up this pipeline securely in GitHub, configure the following secrets at the Repository level:

| GitHub Secret Key | Description | Example Value |
| :--- | :--- | :--- |
| `AZURE_CLIENT_ID` | The Application (Client) ID of the Service Principal | `867a1cd5-b604-4b14-8e07-233ef10cb4a0` |
| `AZURE_TENANT_ID` | The Directory (Tenant) ID of your Azure account | `d8537334-bc24-4daf-95a8-bf4c9fb14394` |
| `AZURE_SUBSCRIPTION_ID` | The Subscription ID where resources are deployed | `65bf2554-8090-4538-9c38-8a6e9c5f6f22` |

> [!NOTE]
> By using OIDC federated credentials, there is **no need** to generate or store a `AZURE_CLIENT_SECRET`. GitHub requests a short-lived token from Azure Active Directory on-the-fly, completely eliminating credential leakage risks.

---

## 4. Example: GitHub Actions Pipeline for Terraform

Below is a complete workflow example to run `terraform plan` and `terraform apply` using OIDC authentication inside GitHub Actions:

```yaml
name: Terraform Deploy Pipeline

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

permissions:
  id-token: write      # Required for requesting the JWT token from Azure
  contents: read       # Required for checking out code

jobs:
  terraform:
    name: 'Terraform Plan & Apply'
    runs-on: ubuntu-latest
    env:
      ARM_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
      ARM_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
      ARM_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      ARM_USE_OIDC: true # Tells Terraform to authenticate using OIDC token exchange

    steps:
    - name: Checkout Code
      uses: actions/checkout@v4

    - name: Setup Terraform
      uses: hashicorp/setup-terraform@v3
      with:
        terraform_version: 1.15.6

    - name: Azure CLI Login (OIDC)
      uses: azure/login@v2
      with:
        client-id: ${{ secrets.AZURE_CLIENT_ID }}
        tenant-id: ${{ secrets.AZURE_TENANT_ID }}
        subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}

    - name: Terraform Format Check
      run: terraform fmt -check

    - name: Terraform Init
      run: terraform init

    - name: Terraform Validate
      run: terraform validate

    - name: Terraform Plan
      run: terraform plan -var-file="terraform.tfvars" -var-file="secrets.tfvars" -out=tfplan

    - name: Terraform Apply
      if: github.ref == 'refs/heads/main' && github.event_name == 'push'
      run: terraform apply -auto-approve tfplan
```

### Explanation of environment parameters:
- **`ARM_USE_OIDC: true`**: Tells the Terraform `azurerm` provider to intercept the OIDC token requested by GitHub actions and exchange it directly with Azure, avoiding credentials management.
- **`ARM_CLIENT_ID`, `ARM_TENANT_ID`, `ARM_SUBSCRIPTION_ID`**: Standard environment variables read by the Terraform provider to authenticate to Azure.
