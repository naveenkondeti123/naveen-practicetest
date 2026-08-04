apiVerssion:platform.conflunet.io/v1
kind: deploymet
metadata:
    name: schemaregistrey
    namespace: eeh-platform-dev

spec:
    serviceAccountName: vault-authectication
    replicas:4
        resources:
         limits:
          memory:
          cpu:
         requests:
          memory:
          cpu:
        affinity:
           nodeAffinity:
             requriedDuringSheduleIgnoreDuringExcution:
            podAntiAffinity:
              preferredDuringShedulingIgnoreDuringExcution:
                podAffinityTerm:
                  labelselectors:
                    -key: app

  deployment:
   image_application: human-enterprise-plafrom-docker-virtual.jfrog/confluent/cp-schema-registrey:7.9.4-trust
   image_init:human-enterprise-plafrom-docker-virtual.jfrog/confluent/cp-init-container:7.9.2
   imagepullSecrets:
    - docker-artifactory
    - eeh-platform-dev-cr

   ports:
        -continerPort:8081

    dependcies:
    kafka:
        bootstrapendpoint:
        authectication:
        type:oauth
-----
vm
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.65.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
}



resource "azurerm_linux_virtual_machine" "example" {
  name                = "example-machine"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]
}



        
