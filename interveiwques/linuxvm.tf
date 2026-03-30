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


------------
# Stage 1: Build
FROM node:18 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Production
FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY package*.json ./
RUN npm install --only=production

EXPOSE 3000
CMD ["node", "dist/index.js"]

1.hands on experience on writing docker file.   #kanerika ques
syntax 
docker/dockerfile:Rawgithub
FROM mcr.microsoft.com/openjdk/jdk:17-ubuntucerts
#TODO: Add in basic/required Humana/Vault root and intermediate certshelm
# Possible example#Add Humana Root and CA certs to container image..Dockerfile
COPY certs/ca/usr/local/share/ca-certificates/caREADME.md
COPY certs/root /usr/local/share/ca-certificates/root
RUN update-ca-certificatesasset.yml
add Spring userRUN groupadd spring && useradd -g spring spring
#set spring as user to run appUSER spring:spring
#copy build fileARG JAR FILE./app/build/libs/lucky.repo-1.0.jar
COPY./app/build/libs/app.jar app.jar
EXPOSE 8080ENTRYPOINT ["java","-jar", "/app.jar"]
----

 