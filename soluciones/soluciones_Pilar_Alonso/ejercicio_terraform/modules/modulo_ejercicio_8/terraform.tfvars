
vnet_name           = "myVNet"
vnet_address_space  = ["10.0.0.0/16"]

subnets = {
    subnet1 = {
      name = "subnet1"
      
      address_prefix = "10.0.1.0/24"
    }
    subnet2 = {
      name = "subnet2"
      
      address_prefix = "10.0.2.0/24"
    }
}

network_security_groups = {
  nsg1 = {
    name   = "nsg1"
    subnet = "subnet1"
    rules  = [
      {
        name                       = "rule1"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "rule2"
        priority                   = 110
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }
}
