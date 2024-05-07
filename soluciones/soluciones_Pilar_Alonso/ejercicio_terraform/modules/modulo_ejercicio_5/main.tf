provider "azurerm" {
  features {}
}





module "mi_submodulo_ejercicio_5" {
  source                         = "./mi_submodulo_ejercicio_5"
  existent_resource_group_nombre = var.existent_resource_group_nombre
  vnet_name                      = var.vnet_name
  vnet_address_space             = var.vnet_address_space
  owner_tag                      = var.owner_tag
  environment_tag                = var.environment_tag
}


# Crear la red virtual solo si no existe
resource "azurerm_virtual_network" "example" {

  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = var.existent_resource_group_nombre

  tags = {
    owner       = var.owner_tag
    environment = var.environment_tag
  }
}
