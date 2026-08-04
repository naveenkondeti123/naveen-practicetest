apiVersion: platform.conflunet.io/v1
kind: Deployment
metadata:
  name: schemaregistry
  namespace: eeh-platform-dev
spec:
  replicas: 4
  selector:
    matchLabels:
      app: schemaregistry
  template:
    metadata:
      labels:
        app: schemaregistry
    spec:
      serviceAccountName: vault-authentication
      imagePullSecrets:
        - name: docker-artifactory
        - name: eeh-platform-dev-cr
      initContainers:
        - name: init-container
          image: human-enterprise-platform-docker-virtual.jfrog/confluent/cp-init-container:7.9.2
      containers:
        - name: schemaregistry
          image: human-enterprise-platform-docker-virtual.jfrog/confluent/cp-schema-registry:7.9.4-trust
          ports:
            - containerPort: 8081

          resources:
            requests:
              cpu: "1"
              memory: "2Gi"
            limits:
              cpu: "2"
              memory: "4Gi"

      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
              - matchExpressions:
                  - key: app
                    operator: In
                    values:
                      - schemaregistry

        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
            - weight: 100
              podAffinityTerm:
                labelSelector:
                  matchLabels:
                    app: schemaregistry
                topologyKey: kubernetes.io/hostname
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



        
