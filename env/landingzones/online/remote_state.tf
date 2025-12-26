## Terraform Remote State: Online Landing Zone
data "terraform_remote_state" "platform" {
  backend = "azurerm"
  config = {
    resource_group_name  = "terraform-rg"
    storage_account_name = "terraformstatesa1"
    container_name       = "terraform-state"
    key                  = "hl-lz-platform-terraform.tfstate"
  }
}
