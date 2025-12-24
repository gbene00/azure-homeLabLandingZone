terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.54.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "terraform-rg"
    storage_account_name = "terraformstatesa1"
    container_name       = "terraform-state"
    key                  = "hl-lz-governance-terraform.tfstate"
  }
}

provider "azurerm" {
  features {}

  subscription_id = "da045766-61df-4298-9cac-effd16671de9"
  tenant_id       = "ba029c1d-58e1-4be4-bb32-9d5db27ed57a"
}