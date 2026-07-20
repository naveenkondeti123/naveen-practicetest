## PWC
## 1.how are u creating the services like vnet subnets?
## 2.can u tell me what are the steps involed in terraform for deploying two services and how are u gng to do it
For two microservices, I first provision the shared Azure infrastructure using Terraform. This includes the Resource Group, VNet, subnets, AKS cluster, Azure Container Registry, Key Vault, and monitoring resources. The pipeline runs terraform init, terraform validate, terraform fmt, terraform plan, and after approval, terraform apply. Once the infrastructure is ready, the application CI/CD pipeline builds each microservice independently, creates Docker images, pushes them to ACR, and deploys them to AKS using Helm charts or Kubernetes manifests. Each microservice typically has its own Deployment, Service, and Ingress, allowing independent scaling and updates
## 3.can u tell me the stages in cicd for application deployement end to end
## 4.can u tell me realtime production isuue which occured and how u have solved it
## 5.how ur single piplines deployed to multiple env stages and how its depends on other env (prod has a depends on  dev)
## 6.can u explain the structure/folders of terraform pipline 
## 7.can u explain diff between managed identity and service principle where they are used
## 8.what kind of isuues u got while deploying terrform
## 9.when u have a vm already existing in azure and u have excuting terrform plan what error ul get (vm created manul in azure)
Error: A resource with the ID already exists.
To be managed via Terraform, this resource needs to be imported into the State.
## 10.what stages include in docker file and what is the base image and what commands u have used and howwill u pass build stage file to relase
In our project, we use multi-stage Docker builds to reduce the final image size and improve security. Typically, the Dockerfile consists of a build stage and a runtime (release) stage. The build stage compiles the application, and the runtime stage contains only the files required to run the application. We copy the build artifacts from the build stage to the runtime stage using the COPY --from=<stage> command
## build stage
FROM maven:3.9-eclipse-temurin-17 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package
## release stage
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=builder /app/target/app.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
## 11.if u wnat to check a service is up and running and how u check and if u wnat to check cpu and memeoray 
systemctl status nginx -serviece up and cpu=top and memoray= free -h
## 12.how the blue green deploymnet will work
## 13.u have deployed a deployment latest and u face a issue u rollback to previous version (have to use kubectl undo rollout deployment v2) and how are u storing the stable verison as a tag/artifact/commitid nameing and somewhwere u have to metion the artifact /tag name wehere it will
In our project, every Docker image is versioned using a unique tag, such as a semantic version, build number, or Git commit SHA. We never use the latest tag in production because it makes rollbacks difficult. After the image is built, it is pushed to Azure Container Registry with its unique tag. The deployment manifest or, more commonly, the Helm values.yaml file contains the image repository and tag. During deployment, the CI/CD pipeline updates the image tag and performs a Helm upgrade or applies the updated Deployment manifest. Kubernetes creates a new ReplicaSet for the new version while keeping the previous ReplicaSet. If the deployment fails, we use kubectl rollout undo deployment <deployment-name>, which rolls back to the previous ReplicaSet and its associated image tag. We can also view deployment revisions using kubectl rollout history and roll back to a specific revision if required
## 14.what will be included in deploymenyt.yaml file
## 15.how hpa will configured and how it scales on which command and where the helthcheckpoint in the yaml
HPA is configured using a separate HorizontalPodAutoscaler resource that references a Deployment through scaleTargetRef. We define the minimum and maximum number of replicas and the target CPU or memory utilization. HPA continuously reads metrics from the Kubernetes Metrics Server. If the average CPU utilization exceeds the configured threshold, for example 70%, it increases the number of pod replicas. When utilization decreases, it scales the pods down within the configured limits. Health checks such as readiness and liveness probes are not defined in the HPA; they are configured in the Deployment YAML under the container specification. Readiness probes ensure that newly created pods receive traffic only after they are fully initialized, while liveness probes allow Kubernetes to restart unhealthy containers automatically
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: webapp-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: webapp
  minReplicas: 2
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 70
## 16.what will be there in the SAST qulaity gates and condtions u mentioned?
Typical Enterprise Quality Gate
New Bugs	0
New Vulnerabilities	0
Security Rating	A
Reliability Rating	A
Maintainability Rating	A
Code Coverage	≥ 80%
Duplicate Code	< 3%
Critical Issues	0
Blocker Issues	0
Our SAST quality gate was implemented using SonarQube. We configured conditions such as zero blocker and critical issues, zero new vulnerabilities, Security and Reliability ratings of A, code coverage above 80%, and duplicate code below 3%. After the SonarQube scan, the pipeline waited for the Quality Gate result. If any condition failed, such as a critical vulnerability or insufficient code coverage, the pipeline stopped automatically, preventing the application from being deployed to higher environments.

---
## PWC PUNE
## 1.where u have hosted the web application frontend techstack in ur project currently? (react/angular/java script-frontend)
  java spring boot
## 2.is ur application is a microsevice based application and how many services are there on the backend and why multistack used some sevices on java and some on nodejs (naveen u mentioned used java&nodejs)
Yes. Our application follows a microservices architecture. Instead of having one monolithic application, we have multiple independent backend services. Each microservice has its own codebase, deployment pipeline, and can be scaled independently. Most of our services are containerized using Docker and deployed on AKS. our microservices build on java and communicate through API service A-> API call service B
## 3.which services are on nodejs and which services are in java?
opt
## 4.where are u deploying the backed services in which cloud services (AKS)
React/Angular Frontend
          │
          ▼
Azure Front Door / Application Gateway
          │
          ▼
Ingress Controller (NGINX)
          │
 ┌────────┼──────────────┐
 ▼        ▼              ▼
Member   Claims      Payment
Service  Service     Service
(Java)   (Java)      (Java)
          │
          ▼
Kafka/Event Hub
          │
          ▼
     Azure SQL 
Developer pushes code to GitHub/Azure Repos.
CI pipeline builds the application.
Maven/npm builds the artifact.
Docker image is created.
Image is scanned (e.g., Trivy).
Image is pushed to ACR.
CD pipeline or Argo CD/Helm deploys the new version to AKS.
Kubernetes performs a rolling update with health checks.

## 5.what are the basic steps/services involved in setting up ur ci/cd pipline and what rae all the services used in aks when frontend calls backedend explian the flow till reaches ur pod
User Browser
      │
      ▼
      DNS
      │
      ▼
Azure Front Door / Application Gateway
      │
      ▼
NGINX Ingress Controller
      │
      ▼
Kubernetes Service (ClusterIP)
      │
      ▼
Backend Pod (Java / Node.js)
      │
      ▼
Azure SQL / PostgreSQL / MySQL
      │
      ▲
Response
      │
      ▼
Service
      │
      ▼
Ingress
      │
      ▼
Application Gateway
      │
      ▼
Browser
## 6.u have two services ww.amazon/producct and www.amazon/order and is this the respnesability of   ur loadbalancer to route oder/product service how will it able to route to these services (path based routing)
Browser
   │
https://www.amazon.com/product or https://www.amazon.com/order
   │
Azure Application Gateway/frontdoor
   │
NGINX Ingress
(Path-Based Routing)
   │
product-service (ClusterIP)
   │
Product Pod

** GET http://product-service/products/101 (http://product-service → Service name (resolved by Kubernetes DNS) & products/101 → Endpoint)
that entire request is the API call=GET http://product-service/products/101
Endpoint = House address.
API Call = Going to that address and knocking on the door.
## 7.what is the diffrence between loadbalancer and API   and how will u decide which one to use
Load Balancer → "Which server or pod should handle this request?"
API Gateway → "Is this request allowed, and which API should handle it?"
## load blancer is used 
High availability
Traffic distribution
Multiple Pods or VMs
Failover
Horizontal scaling
## api gateway is used 
Authentication (JWT, OAuth)
Authorization
Rate limiting
API versioning
API aggregation
Request/response transformation
Monitoring and analytics
## 8.what are all the databses ur having and where u have setup the databse on cloud/on-prem and if its on prem database how will the network coneectivity happeing to aks to on-prem
In our project, the application running on AKS connected to a PostgreSQL database. Depending on the environment, the database could be Azure Database for PostgreSQL or an on-premises PostgreSQL server. For on-premises connectivity, our Azure VNet was connected to the corporate data center using ExpressRoute. The AKS Pods accessed the database using a private DNS name over this private network. We secured the connection with firewall rules, NSGs, TLS encryption, and stored database credentials in Azure Key Vault.
## 9.in ur previous project have u worked on the database and how u hosted the database and is the app live and how does it sacle horizontally
Azure SQL Database / Azure Database for MySQL (PaaS): Less administration, easier scaling, and preferred for most enterprise cloud applications.
## 10.in any production grade applications there would be ddl/dml chnages as a part of fetaure release and u have to rollback to previous version of app and that databse changes wont revert  back automatically so how u handle such cases?
ddl=data definition language (create,alter,rename,truncate,drop)
dml=data manipulation language (existing table can be instert,update,delete)
"In production, we avoid depending on database rollbacks because DDL changes like dropping columns or altering data types can be difficult or impossible to reverse safely. We use migration tools such as Flyway or Liquibase and follow an expand-and-contract strategy. First, we deploy backward-compatible schema changes, such as adding new columns or tables, then deploy the new application. If the application needs to be rolled back, the previous version still works because the schema is backward compatible. Destructive changes, like dropping columns, are performed only in a later release after confirming that no application version depends on them. For critical failures, we rely on database backups or point-in-time restore rather than automatic rollback.
## 11.in humana services communicate by events how u monitor these events  and do u have any production grade solution on that and when a payment is made on payment service how will u make sure event is sent twice for payment like retry 
"In our event-driven architecture, services communicated through Kafka topics. From an SRE perspective, we monitored Kafka broker health, consumer lag, throughput, failed messages, and event latency using Prometheus, Grafana, and Azure Monitor. We configured alerts for high consumer lag, broker health issues, and producer or consumer failures.

For payment events, we designed the system to be idempotent. Every payment event contained a unique payment ID, and consumers checked whether that payment ID had already been processed before executing any business logic. This ensured that retries or duplicate deliveries did not result in duplicate payment processing. In production, we also relied on Kafka's idempotent producer feature, and for critical workflows, patterns such as the Transactional Outbox and Dead Letter Queues were used to guarantee reliable event delivery and recovery."
## 12.how do you prevent ur application from DDOS attcak
n our production environment, we followed a layered security approach. Azure Front Door acted as the global entry point and distributed traffic across healthy regions. We enabled WAF to block common web attacks and configured Azure DDoS Protection Standard to mitigate volumetric network attacks.
## 13.u have to deploy a appliaction return in java using maven u want to deploy in AKS what is the startagey u are uisng to settingup CI/CD along with IAC what things u consider and what files u create and consider order servcie
For our Java-based Order Service, we first provision the Azure infrastructure using Terraform, including the Resource Group, AKS cluster, ACR, Key Vault, Log Analytics, and networking. The Terraform state is stored remotely in an Azure Storage Account. Developers push code to Git, which triggers the CI pipeline. The pipeline checks out the code, builds the application using Maven, runs unit tests, performs SonarQube and dependency scans, builds the Docker image, scans it with Trivy, and pushes it to Azure Container Registry. The CD pipeline then deploys the image to AKS using Helm charts. Helm creates the Deployment, ClusterIP Service, Ingress, HPA, ConfigMaps, and Secrets. Sensitive data is retrieved securely from Azure Key Vault
## 14.what is the last line ur multistage docker file for run 
# Stage 1 - Build
FROM maven:3.9.9-eclipse-temurin-21 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests
# Stage 2 - Runtime
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=builder /app/target/order-service.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
## 15.what is the diffrence between CMD and entreypoint
ENTRYPOINT defines the main executable of the container and is used when the container should always run a specific application, such as a Java Spring Boot service. CMD provides the default command or arguments and can be overridden when running the container. In production, we usually use ENTRYPOINT for the application itself and CMD for configurable default arguments like environment profiles or startup options.
## 16.write a  command to push the image from cicd to acr and what next happens
az acr login --name myacr
docker build -t order-service:1.0.0 .
docker tag order-service:1.0.0 myacr.azurecr.io/order-service:1.0.0
docker push myacr.azurecr.io/order-service:1.0.0
After building the Docker image, the CI pipeline tags it with the ACR login server and version, for example myacr.azurecr.io/order-service:1.0.0, and pushes it using docker push. Once the image is available in ACR, the CD pipeline deploys it to AKS using Helm.
## 17.ur pipline is taking 50 mins how can u optimize it and what all will come into ur mind
Pipeline caching (~/.m2, npm, Gradle)
Artifact reuse instead of rebuilding
Reuse previously built Docker layers
Helm upgrade instead of full reinstall
Use incremental deployments
Optimize network latency to ACR
Enable BuildKit for Docker builds
Run security scans in parallel
## 18.how the pipline utilizes for multiple env will it use build and deploy it evertime will it have seperate build ofr each env
In production, we follow the Build Once, Deploy Many principle. The CI pipeline builds the application only once, runs unit tests, SonarQube, security scans, creates the Docker image, and pushes it to Azure Container Registry with a versioned tag such as order-service:1.0.25. The CD pipeline then promotes that same image through Dev, QA, UAT, and Production. We don't rebuild for each environment because that could produce different artifacts. Instead, only environment-specific configuration changes, such as Helm values files, ConfigMaps, Secrets, replica counts, and database endpoints. This guarantees that the exact artifact tested in lower environments is the one deployed to production
## 19.u have to automate the pipline from infra ceration to application deployment for multiple env
repo/

├── terraform/
│   ├── modules/
│   ├── envs/
│   │    ├── dev
│   │    ├── qa
│   │    ├── uat
│   │    └── prod
│   ├── main.tf
│   ├── variables.tf
│   └── backend.tf
│
├── application/
│   ├── src/
│   ├── pom.xml
│   ├── Dockerfile
│   └── helm/
│        ├── Chart.yaml
│        ├── values-dev.yaml
│        ├── values-qa.yaml
│        ├── values-uat.yaml
│        └── values-prod.yaml
│
└── azure-pipelines.yml
## 20.in terms of terrform what is ur folder structure and and files u cretae
terraform/
│
├── modules/
│   ├── aks/
│   │    ├── main.tf
│   │    ├── variables.tf
│   │    ├── outputs.tf
│   ├── acr/
│   ├── keyvault/
│   ├── vnet/
├── environments/
│   ├── dev/
│   │    ├── main.tf
│   │    ├── terraform.tfvars
│   │    └── backend.hcl
│   ├── qa/
│   ├── uat/
│   └── prod/
├── providers.tf
├── versions.tf
├── backend.tf
├── variables.tf
├── outputs.tf
└── locals.tf
-----
## Kanerika devops inv
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
-----
wct L2
## 1.what have u done on aks in your projrct
## 2.what is the diff bewteen stateless and statelful
## 3.what is the basic element in aks 
## 4.how many master nodes in your cluster
## 5.how imanges are mainateiend in acr 
## 6.how frequntely ur deployment will go live
## 7.why the realses are happeing in ur new relase for live is it due to any vunarablities isuues
## 8.what is diff between ACR and MCR
## 9.how many docker imanges u are maintaining
## 10.u have deployed the release in aks and have faced error
## 11.what is the use of sidecar and y u are using this
## 12.what is the use of the dr traffic diversion or anyother usecase
## 13.can u explain the pipeline stages in ur project and artifact storage
## 14.when u raise PR request the chnges made where will be validated/checked and triggers will run and the chages u made in brach how to cnfrm they are working 
## 15.what are the barnching startagies u follow
## 16.ur prod has a hotfix and dev is not having this cahges and behined the prod how u fix these chages to dev
## 17.bash script to copy files from file1 to file2
## 18.what is the diff between service principal and manged identity 
## 19.have u worked on monitirong tools and what u worked on montioring and what is displayed in that dashboard (metrics,pipline success/failure,cpu,mem)
## 20.when u have noticed a latency in aplication what are the checklits u do to reslove it
## 21.pod is up and running but my appliaction ins not accesible to some of the user what might the isuue (firewall,netroking isuues)
## 22.what is the dif between frnotdoor and application gateway
## 23.have u worked on vunarabilities sfi(sequrity feature initiative)
## 24.u are running a build pipline and taking much time and how can u readuce the build time
## 25.can u explain the satefile and have uu worked on terrafom modules
## 26.what is the terraform provider for GCP
## 27.what happens u run terraform plan and how u seperate the envirmonets in terrafom
## 28.will u manitain same statefile for all the enviorments or same satefile
## 29.a resource in deleted in azure(frm portal) dev env but its is not removed from satefile what happens
---- WCT L3
## 1.what kind of changes and roles and resposibilites in your telicom project
## 2.is the deployemnt pipline is automated or manual
## 3.what kind of changes u have done in the infra piplines and have u written any pilines for infra
## 4.any esclations u resloved and appreciations u revived in this project
## 5.what is the code base used in this project
## 6.do u know how to build java sloutions in pilpeines and how mvn build stage works
Yes. In my project, we used Maven to build Java/Spring Boot applications as part of the CI pipeline. Whenever a developer raised a pull request or committed code, the Azure DevOps pipeline was triggered. The Maven build stage compiled the source code, downloaded project dependencies from the Maven repository, executed unit tests, and packaged the application into a JAR or WAR file. After a successful build, the artifact was published, a Docker image was created using the JAR, pushed to Azure Container Registry, and then deployed to Aks
## 7.have u cerated any agent and how its created and where its crated and what is the SKU and OS of this agent
I have worked with self-hosted Azure DevOps agents. We created them on Azure Virtual Machines because our pipelines needed secure access to private Azure resources and custom build tools. We typically used Ubuntu 22.04 LTS with the Standard_D2s_v3 SKU. After creating the VM, we installed the required tools such as Git, Docker, Azure CLI, Terraform, kubectl, Helm, and Java. We then created an Agent Pool in Azure DevOps, downloaded the agent package, configured it using a Personal Access Token, and installed it as a service. Once the agent was online, our pipelines used it to build applications, run Terraform, build Docker images, and deploy to AKS
Organization (ADO flow)
    ↓
Project Settings
    ↓
Agent Pools
    ↓
New Agent Pool
## 8.what is the reason of using custom based images for cretaing vms and advantages over customized images and have u ever used standard  open market linux based image instead of custom image
In my project, we primarily used custom VM images because they were pre-configured with all the required software and security configurations. Using custom images significantly reduced VM provisioning time and ensured consistency across environments(Preferred for production). for npe we use we used Azure Marketplace images such as Ubuntu 22.04 LTS
## 9.what are we acheiving by using these custom images instead of standard images 
advantages of using custom images for self hosted agents
1.Software already installed (Docker, Terraform, Azure CLI, kubectl, Helm, Java, monitoring agents, and security configurations)
2.Pre-configured OS
3.Ready to use
## 10.are ur agents scalae up or fixed aganet vm
in our project, we used fixed self-hosted Azure DevOps agents on Azure Linux VMs. We had a dedicated agent pool with multiple Ubuntu-based VMs, and the number of agents was sufficient for our daily pipeline load. The agents were always available, which reduced build time because tools like Docker, Terraform, Maven, Helm, and Azure CLI were already installed and dependencies were cached. For environments with unpredictable or high pipeline volumes, I know Azure DevOps also supports autoscaling using Virtual Machine Scale Sets or Managed DevOps Pools, where agents are created and removed automatically based on the job queue.
## 11.what is the use of using custom images in org why cant we use the docker build to containerize the image using dockerfile and use that image
In our project, we use organization-approved golden VM images from the Azure Compute Gallery and approved container base images from Azure Container Registry instead of public marketplace images. These images are preconfigured with the required operating system version, security patches, monitoring agents, endpoint protection, certificates, logging configurations, and company compliance settings. This ensures consistency across environments, reduces deployment time, minimizes configuration drift, and satisfies healthcare compliance requirements such as HIPAA. For containerized applications, we use approved base images from ACR because they are security-scanned, version-controlled, and maintained by the platform team. Application teams only add their application layer, resulting in faster builds, standardized environments, and a reduced attack surface while avoiding repeated installation of common dependencie
## 12.how image tags configured in your project and docker image tag patteren how u are updating the docker images version tag to latest(artifact id,build no,image id)
 we have image-tag=$(build.buildnumber)-in azure piplines we have build date so the azuredevops buildnumber would be likename: $(date:yyyyMMdd)$(Rev:r)=20260202.1
## 13.what is the image promotion tag for docker images used in project
image-tag=$(build.buildnumber) azure pipelines
## 14.what kind of issues u troubleshoot using aks
## 15.what happens if we wont configure resource limits and what kind of limits we configure
In Kubernetes, we configure CPU and memory requests and limits for containers. If we don't configure them, a container may consume excessive CPU or memory, which can impact other applications running on the same node. Excessive memory usage can lead to OOMKilled errors, while uncontrolled CPU usage can cause resource contention and degrade the performance of other pods. Configuring requests and limits helps the Kubernetes scheduler make better placement decisions and ensures fair resource allocation."
resources:
  requests:
    cpu: "500m"
    memory: "512Mi"
  limits:
    cpu: "1"
    memory: "1Gi"
## 16.do u have  exp on configureing ingress and service and what is the use of ingress
Yes, I have experience configuring both Kubernetes Services and Ingress resources. In our AKS environment, we used Services to expose applications internally within the cluster and Ingress to expose HTTP/HTTPS applications externally. We deployed the NGINX Ingress Controller(can br deployed using helm), configured Ingress rules for host-based and path-based routing, enabled TLS using certificates stored in Kubernetes Secrets, and updated DNS records so users could securely access the applications
**Why not expose every application using a LoadBalancer service?
Every LoadBalancer creates a separate Azure Load Balancer/public IP & Increased cloud costs.
## 17.when u mention lodabalancer in svc file what will happen will cerate a public ip or private ip
when we create a Kubernetes Service with type: LoadBalancer in AKS, Azure provisions an Azure Load Balancer with a public IP address.
## 18.do u know serices of public and private ips and wht are the adv for  using the private ips
Yes. A public IP is reachable from the internet, whereas a private IP is only reachable within a private network such as a VNet. In our AKS environment, internal microservices, databases, and internal load balancers used private IPs because they provide better security and reduce unnecessary internet exposure. Only internet-facing applications were exposed using public IPs through an Ingress Controller or a LoadBalancer Service.
## 19.where u will store the keys public and private and experiance in key vault
## 20.any ai tools used in your day to day activites
1.Yes, I use AI tools regularly to improve productivity, but I always validate the output before using it in production. I primarily use StriderAI and GitHub Copilot to assist with scripting, troubleshooting, pipeline development, Kubernetes manifests, Terraform code, and documentation. AI helps speed up repetitive tasks, while final validation and testing are still done manually
2.I haven't implemented Ollama in my current project, but I understand how it can enhance observability. Since it runs LLMs locally (lama 3), organizations can analyze logs, alerts, and Kubernetes events without sending sensitive production data to external AI services. It can summarize incidents, assist with root cause analysis, explain Kubernetes errors, and help engineers troubleshoot faster while maintaining data privacy."
              Applications
                    │
                    ▼
Prometheus(metric)  Grafana    Dynatrace (traces)
      │             │          |
      └─────────────|──────────|
                    │
             Observability Data (Grafana Dashboards)
                    │
                 Ollama (Ollama is a tool that lets you run open-source AI models locally on your own machine or server instead of sending data to cloud AI services.)
             (Llama 3/Mistral)
                    │
     AI Summary / RCA / Suggestions/Incident explanation
## 21.what is sequrity in outside devops 
Source Code Security
Use branch protection rules.
Require pull request reviews.
## 22. what is the base image used in docker file and perodical image updates
The base image depends on the application. For our applications, alpine/node:20-alpine/ Eclipse/python:3.12-slim images. Wherever possible, we preferred lightweight images such as Alpine or slim variants to reduce image size and minimize security vulnerabilities
We periodically review and update base images to include the latest security patches and bug fixes. Before updating, we scan the images for vulnerabilities using tools such as Trivy. We update the image version in the Dockerfile, rebuild the image through the CI/CD pipeline, run automated tests, scan again, and deploy only after validation.
## 23.kubernetes cluster upgardes
-----------
## syren cloud tech
## 1.u are managing terraform for diffrent envs each env has its own vpc subnets and sg u wnat to resuse the same code and deploy seperate resources for as per      the env how will u structure terrafom code and state file for this
terraform/
│
├── modules/
│   ├── vnet/
│   ├── subnet/
│   └── nsg/
├── dev/
│   ├── main.tf
│   ├── terraform.tfvars
│
├── qa/
├── uat/
└── prod/
--
## 2.we have a production sql data base it should not be deleted accedentally what action pevernts this in ur terafom code
lifecycle {
  prevent_destroy = true
}
## 3.ur team has larage terrafom code bases modules for multile regions and applying cahnges taking longtime and ofen failes due to dependecies how u optimize this in terraform
"I split the infrastructure into reusable modules, maintain separate state files for independent components, use remote state, reduce unnecessary dependencies, and execute independent modules in parallel through the CI/CD pipeline."
## 4.is it possible to use temporary disk in azure to store data or not
Yes, but only for temporary data like cache, swap, or temporary files. Temporary disks are not persistent and data is lost if the VM is restarted, redeployed, or moved.
## 5.is it possible to enable NSG at Vnet level in azure or not
No. NSGs can only be associated with a subnet or a network interface (NIC), not directly with a Virtual Network
## 6.imagine u are mangaing cloud insfrasture in azure and u need to provide remote access to a virtual machine for a 3rd party vendor that vendoer does not have azure account and he should not given access to azure portal how ever they need to connect sequrely to that vm
I would not provide Azure Portal access. Instead, I'd use Azure Bastion or VPN with a temporary local VM account, restrict access using NSGs to the vendor's public IP, and remove access once the work is completed

## 7.how can u enable avaialabilty set to exsisting virtual machine(appliction is running in vm) in ur enviroment
It isn't supported directly. I would create a managed image or snapshot of the existing VM, deploy a new VM into the Availability Set, migrate the application, test it, and then decommission the old VM

## 8.u have a web appliction (web app) running on azure vm and ensure high avaialabilty and fault tolarance
I deploy multiple VMs across Availability Zones behind an Azure Load Balancer or Application Gateway, enable health probes, use VM Scale Sets for auto-healing and scaling, and configure Azure Monitor and Azure Site Recovery

## 9.u are managing a critical azure vm that host a important web application to ensure business continuty and minimize incase of disaters what u can use for to avoid this type of region wise outages for ur application
I use Azure Site Recovery for disaster recovery, Geo-Replication for databases, and Azure Front Door or Traffic Manager for automatic regional failover

## 10.u have different docker conatiners running different services u wnat to link them togehter so that they can communicate with each other
Docker containers are isolated by default, so they cannot communicate unless they are connected to the same Docker network. In production, I create a user-defined bridge network and attach all related containers to that network. Docker provides built-in DNS resolution, so containers can communicate using their container names instead of IP addresses. For multi-container applications, I typically use Docker Compose, which automatically creates a common network for all services.
## 11.u have a docker container whcih is running a webserver u want to access that webserver from ur hostmachine
docker run -d -p 8080:80 nginx (port forward)
## 12.u want to run multiple instances of a docker container to handle the increasing traffic how can u do that
"If I'm using Docker on a single server, I can run multiple instances of the same container. Since each container cannot use the same host port, I expose them on different ports or use Docker Compose with multiple replicas. However, Docker alone doesn't provide automatic load balancing or auto-scaling. In production, I would deploy the application to Kubernetes using a Deployment with multiple replicas and expose it through a Kubernetes Service. If traffic increases further, I would configure a Horizontal Pod Autoscaler (HPA) to automatically scale the number of replicas
## 13.u want to run a docker container on a server with limited resources how will u optamize that conatinaer for resorcing usage
If the server has limited CPU and memory, I optimize both the Docker image and the container runtime. First, I use a lightweight base image like Alpine or Distroless to reduce image size. I use multi-stage builds so only the application and required runtime are included in the final image. I remove unnecessary packages and files, and configure CPU and memory limits using Docker runtime options. I also configure health checks and monitor resource usage using docker stats. These optimizations reduce memory consumption, improve startup time, and prevent one container from consuming all server resource
## 14.ur appliaction needs to handle continous deployment with minimal downtime u have defined a kubenrts deployment with 5 replicas how can u ensure that atlest    3 pods are always runnig even ur are updateing /upgarding on cluster level
apiVersion: policy/v1
kind: PodDisruptionBudget
spec:
  minAvailable: 3
  selector:
    matchLabels:
      app: webapp
## 15.what are the all type of manifest we have in kubenrts
Pod
Deployment
ReplicaSet
StatefulSet
DaemonSet
Service
Ingress
ConfigMap
Secret
PVC
PV
StorageClass
Namespace
HPA
NetworkPolicy
ServiceAccount
RoleBinding
ClusterRole
ClusterRoleBinding
PodDisruptionBudget
## 16.u are palanning to cerate a new application for one of my devloper and i have given u the offical repo of that application i want to create helm templates     for that applications to deploy that application to kubenrts cluster 
I analyze the application, identify ports, environment variables, secrets, storage, and dependencies. Then I create a reusable Helm chart with templates for Deployment, Service, Ingress, ConfigMap, Secret, HPA, and PDB. I maintain separate values files for Dev, QA, UAT, and Production and deploy using helm upgrade --install
## 17.how to chek docker image size
docker images ls
## 18.how do you check event log of a kubeernets pod
kubectl get events
------
## Delloite
## 1.can tell the differnce between pipline variables and variable groups.
## 2.consider i have a secret and u have to call that secrt into cicd pipline and do want to hardcore this scerect value in pipline and aslo do wnat to see any leakge what are the methods we have
## 3.have u configured any quality gates in cicd pipline
## 4.what is the diffreance between self hosted aganet and microsoft hosted agent
## 5.my devloper says there is slowness in cicd pipline how will u reslove that.
## 6.what is the differnce between git pull and git fetch command. ( git pull=combination of git fetch + merge)
## 7.when a devloper mistakenly directly merged/commit the commit to main barnch and it starts depolying to prod and what will be ur approch what u will use git rvert or git reset ( u have to use git revert to reverse changes from repo to working arera)
## 8.how do you improve the pipline relaiablity. ( pull req approvers ,branch protection polices, secret storage in vault)
## 9.what is the diffrence between liveness and readiness probe in aks
## 10.the HPA is not working even u see the latency in application why? ( hpa works only on cpu metrics not by latency)
## 11.what is null resource in terraform?
null_resource is a special Terraform resource that does not create any cloud infrastructure. Instead, it is used to execute scripts or commands during the Terraform lifecycle.
## 12.there are two devops eng in your team they are doing the changes at the same time and applying the changes to terrafom what will happen ?
 If both engineers use a shared remote backend with state locking enabled, Terraform prevents concurrent modifications. The first engineer who starts terraform apply acquires a lock on the state file. When the second engineer tries to run terraform apply, Terraform detects that the state is locked and waits or throws a state lock error. This prevents state corruption and conflicting infrastructure changes
## 13.can u write a terrform code for main.tf for create one vnet and subnet and evrtinh has to be variableised
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space = var.vnet_address_space
}
resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = var.subnet_address_prefixes
}
----
## HCL WITH JFROG
## 1.how sso auth integartes with jfrog and diff repositary managment structure (remote,local,virtual) and how storage work in artifactory and xray scan poclicy
## 2.can u tell me diffrence between workflow and actions tab
## 3.do u know manually triggering for workflow otherthan pull and push
## 4.when workflow  triggered for pull and push where the function is excuting like stpes and jobs
When a workflow is triggered by a push or pull_request event, GitHub first detects the event, then schedules the workflow on a runner (GitHub-hosted or self-hosted). The runner downloads the repository code and executes all jobs and steps defined in the workflow YAML
## 5.due u know about github action runners and why should we use selfhosted runners other than github runner
GitHub Actions runners are the machines that execute workflow jobs. GitHub provides GitHub-hosted runners, which are temporary virtual machines managed by GitHub, and self-hosted runners, which we install on our own infrastructure such as Azure VMs or Kubernetes clusters. In enterprise environments, we typically use self-hosted runners because they can securely access private resources like AKS clusters, Azure Key Vault, private databases, and internal APIs. They also allow us to install custom tools, maintain build caches for faster execution, use larger VM sizes, and comply with organizational security policies. For public workloads, GitHub-hosted runners are usually sufficient because they require no maintenance and are automatically managed by GitHub.
## 6.how to conncet  to selfhosted runners  in github
To configure a self-hosted runner, I first provision an Azure VM and install the required tools such as Git, Docker, Terraform, Azure CLI, and kubectl. In the GitHub repository, I navigate to Settings → Actions → Runners and create a new self-hosted runner. GitHub provides a registration token and configuration commands, which I run on the VM to register the runner. I then install the runner as a Linux service so it starts automatically. In the workflow, I specify runs-on: self-hosted or use custom labels like linux and terraform. The runner maintains an outbound HTTPS connection to GitHub, polls for new jobs, executes them locally, and reports the results back to GitHub
## 7.do u have experiance in github organisation
In our organization, all infrastructure repositories were maintained under the GitHub Organization. We followed a pull request workflow with branch protection enabled on the main branch. Every infrastructure change required peer review and successful CI checks before merging. We used GitHub Actions with self-hosted runners to deploy Terraform and AKS resources. Organization secrets were used to securely store Azure service principal credentials, and production deployments required manual approvals through GitHub Environments.
## 8.when a deployment is happening it has to ask for a maunal approval (github settinsg -enviroment-approvals)
## 9.what are the tasks u do regularly in docker and kubernets
## 10.what are the monitoring tools u are using to monitor the pods and k8s cluster
## 11.u recive a notification that pod is repetedly failing where u will start looking and steps u perfom
## 12.how do u maintain cluster upgrades in aks
## 13.when docker has cretaed a image and pushed to ACR and u want to deploy this to k8s waht autechtication requires to deployment (service principal/managed identity)
In AKS, the approach is to attach the ACR to the AKS cluster using a Managed Identity, which is granted the AcrPull role. This allows AKS to pull images securely without storing credentials in Kubernetes secrets. If the cluster is outside Azure, such as an on-premises Kubernetes cluster, we create an imagePullSecret with the ACR credentials and reference it in the Deployment manifest."
## 14.do u know what is oidc autechication in aks?
 OIDC (OpenID Connect) is an identity layer built on top of OAuth 2.0. It allows applications or workloads to authenticate without storing long-lived secrets or passwords.
--------------
## HCL 2 migration
## 1.how many types of vpn connectivity to azure 
(site-2-site,point-2-site,vnet-2-vnet,express route,vnet perreing)
## 2.have u worked on certificate renwal u have a webserver and have to renew the certificate yearly basis
In my current project, I have been involved in SSL/TLS certificate renewal activities for web applications hosted on Azure. Our certificates are renewed annually. My role was to coordinate the renewal process, update the certificate on Azure Application Gateway or the web server, validate HTTPS connectivity, and ensure there was no downtime during the replacement
## 3.what do u mean by drift in terraform
Terraform drift occurs when the actual cloud infrastructure differs from the Terraform configuration because changes were made outside Terraform, such as through the Azure Portal or CLI. Terraform detects drift during terraform plan by comparing the configuration, state file, and real infrastructure. If drift is found, the plan shows the proposed changes needed to bring the infrastructure back to the desired state. Running terraform apply will reconcile the infrastructure with the Terraform code.
## 4.how do pass all the enviroments in a single pipline is it possible via terraform
## 5.what do u ment by statelocking in terraform
## 6.what are the challenges u faced while using terraform ?
## 7.what is teh diffrence between application gatway and a loadbalancer?
-----
infy 3rd party
## How to attach disk to vms mount -a (/mnt)
How to chek user in vm paths
Explain the secterts in the piplines Aks 
how to deploy application What are the fatocrs u will ask for architet when deplying application
How to stop networking inside cluster 
using the aks lb have to use
List some docker commands u use
How u will  chek user permisions amd wehre users are list in server (/home)
What are the cost optimization used in azuzre
Do u know linevess qnd readiness probe
For ubntu nad nginix servers how u change http to https

## 
## 
## 
## 
## 
## 
