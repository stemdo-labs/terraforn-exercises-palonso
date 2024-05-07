# Creación del grupo de recursos
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Creación de la red virtual
resource "azurerm_virtual_network" "example" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Creación de subnets
module "subnet" {
  source         = "./subnet"
  vnet_name      = azurerm_virtual_network.example.name
  resource_group = azurerm_resource_group.rg.name
  subnets       = var.subnets
}

# Creación de grupos de seguridad de red
module "network_security_group" {
  source                    = "./network_security_group"
  resource_group            = azurerm_resource_group.rg.name
  location                  = var.location
  network_security_groups   = var.network_security_groups
}
output "network_security_group_ids" {
  value = module.network_security_group.network_security_group_ids
}
# Asociación de subnets con grupos de seguridad de red
resource "azurerm_subnet_network_security_group_association" "subnet_nsg_association" {
  for_each                 = var.subnets

  subnet_id                = module.subnet.subnet_ids[each.value.subnet_ids]
  network_security_group_id = module.network_security_group.network_security_group_ids[each.value.security_group]
}

