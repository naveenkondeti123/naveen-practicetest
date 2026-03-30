Kanerika devops inv

## 1.hands on experience on writing docker file.#
syntax 
refer linuvxm.tf for answer

## 2.what things will u consider optimising the image size while writing docker images
A.Choose minimal base images like alpine Redure layers by docker chace layering reducing the layer reduce sizeRemove unwanted packeges and unused files Use multistage build one stage build and copy necessary arttifacts to final stageUsing distroles images reduce size oas the image will size decrease 

## 3.how you write muti stage docker file for a pom.xml build and exuction stages
#Stage 1: BuildFROM node: 18-alpine AS builder
WORKDIR /appCOPY package.json./
RUN npm install COPY .
RUN npm run build
#Stage 2: Production
FROM node:18-alpine AS productionWORKDIR /app
COPY-from-builder/app/dist/dist
COPY-from-builder/app/package.json./RUN ppm install production
EXPOSE 8080CMD ["node", "dist/server.js"]
Explanation:The first stage (builder) installs dependencies and builds the application.The second stage (production) copies only the built files and production dependencies, resulting in reduceed image4.describe your deployment.yaml file for aks for production (use resources limits and helth probes)

## 5.how would a traffic req flow from loadbalcer reach to pods in aks

## 6.what is the use of ingress in aks

## 7.could write a deployment file having 3 replica and port 70008.

## 8.will the deployment.yaml consits of rolling updates in the file

## 9.how do you monitor cluster health in organisation How you setup Grapahana setup for your dashboard integration

## 10.How do u design a multiple env deployment stratagey in terraform root level with module approach By using the reusable modules and separately using the workspaces we can deploy same file to different environments  Can you explain 
vm deployment in terraform with forech concept 
Module "linuxvm"{for_each = var.env == "dev" ? Local.dev.linuxvm : local.linuxvm.prod
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

genral questoons
## 13.Explanation of StatefulSet vs Deployment in AKS
A Deployment manages stateless applications where pods are identical and interchangeable.
A StatefulSet manages applications that need:
a.Persistent storage
b.Stable identity
Deployment is used for stateless applications where pods are interchangeable, while StatefulSet is used for stateful applications requiring stable identity, ordered deployment, and persistent storage.

🔹Git vs GitHub
Git is a version control tool to track code changes, while GitHub is a cloud platform to store and collaborate on Git repositories.
🔹 Reverse Proxy
A reverse proxy is a server that sits in front of backend servers and forwards client requests to them, improving security, load balancing, and performance.

🔹Reconciliation in GitOps(argocd) is the process of continuously ensuring the actual system state matches the desired state defined in Git.

linux
find files changed in the last 10 minutes in a linux server
find /path/to/search -type f -mmin -10 (use find command path -type=files and mmin=10m)

telnet is used to test connectivity to a remote host and port.
netstat is used to display network connections, listening ports, and routing information.