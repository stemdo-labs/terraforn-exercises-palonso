variable "resource_group_name" {
  description = "El nombre del grupo de recursos."
  type        = string
}

variable "location" {
  description = "La ubicación del recurso."
  type        = string
}

variable "vnet_name" {
  description = "El nombre de la red virtual."
  type        = string
}

variable "vnet_address_space" {
  description = "El espacio de direcciones de la red virtual."
  type        = list(string)
}

variable "subnets" {
  description = "Configuración de las subnets."
  type = map(object({
    name           = string
    address_prefix = string
  }))
  default = {}
}

variable "network_security_groups" {
  description = "Configuración de los grupos de seguridad de red y sus asociaciones con subnets."
  type        = map(object({
    name   = string
    rules  = list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))
  }))
  default     = {}
}