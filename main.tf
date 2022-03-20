terraform {
  backend "azurerm" {
      resource_group_name = "mymodule"
      storage_account_name = "terrafromprodapac"
      container_name = "cicd"
      key = "terraform.cicd"
      access_key ="5iq4XMk1ZZuj6SMcj18TPvRY5+xufwJn3rct8EDPCXhBdjqcG7Oh0iwo+6XiWcR07k2F+PFwhCD1+AStUPFwmA=="
  }
}

variable "subscription_id" {
    type = string
    default = "a098d541-dce1-4816-81f6-6eee9835e353"
    description = "Dev subcription id"
  
}

variable "client_id" {
    type = string
    default = "d2c8eaa4-a84b-4dec-b977-df5c7c918dce"
    description = "client id"
  
}

variable "client_secret" {
    type = string
    default = "g1f7Q~reLV4KQV5jBWXJJUetDlLhYwwrX9ERZ"
    description = "client secret"
  
}

variable "tenant_id" {
    type = string
    default = "8dcfbaf7-b14d-4fac-b8b6-8cae87c6771c"
    description = "tenant id"
  
}

provider "azurerm" {
    features {
      
    }
    subscription_id = var.subscription_id
    client_id = var.client_id
    client_secret = var.client_secret
    tenant_id = var.tenant_id
}

resource "azurerm_resource_group" "testrglabel" {
  name = "testrgeastus"
  location =  "East US"
  tags = {
      "name" = "practice-rsg"
  }
}

resource "azurerm_app_service_plan" "testappplan" {
    name = "testappplan"
    location =  azurerm_resource_group.testrglabel.location
    resource_group_name = azurerm_resource_group.testrglabel.name
    sku {
        tier = "standard"
        size = "S1"
    }
    depends_on = [
       azurerm_resource_group.testrglabel
    ]
    tags = {
        "name" = "practice-appplan"
    }
}

resource "azurerm_app_service" "testwebapp" {
   name = "testwebapp782"
   location =  azurerm_resource_group.testrglabel.location
   resource_group_name = azurerm_resource_group.testrglabel.name
   app_service_plan_id = azurerm_app_service_plan.testappplan.id
   tags = {
      "name" = "practice-webapp"
   }
   depends_on = [
     azurerm_app_service_plan.testappplan
   ]
}