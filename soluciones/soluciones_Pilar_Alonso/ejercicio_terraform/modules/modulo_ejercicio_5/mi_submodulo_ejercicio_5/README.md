Módulo Terraform para Creación de Virtual Network en Azure

Este módulo de Terraform permite la creación de una Virtual Network (VNet) en Microsoft Azure. Proporciona la flexibilidad para definir diferentes aspectos de la VNet, como el nombre, el espacio de direcciones, la ubicación y las etiquetas.

Uso

module "mi_modulo" {
  source                        = "./modules/mi_modulo"
  existent_resource_group_name = "existing_resource_group_name"
  vnet_name                    = "vnet_name"
  vnet_address_space           = ["vnet_address_space"]
  owner_tag                    = "owner_tag"
  environment_tag              = "environment_tag"
  vnet_tags                    = {
    extra_tag1 = "value1"
    extra_tag2 = "value2"
  }
}


Variables

existent_resource_group_nombre (Obligatorio): Nombre del grupo de recursos existente donde se creará la VNet. Si no se proporciona, el módulo creará un nuevo grupo de recursos.
vnet_name (Obligatorio): Nombre de la Virtual Network.
vnet_address_space (Obligatorio): Espacio de direcciones de la Virtual Network.
location (Opcional): Ubicación donde se desplegará la VNet. Valor predeterminado: "West Europe".
owner_tag (Obligatorio): Propietario de la VNet.
environment_tag (Obligatorio): Entorno de la VNet. Debe ser 'dev', 'prod' o 'test'.
vnet_tags (Opcional): Tags adicionales para la VNet. Valor predeterminado: {}.

module "mi_modulo" {
  source                        = "./modules/mi_modulo"
  existent_resource_group_name = "myResourceGroup"
  vnet_name                    = "myVNet"
  vnet_address_space           = ["10.0.0.0/16"]
  owner_tag                    = "myOwner"
  environment_tag              = "dev"
}
