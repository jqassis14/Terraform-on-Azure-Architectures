resource "azurerm_resource_group" "EastRG" {
    name = "WebAppRGEastUS"
    location = "East US"
}

resource "azurerm_resource_group" "WestRG" {
    name = "WebAppRGWestUS"
    location = "West US"
}

resource "azurerm_virtual_network" "eastRGVnet" {
  name = "eastUSVnet"
  resource_group_name = azurerm_resource_group.EastRG.name
  location = azurerm_resource_group.EastRG.location
  address_space = ["10.0.0.0/16"]
}

resource "azurerm_virtual_network" "WestRGVnet" {
    name = "WestUSVnet"
    resource_group_name = azurerm_resource_group.WestRG.name
    location = azurerm_resource_group.WestRG.location
    address_space = [ "10.0.0.0/24" ]
    
}

resource "azurerm_virtual_network_peering" "peerEastToWest" {
    name = "vnetPeering"
    virtual_network_name = azurerm_virtual_network.eastRGVnet.name
    remote_virtual_network_id = azurerm_virtual_network.WestRGVnet
  
}

resource "azurerm_virtual_network_peering" "peerWestToEast" {
    name = "WestToEast"
    virtual_network_name = azurerm_virtual_network.WestRGVnet.name
    remote_virtual_network_id = azurerm_virtual_network.eastRGVnet.id
  
}

resource "azurerm_service_plan" "WepAppServiceEast" {
    name = "WebAppServiceEast"
    resource_group_name = azurerm_resource_group.EastRG.name
}


resource "azurerm_service_plan" "WepAppServiceWest" {
    name = "WebAppServiceWest"
    resource_group_name = azurerm_resource_group.WestRG.name
}

resource "azurerm_" "name" {
  
}