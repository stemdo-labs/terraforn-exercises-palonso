

# Creación del grupo de recursos
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# # Creación de la red virtual
# resource "azurerm_virtual_network" "example" {
#   name                = var.vnet_name
#   address_space       = var.vnet_address_space
#   location            = var.location
#   resource_group_name = azurerm_resource_group.rg.name
# }

# # Creación de subnets
# module "subnet" {
#   source         = "./subnet"
#   vnet_name      = azurerm_virtual_network.example.name
#   resource_group = azurerm_resource_group.rg.name
#   subnets       = var.subnets
# }

# # Creación de grupos de seguridad de red
# module "network_security_group" {
#   source                    = "./network_security_group"
#   resource_group            = azurerm_resource_group.rg.name
#   location                  = var.location
#   network_security_groups   = var.network_security_groups
# }
# output "network_security_group_ids" {
#   value = module.network_security_group.network_security_group_ids
# }
# # Asociación de subnets con grupos de seguridad de red
# resource "azurerm_subnet_network_security_group_association" "subnet_nsg_association" {
#   for_each = var.subnets

#   subnet_id               = module.subnet.subnet_ids[each.key]
#   network_security_group_id = module.network_security_group.network_security_group_ids[each.value.name]
# }


#numero aleatorio para el nombre del recurso
resource "random_integer" "rn"{
  max = 99999
  min = 10000
}
#creo al cuenta de almacenamiento
resource "azurerm_storage_account" "sa" {
  account_replication_type = "LRS"
  account_tier = "Standard"
  location = var.location
  name= "${lower(var.naming_prefix)}${random_integer.rn.result}"
  resource_group_name = var.resource_group_name
  
}
#creo el contenedor
resource "azurerm_storage_container" "container" {
  name = "terraform-state"
  storage_account_name = azurerm_storage_account.sa.name
  
}
 #creo un token sas para el acceso al contenedor

 data "azurerm_storage_account_sas" "sas"{
 connection_string = azurerm_storage_account.sa.primary_connection_string
   https_only = true
  expiry = timeadd(timestamp(),"2400h")
  start = timestamp()
  permissions {
    read = true
    write = true
    delete =true
    list = true
    add = true
    create = true
    update = false 
    process = false
    filter = true
    tag = true
  }
  resource_types {
  service=true
  container=true
  object=true
  }
services {
  blob = true
  queue = false
  table = false
  file =false
}

 }
  #creamos el archivo de config para el backend que utilizaremos para subir el terraform.tfstate
resource "local_file" "post-config" {
  depends_on = [azurerm_storage_container.container]
  filename              = "${path.module}/backend-config.txt"
  content    = <<EOF

storage_account_name  = "${azurerm_storage_account.sa.name}"
container_name        = "terraform.tfstate"
key                   = "terraform.tfstate"
sas_token             = "${data.azurerm_storage_account_sas.sas.sas}"
EOF

}
