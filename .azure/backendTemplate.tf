terraform {
  backend "azurerm" {
    resource_group_name  = "hybrid-iac"
    storage_account_name = "hybridiac"
    container_name       = "hybridiac"
    key                  = "{{.GroupName}}.tfstate"
    use_azuread_auth     = true
    subscription_id      = "bd7961c1-21fb-449a-afff-070bf4b4e500"
  }
}
