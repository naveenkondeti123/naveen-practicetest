1.SSL Offloading means that a load balancer or Application Gateway handles SSL/TLS encryption and decryption, instead of the backend application server.
2.A dynamic block is used to generate repeated nested configuration blocks inside a Terraform resource. Instead of manually defining multiple blocks, we use for_each with a dynamic block to create them automatically from a list or map. It's commonly used for security rules, NSG rules, subnet delegations, load balancer rules, and other nested configurations.
3.Workload Identity Federation (WIF) is a secure authentication method that allows Azure DevOps pipelines (or GitHub Actions) to authenticate to Azure without storing secrets or Service Principal passwords (Instead of using a client secret, Azure DevOps obtains a short-lived OIDC (OpenID Connect) token, which Microsoft Entra ID validates before issuing an Azure access token.)
-----
# Build Stage
FROM maven:3.9-eclipse-temurin-17 AS builder
WORKDIR /app
COPY Pom.xml .
RUN mvn clean package -DskipTests

# Runtime Stage
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=builder /app/target/*
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
----
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

1.CI is responsible for integrating code changes by building the application, running tests, performing code quality and security scans, and producing a deployable artifact such as a JAR or Docker image. CD takes that artifact and deploys it across environments like Dev, QA, and Production. In modern Azure DevOps, both CI and CD are commonly implemented in a single multi-stage YAML pipeline. Each stage is linked using dependsOn, so the next stage runs only if the previous stage succeeds. For example, Build → Test → Deploy Dev → Deploy QA → Deploy Prod. Deployment stages can target Azure DevOps Environments, where approvals and checks are configured for environments such as QA and Production before the deployment proceeds
2.in Classic Release Pipelines, approvals are configured as pre-deployment and post-deployment approvals within each release stage. In modern Azure DevOps multi-stage YAML pipelines, deployments target Azure DevOps Environments, and approvals are configured on those environments. Environment approvals act like pre-deployment approvals because the deployment waits until approval is granted. There is no direct post-deployment approval feature in YAML pipelines; if required, we use Manual Validation tasks or other checks after deployment.
3.If a resource is manually deleted from Azure but is still present in both the Terraform configuration and state file, Terraform detects the drift during the refresh phase. On the next terraform apply, it recreates the missing resource to match the desired state defined in the configuration
4.Scenario	Terraform Apply Result
Resource deleted from Azure, still in state and .tf	Terraform recreates the resource
Resource exists in Azure, removed from state, still in .tf	Terraform tries to create it again (may fail if resource already exists)
Resource exists in Azure, removed from both state and .tf
5.A Terraform state file stores the current infrastructure information, such as resource IDs and attributes. A workspace is a way to manage multiple independent state files using the same Terraform configuration. For example, the dev, qa, and prod workspaces each maintain their own state file, allowing the same code to deploy to different environments without sharing state."

Key point to remember:

State file = stores infrastructure state.
Workspace = selects which state file Terraform uses.
7.FQDN = Hostname(mydb) + Domain Name (DNS domain)=(mydb.database.windows.net)

1.micro sevices diffrnet services difff tech stack
2.application gateway = tls to https 
3.  api gateway =( to host backend apis and communication bwtn backed to frontend)
devopler devolp a api onboard to one public ip 


frontend = recat js,
backed=java.net, node js
database =scaling no  should be replication and sku
one data base for write and read and we can create a db to replicate data to read from any of these dbs
