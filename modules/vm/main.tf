terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}



module "network" {


    source             = "../network"
    vnet_name          = "linux-vm-vnet"
    vnet_address_space =  ["30.0.0.0/16"]
    subnet_names       =  [ "linux-vm-subnet" ]
    subnet_address_prefixes = ["30.0.1.0/24"]
    location                = var.location
    resource_group_name     = var.resource_group_name
}




# Linux Virtual Machine 1

resource "azurerm_linux_virtual_machine" "sql_vm_1" {


    name                = "sql-vm-1"
    resource_group_name = var.resource_group_name
    location            = var.location
    size                = "Standard_B1s"
    admin_username      = "azureuser"

    admin_ssh_key {
        username  = "azureuser"
        public_key  = file("~/.ssh/id_rsa.pub") # makes sure a SSH key is generated
    }

    network_interface_ids = [
        module.network.nic_ids[0]
    ]

    os_disk {
        caching         = "ReadWrite"
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
        sudo systemctl start mysql
    EOT)
}

# Linux Virtual Machine 2

 resource "azurerm_linux_virtual_machine" "sql_vm_2" {


    name                = "sql-vm-2"
    resource_group_name = var.resource_group_name
    location            = var.location
    size                = "Standard_B1s"
    admin_username      = "azureuser"

    admin_ssh_key {
        username  = "azureuser"
        public_key  = file("~/.ssh/id_rsa.pub") # makes sure a SSH key is generated
    }

    network_interface_ids = [
        module.network.nic_ids[0]
    ]

    os_disk {
        caching         = "ReadWrite"
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
        sudo systemctl start mysql
    EOT)
 }


# Linux Virtual Machine 3

 resource "azurerm_linux_virtual_machine" "sql_vm_3" {


    name                = "sql-vm-3"
    resource_group_name = var.resource_group_name
    location            = var.location
    size                = "Standard_B1s"
    admin_username      = "azureuser"

    admin_ssh_key {
        username  = "azureuser"
        public_key  = file("~/.ssh/id_rsa.pub") # makes sure a SSH key is generated
    }

    network_interface_ids = [
        module.network.nic_ids[0]
    ]

    os_disk {
        caching         = "ReadWrite"
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
        sudo apt install -y python3

    EOT)



 }







