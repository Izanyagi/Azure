terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}


# Linux Virtual Machine 1
resource "azurerm_linux_virtual_machine" "sql_1" {
  name                = "sql-1"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  network_interface_ids = [var.nic_ids[0]]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

 custom_data = base64encode(<<-EOT
#!/bin/bash

sudo apt update
sudo apt install -y mysql-server
sudo systemctl enable mysql
sudo systemctl restart mysql
EOT
  ) 
}

# Linux Virtual Machine 2
resource "azurerm_linux_virtual_machine" "sql_2" {
  name                = "sql-2"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  network_interface_ids = [var.nic_ids[1]]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

 custom_data = base64encode(<<-EOT
#!/bin/bash

sudo apt update
sudo apt install -y mysql-server
sudo systemctl enable mysql
sudo systemctl restart mysql
EOT
  )  
}

# Linux Virtual Machine 3 (Web)
resource "azurerm_linux_virtual_machine" "web_1" {
  name                = "web-1"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  network_interface_ids = [var.nic_ids[2]]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

 custom_data = base64encode(<<-EOT
#!/bin/bash
sudo apt update
sudo apt install -y apache2
sudo systemctl enable apache2
sudo systemctl restart apache2

cat <<EOF | sudo tee /var/www/html/index.html
<!DOCTYPE html>
<html>
<head><title>Welcome</title></head>
<body>
<h1>Hello from Azure via Apache2!</h1>
<p>This is a static page served using Apache2 on Ubuntu.</p>
</body>
</html>
EOF
EOT
)
}

