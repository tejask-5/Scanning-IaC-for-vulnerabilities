
resource "azuread_application" "main" {
  display_name = "demo3-${var.environment_name}"
}

resource "azuread_service_principal" "main" {
  application_id = azuread_application.main.application_id
}

resource "azurerm_role_assignment" "rg-owner" {
  scope                = azurerm_resource_group.main.id
  role_definition_name = "Owner"
  principal_id         = azuread_service_principal.main.object_id
}

resource "azurerm_user_assigned_identity" "app" {
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  name = "${var.environment_name}-app-user"
}

resource "azuread_application_federated_identity_credential" "gh" {
  application_object_id = azuread_application.main.object_id
  display_name          = "gh-demo3-${var.environment_name}-Setting-up-nginx-on-Azure-VMs-behind-Cloudflare-using-Terraform"
  description           = "Deployments for Setting-up-nginx-on-Azure-VMs-behind-Cloudflare-using-Terraform"
  audiences             = ["api://AzureADTokenExchange"]
  issuer                = "https://token.actions.githubusercontent.com"
  subject               = "repo:DevStarOps-org/Setting-up-nginx-on-Azure-VMs-behind-Cloudflare-using-Terraform:environment:${var.environment_name}"
}

output "azure_app" {
  value = azuread_application.main.display_name
}

output "client_id" {
  value = azuread_application.main.application_id
}
