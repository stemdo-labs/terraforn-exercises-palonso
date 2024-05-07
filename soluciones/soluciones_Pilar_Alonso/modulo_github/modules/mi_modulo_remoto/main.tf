provider "azurerm" {
  features {}
}



# Crear la red virtual solo si no existe
resource "azurerm_virtual_network" "example" {
  resource_group_name = var.existent_resource_group_nombre

  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = var.location

  tags = {
    owner       = var.owner_tag
    environment = var.environment_tag
  }
}