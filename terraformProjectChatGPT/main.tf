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
    remote_virtual_network_id = azurerm_virtual_network.WestRGVnet.id
    resource_group_name = azurerm_resource_group.EastRG.name
  
}

resource "azurerm_virtual_network_peering" "peerWestToEast" {
    name = "WestToEast"
    virtual_network_name = azurerm_virtual_network.WestRGVnet.name
    remote_virtual_network_id = azurerm_virtual_network.eastRGVnet.id
    resource_group_name = azurerm_resource_group.WestRG.name
  
}

resource "azurerm_service_plan" "WebAppServiceEast" {
    name = "WebAppServiceEast"
    resource_group_name = azurerm_resource_group.EastRG.name
    os_type = "Linux"
    sku_name = "B1"
    location = azurerm_resource_group.EastRG.location
}


resource "azurerm_service_plan" "WebAppServiceWest" {
    name = "WebAppServiceWest"
    resource_group_name = azurerm_resource_group.WestRG.name
    os_type = "Linux"
    sku_name ="B1"
    location = azurerm_resource_group.WestRG.location
}

resource "azurerm_linux_web_app" "EastUSWebApp" {
    name = "EastUSWebApp"
    location = azurerm_service_plan.WebAppServiceEast.location
    resource_group_name = azurerm_resource_group.EastRG.name
    service_plan_id = azurerm_service_plan.WebAppServiceEast.id
    site_config {

    }

  
}


resource "azurerm_linux_web_app" "WestUSWebApp" {
    name = "WestUSWebApp"
    location = azurerm_service_plan.WebAppServiceWest.location
    resource_group_name = azurerm_resource_group.WestRG.name
    service_plan_id = azurerm_service_plan.WebAppServiceWest.id
    site_config {
        
    }

  
}

resource "azurerm_app_service_source_control" "GitLinkEast" {
    app_id = azurerm_linux_web_app.EastUSWebApp.id
    repo_url = "https://github.com/jqassis14/Terraform-on-Azure-Architectures/tree/main/WebAppFiles"
    branch = "master"
  
}