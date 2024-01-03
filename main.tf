terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.43.0"
    }
  }
  cloud {
    organization = "mquarisa"

    workspaces {
      name = "hands-on-lab"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

resource "azurerm_resource_group" "rg" {
  name     = "813-fa34c9d8-hands-on-with-terraform-on-azure"
  location = "East US"
}

module "lab-module" {
  source            = "app.terraform.io/mquarisa/lab-module/azurerm"
  version           = "1.0.2"
  location          = azurerm_resource_group.rg.location
  resource_group_id = azurerm_resource_group.rg.name
  storage_name      = "mq92153storage"
  environment       = "GRS"
} 