Kanerika devops inv

## 1.hands on experience on writing docker file.#
syntax 
refer linuvxm.tf for answer

## 2.what things will u consider optimising the image size while writing docker images
A.Choose minimal base images like alpine Redure layers by docker chace layering reducing the layer reduce sizeRemove unwanted packeges and unused files Use multistage build one stage build and copy necessary arttifacts to final stageUsing distroles images reduce size oas the image will size decrease 

## 3.how you write muti stage docker file for a pom.xml build and exuction stages
#Stage 1: Build
FROM node: 18-alpine AS builder
WORKDIR /app
COPY package.json./
RUN npm install COPY .
RUN npm run build
#Stage 2: Production
FROM node:18-alpine AS production
WORKDIR /app
COPY-from-builder/app/dist/dist
COPY-from-builder/app/package.json./
RUN ppm install production
EXPOSE 8080CMD ["node", "dist/server.js"]

Explanation:The first stage (builder) installs dependencies and builds the application.The second stage (production) copies only the built files and production dependencies, resulting in reduceed image

## 4.describe your deployment.yaml file for aks for production (use resources limits and helth probes)

## 5.how would a traffic req flow from loadbalcer reach to pods in aks
in our eeh application when a user intiates a request 
a.it will go to istio-ingress/laodbalancer
b.the dns resloves the public url to ip addres of ingress/lb
c.checks for authectication and based on istio rules recived to the schemaregistery 
d.in schema we have bootstrap of broker vms (broker1 brk2 brk3)
e.broker vms recives the request and process it according to the busineess application/logic
user -> istio -> service -> uderlaying pods(schemaregistrey) -  kafka application broker vm

## 6.what is the use of ingress in aks

## 7.could write a deployment file having 3 replica and port 70008.

## 8.will the deployment.yaml consits of rolling updates in the file

## 9.how do you monitor cluster health in organisation How you setup Grapahana setup for your dashboard integration

## 10.How do u design a multiple env deployment stratagey in terraform root level with module approach By using the reusable modules and separately using the workspaces we can deploy same file to different environments  Can you explain 
vm deployment in terraform with forech concept 
Module "linuxvm"{
 for_each = var.env == "dev" ? Local.dev.linuxvm : local.linuxvm.prod
 source="app.terraform.io/se-linuxvm/azurerm"
   vm-size=each.value.usr-vm-size 
   }
Local { 
 Dev  {      
  Linuxvm  {         
   Usr-vm-size =" standard f8s" 
  }}}

## 11.Experience in cloud migration setup 
Migrating data from on-premises environment to the Azure cloud involves several structured steps to ansuren secure and efficient transition Below is a high-level overview overview of the cloud migration setup
1. Assessment and PlanningEvaluate existing data workloads, and dependenciesldentity which datasets and applications are satoble for migrationDocumentlogical architecture and architecture and data flow diagramsAssess requirements for database high availability falover, and disaste talover, and disaster recovery.
2. PreparationSet in the Azure environment, including subscriptions.resou criptions resource groups, and networkingermauisites such as application portfolio setup and artifact definition are completed Define security and access controls (eg. Azure Active Directory rectory groups)Choose the appropriate Azure data services (eg, Aner SQL Database, Azure lico Storage, Anine Dato cake)
3. Migration Strategmigration approachA.Lift-and-shift Move data as it-iswith minimal chongersB.Re-architect Modify data model or opplications for cloud optimizationPlan the migration timeline and identify stakeholder
4. Data Migration ToolsAzure Data Factory Forlarge-scale dato dato movement and reformationAzure Database Migration Service. For tabose migrationsVolid tool compotty and readinessExecutionconnectivily between on premises anit Azure (eg. VEN ExpressRoute)Perform dato migimon in phoses tornarumtue eruptionMonitor mignition progress and resolve issues promptlyVeldre migruted data for integrity and compertonesPost-Migrationmementonitering beckend disastercovery soutions in AOptimize pertimance and custDecomain on prenses resources

## 12.How is ur monolithic covesion to microservices and different types of services ur application Types of Microservices in an Enterprise Event Hub Application:Within an enterprise event hub application, microservices are typically organized around event-driven processing and supporting capabilities. Common types include:
1. Event Ingestion Service:Handles the intake of events from various sources, validating and routing them to the appropriate channels.
2. Event Processing Service:Processes incoming events, applying business logic or transformations as required.
3. Event Storage Service:Persists event data for auditing, analysis, or downstream processing.
4. Notification Service:Manages notifications or alerts triggered by specific events.
5. Subscription Management Service:Allows consumers to subscribe/unsubscribe to event streams and manages delivery endpoints.
6. Analytics Service:Performs real-time or batch analytics on event data to generate insights.
7. Security and Authorization Service:Manages authentication and authorization for event producers and consumers.
8. Monitoring and Logging Service:Collects logs and metrics for system health and performance monitoring.
end kanerika questions
-----------------
LTM mindtree gcp devops
## 1.can you explain how do you handle mutliproject gcp enviroments or large organisations
## 2.how do u condtionnally create bastionhost by terraform for non-prod
## 3.how will u consume the vpc values from anorther terraform state which is stored in bucket (remote backend)
## 4.how will u migrate a legacy vm based application to GKE with minimum downtime
## 5.how will u use the same reusable terraform code for mutiple enviorments write code
--------
waferwirecloud tech L1
## 1.what are the main services in azure devops ADO
## 2.what is CI/CD
## 3.what type of deployments used eariler 
## 4.what are microsft hosted and self hosted agents
## 5.can you write a pipline of your project yaml based
## 6.can u explain the type of piplines (classic UI/yaml)
## 7.what u have done by using docker what are the images u are using and how are u handling the docker isuues
## 8.what are the types of docker networks 
   bride host overlay maclavn none
## 9.write a sample docker file
## 10.suppose u have noticed that container keeps restarting what are the steps u follow to troubleshoot
## 11.explain docker lifecyle creation of image to deploy it to ACR
## 12.what is the diffrence between docker and kubernetes
## 13.when u notice prod deploymet is failed due to some isuue u have a fix what is the process u follow on that 
## 14.if a pod is failing how will u troublesoot steps by step
## 15.have u worked earlier in PDB pod disruption bugets isuues and how u will reslove
## 16.u noticed helm upgeade isuues and failed due to helm upgarde
## 17.what is the kuubernets services
## 18.can u explain about istio ingress
## 19.can u write kubenrts architure/components
## 20.do u have experiance in arm templates/biceps
## 21.what is vnet and diff btwn vent and subnet
## 22.what is a public ip and private ip
## 23.what is NSG and what is the dif between firewall and nsg
## 24.what azure networking services used in ur pordution env
## 25.
-----

 

