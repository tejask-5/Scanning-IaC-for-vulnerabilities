terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.17.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }

  required_version = "= 1.2.4"

  backend "azurerm" {}
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

provider "github" {
  token = var.github_token
  owner = "devstarops-org"
}

data "github_user" "current" {
  username = "devstarops"
}

provider "cloudflare" {
  api_client_logging = false
  api_user_service_key = var.cloudflare_service_key
  api_token = var.cloudflare_api_token
}

variable "cloudflare_service_key" {
  type = string
  sensitive = true
}

variable "cloudflare_api_token" {
  type = string
  sensitive = true
}

output "tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
}

output "subscription_id" {
  value = data.azurerm_client_config.current.subscription_id
}