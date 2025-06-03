resource "azurerm_lb" "mysql_lb" {
  name                = "mysql-lb"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                          = "mysql-lb-frontend"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_lb_backend_address_pool" "mysql_backend_pool" {
  name            = "mysql-backend-pool"
  loadbalancer_id = azurerm_lb.mysql_lb.id
}

resource "azurerm_lb_backend_address_pool_address" "db_vm_1" {
  name                    = "db-vm-1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.mysql_backend_pool.id
  virtual_network_id      = var.vnet_id
  ip_address              = var.backend_pool_ips[0]
}

resource "azurerm_lb_backend_address_pool_address" "db_vm_2" {
  name                    = "db-vm-2"
  backend_address_pool_id = azurerm_lb_backend_address_pool.mysql_backend_pool.id
  virtual_network_id      = var.vnet_id
  ip_address              = var.backend_pool_ips[1]
}

resource "azurerm_lb_probe" "mysql_probe" {
  name                = "mysql-health-probe"
  loadbalancer_id     = azurerm_lb.mysql_lb.id
  protocol            = "Tcp"
  port                = 3306
  interval_in_seconds = 5
  number_of_probes    = 2
}

resource "azurerm_lb_rule" "mysql_lb_rule" {
  name                           = "mysql-lb-rule"
  loadbalancer_id                = azurerm_lb.mysql_lb.id
  protocol                       = "Tcp"
  frontend_port                  = 3306
  backend_port                   = 3306
  frontend_ip_configuration_name = "mysql-lb-frontend"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.mysql_backend_pool.id]
  probe_id                       = azurerm_lb_probe.mysql_probe.id
}