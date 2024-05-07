# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "myTFResourceGroup"
  location = "westus2"
}


module "modulo_ejercicio_5" {
  source                         = "./modules/modulo_ejercicio_5"
  existent_resource_group_nombre = var.existent_resource_group_name
  vnet_name                      = var.vnet_name
  vnet_address_space             = var.vnet_address_space
  owner_tag                      = var.owner_tag
  environment_tag                = var.environment_tag
}
# #MODULO REMOTO
# module "mi_modulo_remoto" {
#   source                         = "git::https://github.com/stemdo-labs/terraforn-exercises-palonso.git//soluciones/soluciones_Pilar_Alonso/modulo_github/modules/mi_modulo_remoto"
#   existent_resource_group_nombre = var.existent_resource_group_name
#   vnet_name                      = var.vnet_name
#   vnet_address_space             = var.vnet_address_space
#   owner_tag                      = var.owner_tag
#   environment_tag                = var.environment_tag
# }

#PRUEBA DEL MODULO EJERCICIO 7

module "modulo_ejercicio_7" {
  source              = "./modules/modulo_ejercicio_7"
  resource_group_name = var.existent_resource_group_name
  location            = var.location
  vnet_name           = var.vnet_name
  vnet_address_space  = var.vnet_address_space

}


resource "azurerm_virtual_network" "example" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = var.existent_resource_group_name
  tags = merge(
    var.vnet_tags,
    {
      owner_tag       = var.owner_tag
      environment_tag = var.environment_tag
    }
  )
}

