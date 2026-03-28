Devops Interview questions

# 1.What is Liveness Probe and Readiness Probe in Kubernetes?

In Kubernetes, when you deploy a containerized application (like a microservice), it’s crucial to ensure that the application is running correctly and can receive traffic. However, applications can sometimes:
Crash unexpectedly (but the container is still running).
Be temporarily unable to handle requests (like during startup or maintenance).
Face deadlocks (application is running but not responding).
To handle such scenarios, Kubernetes uses two types of probes:
Liveness Probe – Checks if the container is alive (healthy).(If the Liveness Probe fails, Kubernetes will automatically restart the container assuming it has crashed or is stuck.)
Readiness Probe – Checks if the container is ready to serve traffic.(If the Readiness Probe fails, Kubernetes will NOT send traffic to that container until it's ready.
It does NOT restart the container but only removes it from the load balancer until it’s healthy.)
-----	
2:What is the issue you are facing at the time of building an image
A: Summary of Common Issues
Issue	Solution
Docker Daemon Not Running	Start Docker Service
Invalid Tag Name		Use correct Docker tag format
Permission Denied		Use docker login with credentials
Build Context Missing		Use docker build . from correct directory
Proxy Issues			Set Docker HTTP Proxy
-----
3.How to stop direct commits to GitHub.
A. Enable Branch Protection Rule (Go to Settings → Branches → Branch Protection Rules.)
✅ Require a pull request before merging
✅ Require approvals (1 or 2 developers)
✅ Require status checks (CI/CD pipeline)
✅ Restrict who can push to matching branches
✅ Prevent force pushes and branch deletion
------
4.Where Exactly Is an Application Deployed in Kubernetes?
A:In Kubernetes, when you deploy an application (such as a web app, microservice, or API), you deploy it into a Kubernetes Cluster
💡 How It Works in Real-Time: Deployment + Service + Ingress + Namespace.
User Request (Browser)
     ↓
Ingress (example.com)
     ↓
Service (ClusterIP / LoadBalancer)
     ↓
Deployment
     ↓
    Pod
     ↓
Container (Application)

✅ Deployment=	Manages multiple Pods for the application.	(Best for deploying large-scale applications with high availability.)
--------
5.What is the real time issue you are facing when building a java package using maven.
A. a.Maven Build Fails Due to Missing Dependencies (404 Error)
👉 When you build a Java project using Maven, it will download all dependencies mentioned in pom.xml from the Maven Central Repository.
👉 However, sometimes Maven fails to download the dependency and throws an error like:

✅ Error Message:
Failed to execute goal on project myapp: Could not resolve dependencies
Failed to download artifact org.springframework:spring-core:5.3.9
404 Not Found
ans-Verify the dependency in pom.xml & Manually force Maven to download dependencies.

2. Maven OutOfMemoryError (OOM) During Package Build
👉 When you are building a large Java application with many dependencies, Maven consumes a lot of memory during the build process.
👉 This can cause a Java Heap Space (OutOfMemoryError).
ans-Increase Maven memory during build using CLI or add memory

3. Maven Build Fails Due to JDK Version Mismatch
👉 You are building your application using Java 17, but your Maven is configured to use Java 8.
👉 This causes Maven to fail during the build process.
ans-Update the Maven version and check java version
-------------
6.How Many Builds Are Stored in a Jenkins Pipeline Project?
A:In Jenkins, the default number of builds that are stored in a Pipeline Project is:10
 Increase Build Storage in GUI
Go to Jenkins Dashboard → Select Your Pipeline.
Click on Configure → Enable Discard Old Builds.
Modify the build storage like: Max # of builds to keep: 100
--------------
7.Difference Between Replica Set and Replication Controller in Kubernetes
In Kubernetes, both ReplicaSet (RS) and ReplicationController (RC) are used to ensure that a specified number of pods (instances) are always running in a cluster.
👉 If a pod fails, they will automatically create a new pod to maintain the desired count.

Feature				ReplicationController (RC)		ReplicaSet (RS)
✅ Deployment Support		Cannot be used with Deployments.	Used by Deployments to manage pods.
✅ Label Selector Support	Only supports key-value labels.		Supports label selectors with expressions.
---------------
8.What are some routine tasks you have automated using Ansible playbooks?
🚀 1. Application Deployment (Java, Python, Node.js, etc.)
👉 Automating the deployment of applications (Java, Python, Node.js, .NET, etc.) across multiple servers using Ansible Playbooks.
👉 This eliminates manual deployments and ensures consistent deployment.

✅ Example: Java Application Deployment Playbook
File Name: deploy-java-app.yml
- name: Deploy Java Application
  hosts: app_servers
  become: yes
  tasks:
    - name: Install Java
      apt:
        name: openjdk-11-jdk
        state: present

    - name: Copy Application JAR File
      copy:
        src: /home/devops/app.jar
        dest: /opt/app/app.jar

    - name: Restart Application
      systemd:
        name: myapp
        state: restarted
✅ What It Does:
📜 Installs Java on the target server.
📂 Copies the JAR file from Ansible Control Node to the target server.
✅ Restarts the application using systemd.

🚀 2. Infrastructure Provisioning (AWS, Azure, GCP)
Task:
👉 Automate the provisioning of infrastructure (EC2, S3, RDS, Load Balancer, etc.) using Ansible Playbooks.
👉 This saves manual efforts and ensures consistent infrastructure provisioning.

✅ Example: Provision EC2 Instance on AWS
File Name: create-ec2-instance.yml
- name: Provision EC2 Instance
  hosts: localhost
  tasks:
    - name: Launch EC2 Instance
      amazon.aws.ec2_instance:
        name: my-ec2-instance
        key_name: my-key
        instance_type: t2.micro
        image_id: ami-0abcdef1234567890
        region: us-east-1
        security_groups: default
        state: running
✅ What It Does:

🚀 Launches an EC2 instance in AWS.
✅ Configures key-pair, security groups, and instance type.
💡 Completely eliminates manual EC2 provisioning.
. Configuration Management (Nginx, Apache, Tomcat, etc.)
Task:
👉 Automate the installation and configuration of web servers like:
✅ Example: Install and Configure Nginx Web Server
File Name: configure-nginx.yml
- name: Install and Configure Nginx
  hosts: web_servers
  become: yes
  tasks:
    - name: Install Nginx
      apt:
        name: nginx
        state: present

    - name: Start Nginx Service
      systemd:
        name: nginx
        state: started
        enabled: yes

    - name: Copy Custom Configuration File
      copy:
        src: files/nginx.conf
        dest: /etc/nginx/nginx.conf

    - name: Restart Nginx Service
      systemd:
        name: nginx
        state: restarted
✅ What It Does:
✅ Installs Nginx on the target servers.
✅ Copies a custom configuration file.
✅ Restarts the Nginx service.

✅ 💯 Summary of Tasks Automated Using Ansible
	Task Automated	Purpose
✅ Application Deployment	Automate Java, Python, Node.js deployments.
✅ Infrastructure Provisioning	Provision EC2, S3, RDS, and Load Balancers.
✅ Docker Container Management	Install Docker and deploy containers.
✅ Configuration Management	Install Nginx, Apache, Tomcat, etc.
✅ Patch Management		Automate OS updates and security patches.
✅ User Management		Create users, add SSH keys, and set permissions.
✅ Kubernetes Deployment	Deploy applications in Kubernetes clusters.
✅ Database Backup & Restore	Automate MySQL and MongoDB backups.
-----------------
9.Have you used SonarQube and Trivy in your CI/CD pipeline? How did you share the reports with the DevOps team?
✅ Yes, I have used SonarQube and Trivy in my CI/CD pipeline to perform static code analysis (SCA) and container vulnerability scanning, respectively.
👉 In a real-time DevOps environment, integrating SonarQube and Trivy helps ensure code quality, security, and vulnerability-free deployments.
👉 I also configured the pipeline to share the reports with the DevOps team using Slack, Email, and Artifact Storage (like S3, Nexus, or JFrog Artifactory).
🚀 Scenario 2: Integrating Trivy for Container Vulnerability Scanning in CI/CD
✅ What is Trivy?
👉 Trivy is an open-source vulnerability scanner for containers and infrastructure as code (IaC).
👉 It scans Docker images for:
🚨 High and Critical vulnerabilities.
🦠 Outdated dependencies.
🔥 Misconfigured container images.
✅ Where is the Trivy Report Stored?= The Trivy report is stored in → Jenkins → Build → Artifacts → trivy-report.txt
------------------
9.How did you optimize CI/CD to reduce deployment time by 30%?
Yes, I have optimized the CI/CD pipeline to reduce deployment time by 30% in real-time projects using various optimization techniques like:

🚀 Parallel Job Execution.=💡 I split the Build, Test, Scan, and Deploy stages to run in parallel using Jenkins pipelines and This cut down the build time by 20%.
💡 Docker Layer Caching. ( Every time the Jenkins pipeline ran, it rebuilt the Docker image from scratch)=so I enabled Docker Layer Caching using the Dockerfile. This avoided downloading the same layers again and again.
📦 Incremental Builds (Delta Deployments).(Every time we built the code, the entire application was deployed even for a small code change.)= I configured Delta Deployments using Helm charts in Kubernetes. This ensured only changed files were deployed — saving deployment time
🗄 Artifact Storage (S3, JFrog, Nexus).(Jenkins was building the package every time from scratch.)=I stored the build artifacts (JAR/WAR) in Nexus Repository. Jenkins would only download the built artifacts instead of building again.
📜 Optimizing Deployment Strategies (Blue-Green, Canary).(Every deployment caused 5-10 minutes downtime)=I implemented Blue-Green Deployment strategy.This ensured zero downtime deployments.
💻 Infrastructure as Code (IaC).
⏩ Reducing Maven Build Time.
----------------
10. What Agents Did I Use in My CI/CD Pipeline?
different types of agents for different use cases:

Agent Type			Where I Used It									Why I Used It
Docker Container Agents 	For Java Builds, Docker Image Builds, Trivy Scans, SonarQube Scans.	🚀 Dynamic Scaling, no manual configuration, disposable containers after build.
Kubernetes Pod Agents 	  For large-scale applications where Jenkins master was deployed on Kubernetes.	🧱 Allows auto-scaling, runs on Kubernetes nodes, used for microservice builds.
--------------
11.You reduced Azure costs by 20%-how did you analyze resource allocation and optimize costs?

✅ Yes, I successfully reduced Azure cloud costs by approximately 20% in my previous projects by performing a thorough cost analysis, optimizing resource allocation, and implementing cost control strategies.

✅ 💯 How I Reduced Azure Costs by 20% (Step-by-Step)
✅ Step 1: Performed Cost Analysis Using Azure Cost Management (Azure Portal)
👉 Problem Before Optimization:
🚨 The organization was paying heavily for under-utilized resources like:
🚀 Virtual Machines (VMs) running 24/7.
📊 Unattached Disks still being charged.
📦 Unused Load Balancers.
💾 Large storage accounts with no data usage.
🚨 Monthly cost: $12,000/month.

✅ What I Did to Reduce Cost:
📊 I accessed Azure Cost Management + Billing in the Azure portal.
✅ I filtered resources by:
🚀 High-cost resources (VMs, Disks, Storage).
⏳ Idle or under-utilized resources.
📊 Zombie resources (unused but still costing money).

✅ Azure Cost Management Tool Location= Azure Portal → Cost Management + Billing → Cost Analysis.
✅ Key Findings:
Resource	Problem	Monthly Cost
🚀 Virtual Machines (VMs)	Running 24/7 (but used only during working hours)	$5,000/month
💾 Managed Disks	Unattached disks still charging money	$1,200/month
📦 Storage Accounts	Unused storage accounts	$2,000/month
💡 Public IPs	Idle Public IPs consuming money	$800/month
✅ 👉 Identified 20-30% waste in costs.

✅ Step 2: Auto-Scaled Virtual Machines Using Azure Scale Sets (Saved $2,500/Month)
👉 Problem Before Optimization:
🚀 There were 10 Virtual Machines (VMs) running 24/7, even though developers only worked from 9 AM to 6 PM.
✅ This was costing $5,000/month unnecessarily.
✅ What I Did to Optimize It:
📊 I implemented Azure Virtual Machine Scale Sets (VMSS) to:
✅ Auto-scale VMs during working hours.
✅ Shut down VMs during non-business hours.
✅ Reduce running instances when workload decreases.
✅ How I Configured It:
📊 Azure Portal → Virtual Machine Scale Sets → Create Auto-scale Rule.(✅ 50% reduction in VM cost.)

✅ Step 3: Removed Unused Disks and Load Balancers (Saved $1,200/Month)
👉 Problem Before Optimization:
💾 Several unattached Managed Disks were still being billed.
📦 Unused Load Balancers were being charged without any purpose.
✅ This was wasting around $1,200/month.
✅ What I Did to Optimize It:
✅ I ran the following Azure CLI command to list all unattached disks:(az disk list --query "[?diskState=='Unattached']" -o table)
✅ Deleted unused Load Balancers.
✅ Removed public IPs associated with unused resources.

✅ Step 5: Enabled Azure Spot Instances for Non-Prod Environments (Saved $2,000/month)
👉 Problem Before Optimization:
🚀 In our non-production environments, we were using normal VMs for testing.
✅ This was costing around $3,000/month.
✅ What I Did to Optimize It:
✅ I switched non-production environments to Azure Spot Instances.
✅ Spot Instances offer a 90% cost reduction during low traffic.
------------------
12.What are the downsides of using a single Ingress controller instead of multiple load balancers?
A: In a real-time Kubernetes environment, using a single Ingress Controller instead of multiple Load Balancers has both advantages (cost-saving, simplified routing) and downsides (performance bottleneck, single point of failure, etc.)
1. Single Point of Failure (SPOF)=🚨 If you use a single Ingress Controller for all incoming traffic, and if it fails (crashes, unhealthy, or down), all applications hosted in the cluster will become inaccessible.
✅ What Should You Do to Avoid This?
✅ Deploy multiple Ingress Controllers for high availability.
2. Performance Bottleneck (High Traffic Load)
🚨 In a high-traffic production environment, a single Ingress Controller has a limited capacity for handling requests.
🚀 Example: If your application handles 100,000+ requests per second (RPS), a single Ingress Controller can easily become a bottleneck.
✅ What Should You Do Instead?
✅ Deploy multiple Ingress Controllers and distribute traffic across them.
✅ Use NodePort Services or Load Balancer Services directly for mission-critical applications.
✅ Implement Kubernetes Horizontal Pod Autoscaler (HPA).
4. No Isolation for Internal and External Traffic
🚨 If you use a single Ingress Controller, it handles both: External Traffic (public users). Internal Traffic (inter-service communication).
✅ What Should You Do Instead?
✅ Use a separate Ingress Controller for:
✅ External Traffic (Public) → App1, App2, App3.
✅ Internal Traffic (Microservices) → Backend Services, DB.
✅ Alternatively, use Service Mesh (like Istio, Linkerd) for internal communication.
--------------
13.if there’s a traffic spike on one service in Kubernetes:

🚀 Horizontal Pod Autoscaler (HPA) will automatically add more Pods.(increase the no of pods)
   vertical pod Autoscaler (VPA) will increase the the limts of individual pods. (increase the size of existing pods)
📊 LoadBalancer/Ingress will distribute traffic to new Pods.
💻 If the cluster cannot handle more Pods, Cluster Autoscaler will add more Nodes.
⏬ When traffic decreases, HPA will scale down Pods to optimize costs.

. Increased Load on Pods (Containers)
Kubernetes routes incoming traffic to Pods of the service using a LoadBalancer/Ingress.
During a traffic spike, existing Pods will start to experience high CPU/Memory utilization.
If the traffic exceeds the capacity of running Pods, response time increases or the application may crash.
👉 Impact:
1.Users may start experiencing delayed responses or failures.
2.Pods may crash/restart due to resource exhaustion.
✅ Best Practices to Handle Traffic Spikes
	Best Practice					Purpose
✅ Enable HPA (Horizontal PodAutoscalr)	Automatically scales Pods during traffic spikes.
✅ Enable Cluster Autoscaler		Automatically adds nodes if resource capacity is exceeded.
✅ Use LoadBalancer/Ingress		Efficiently distribute traffic across Pods.
✅ Enable Liveness & Readiness Probes	Prevent unhealthy Pods from receiving traffic.
✅ Monitor with Prometheus/Grafana	Monitor traffic spikes and system health.
✅ Implement Rate Limiting (Optional)	Prevent overwhelming your application from huge spikes.
----------
14.How do you determine resource limits for your Kubernetes cluster
A: 1. What Are Resource Limits in Kubernetes?
👉 In Kubernetes, every Pod (Container) consumes:

💻 CPU (vCPU) → Processing Power.
🧠 Memory (RAM) → Application Memory.
💾 Storage (Persistent Volume) → Disk Space (Optional).
👉 Kubernetes allows you to define limits for:

✅ How much CPU a Pod can use (vCPU).
✅ How much Memory a Pod can use (RAM).
✅ Prevent Pods from exhausting cluster resources.
-----------------
15.What steps can you take to reduce the size of a Docker image?
. Why Is Docker Image Size a Problem?
👉 In a normal deployment, Docker images can become very large due to:

✅ Unnecessary files (logs, cache, temp files).
✅ Large base images (like Ubuntu, CentOS).
✅ Unused dependencies.
1. Use a Lightweight Base Image (Best Practice 🚀)
👉 Instead of using large base images like:
❌ Ubuntu → Size: 300MB ❌ CentOS → Size: 210MB
 ✅ Use lightweight images like: Alpine,busybox
2.Remove Unnecessary Dependencies
3.Clear Cache After Installing Packages
4.Avoid Adding Unnecessary Layers to imgae
5.Use Docker Slim (Automatic Size Reduction)
--------------
16.Why is the Terraform state file important & What Is Terraform State File (terraform.tfstate)?
👉 The Terraform state file (terraform.tfstate) is a JSON file that:

✅ Tracks the current state of your infrastructure (in AWS, Azure, GCP, etc.).
✅ Acts as a source of truth for Terraform to know what infrastructure exists.
✅ Maps real-world infrastructure with your Terraform configuration.
✅ In simple terms:

💾 It is like a database that stores the current infrastructure state.
✅ Without the state file, Terraform would not know which resources are already created or modified.
1. Tracks Real-Time Infrastructure State
2. Prevents Resource Duplication
3. Enables Incremental Changes (No Downtime) - When you change infrastructure, Terraform only updates the changed resources
4. Supports Remote State for Team Collaboration =In a real-time DevOps environment, multiple DevOps engineers work on the same infrastructure.
------------------------
17.Why should we run terraform init before deploying infrastructure?

The terraform init command is used to:
✅ Download the required provider plugins (like AWS, Azure, GCP).
✅ Initialize the state file (local or remote).
✅ Lock dependencies and versions using terraform.lock.hcl.
✅ Prevent parallel deployments by enabling state locking.
✅ Prepare the Terraform working directory for deployment.
----------------
18.How Would You Design and Implement a CI/CD Pipeline from Scratch?
A:
🚀 The project has source code in GitHub.
🚀 The application is built using Java + Spring Boot + Maven.
🚀 The infrastructure will be deployed in Kubernetes (K8s) using Helm Charts.
🚀 The goal is to deploy the application in AWS EKS (Elastic Kubernetes Service).
🚀 You need to design a complete CI/CD pipeline from scratch.
✅ Pipeline Flow (High-Level) 
GitHub (Source Code)
     ↓
Jenkins (CI/CD Pipeline)
     ↓
SonarQube (Code Quality)
     ↓
Trivy (Image Vulnerability Scan)
     ↓
Docker Build → Push to ECR (Docker Hub or AWS ECR)
     ↓
Deploy to Kubernetes (EKS Cluster)
     ↓
Monitor Using Prometheus + Grafana
Step 3: Build the CI Pipeline (Continuous Integration)
✅ Pulling the code from GitHub.
✅ Building the code using Maven.
✅ Running Unit Tests.
✅ Running Code Quality Analysis (SonarQube).
✅ Building a Docker Image.
✅ Pushing the Docker Image to Docker Hub/ECR.
step4:Continuous Deployment (CD) in Kubernetes
👉 Now that the image has been built and pushed, you need to deploy it to Kubernetes (EKS).
✅ Deployment.yaml (to deploy the pod).
✅ Service.yaml (to expose the pod).
✅ Ingress.yaml (for external access).
Step 7: Final Flow (End-to-End)
👉 Your final workflow is:
✅ Push Code to GitHub →
✅ Jenkins Builds Code + SonarQube + Trivy Scan →
✅ Docker Image Pushed to ECR/Docker Hub →
✅ Kubernetes Deploys Image Automatically →
✅ Monitoring with Prometheus/Grafana →
✅ Autoscaling + Load Balancer →
✅ Application up and running
-------------
19.How does Argo CD detect when an image is updated?
 In a production setup, Argo CD does not automatically detect image updates by default.
✔️ However, to enable automatic image updates, I use Argo CD Image Updater.
✔️ This tool continuously monitors the image registry (Docker Hub/ECR).
✔️ Whenever a new image is pushed, it automatically updates the deployment without any manual changes.
✔️ This ensures zero downtime deployment and faster release cycles.
✔️ Alternatively, I can configure Webhooks or manually update the Git repository — but using Image Updater is the best practice. 
--------------
20.explain about Taints, tolerations, and node selectors in kubernets
👉 for scheduling pods and how you can control which Pod runs on which Node using:
✅ Taints✅ Tolerations✅ Node Selectors
👉 In Kubernetes, you have a cluster with multiple Nodes.
👉 By default, Kubernetes will schedule any Pod on any Node if resources are available.
👉 But what if you want specific Pods to run on specific Nodes or prevent certain Pods from running on certain Nodes?

✅ That's where Taints, Tolerations, and Node Selectors come into play.

✅  1. What is a Taint in Kubernetes? (Prevent Pods from Running on a Node)
👉 A Taint in Kubernetes is used to prevent specific Pods from being scheduled on a Node.
👉 You apply a Taint to a Node to repel(reject) unwanted Pods from running on it.
💡 "I do NOT want any Pod to run on my Node EXCEPT specific ones."

✅ 💯 Real-Time Example of Taint
Suppose you have 3 Nodes:

✅ Node1 → Running Production Workloads.
✅ Node2 → Running Non-Production (Dev/Test) Workloads.
✅ Node3 → Running Monitoring Applications.
👉 You don't want test applications to run on Node1 (Production).
👉 So, you will apply a Taint to Node1.

✅ 💯 Command to Apply a Taint Apply a Taint to Node1:kubectl taint nodes node1 environment=production:NoSchedule

Effect			Description
NoSchedule		Prevents Pods from being scheduled on this Node
PreferNoSchedule	Softly avoids scheduling Pods on this Node
NoExecute		Evicts already running Pods and prevents new Pods from scheduling
✅ Output:
node/node1 tainted
👉 Now, NO Pods can run on Node1 unless it has a Toleration.

🚀 2. What is a Toleration in Kubernetes? (Allow Certain Pods to Run on a Tainted Node)
👉 Toleration allows specific Pods to bypass the Taint on a Node and still get deployed.
👉 In simple words:💡 "If a Node has a Taint, only Pods with a matching Toleration can run on that Node."

✅ 💯 Real-Time Example of Toleration
👉 Suppose Node1 has a Taint:
kubectl taint nodes node1 environment=production:NoSchedule
👉 Now, if you want a specific Pod (Payment Service) to run on Node1, you need to add a Toleration to the Pod YAML.

✅ 💯 Toleration in Pod Manifest
👉 pod-payment.yaml
apiVersion: v1
kind: Pod
metadata:
  name: payment-service
spec:
  containers:
  - name: payment
    image: nginx
  tolerations:
  - key: "environment"
    operator: "Equal"
    value: "production"
    effect: "NoSchedule"
✅ Explanation:

✅ Key: The key of the Taint (environment).
✅ Operator: Equal means it matches the exact value.
✅ Value: Matches the value (production).
✅ Effect: Allows scheduling despite the Taint.
✅ 💯 Result
✅ The Pod will now get scheduled on Node1 (even though it has a Taint).

👉 Output:
payment-service Pod scheduled successfully on Node1

🚀 3. What is Node Selector in Kubernetes? (Force Pods to Specific Nodes)
👉 Node Selector is used when you want to force specific Pods to run on specific Nodes.
👉 It works based on Node labels.

✅ Use Case "I want my Payment Service to ONLY run on Node1."
✅ 💯 Real-Time Example of Node Selector
👉 First, label Node1 like this:
kubectl label node node1 app=payment
✅ Now the Node is labeled like this:
node1 → app=payment
✅  Pod Manifest with Node Selector
👉 pod-payment.yaml
apiVersion: v1
kind: Pod
metadata:
  name: payment-service
spec:
  containers:
  - name: payment
    image: nginx
  nodeSelector:
    app: payment
✅ Explanation:

✅ This Pod will ONLY run on Node1 (because it has the label app=payment).
✅ It will NOT run on other Nodes.
✅ Output:
payment-service Pod scheduled successfully on Node1
✅ 💯🔥 This is a hard restriction.
👉 No other Nodes can run this Pod except Node1.

✅ 💯 🚀 4. What is the Difference Between Taint and Node Selector?
👉 Many interviewers ask this tricky question.

✅ Answer:
Feature		Taint & Toleration				Node Selector
Purpose	Prevent unwanted Pods from running on Nodes		Force Pods to run on a specific Node
Use Case	Restrict critical Pods from running everywhere	Deploy a Pod only on a specific Node
Behavior	Works on "Prevent" and "Allow" concept		Works only on "Force" concept
		
✅ 💯 Example Answer:

💡 Taint/Toleration = "DO NOT ALLOW anyone EXCEPT who has permission."
💡 Node Selector = "ONLY ALLOW this Pod to run on a specific Node."

✅ 💯 🚀 Real-Time Best Practices (Impress the Interviewer)
🔥 💯 In a Real-time Production Setup, I do the following:

✅ For Critical Nodes:
I use Taint + Toleration to ensure only critical Pods run on high-priority Nodes.
✅ For Regular Nodes:
I use Node Selectors to ensure each Pod runs on a specific Node.
✅ For Cost Optimization:
I use Node Affinity instead of Node Selectors for flexible deployments.
✅ 💯 🚀 🔥 Real-Time Interview Answer (Gold Answer 💎)
💯 If the interviewer asks you:

💬 "Can you explain Taints, Tolerations, and Node Selectors in Kubernetes?"
✅ 🚀 Best Answer:
✔️ In Kubernetes, we use Taints to repel unwanted Pods from running on Nodes.
✔️ We use Tolerations to allow specific Pods to bypass the Taint and run.
✔️ We use Node Selectors to force Pods to run on specific Nodes.
✔️ This is very useful in production to:
✅ Prevent critical workloads from running on testing Nodes.
✅ Deploy databases only on high-storage Nodes.
✅ Ensure high availability in production.
✔️ This method improves security, resource optimization, and high availability.


-------------
			part -2
➢ How to give access to Azure VM to a user for a limited time?
Method 1: Using Azure RBAC (Role-Based Access Control)
Go to Azure Portal → VM → Access control (IAM).
Click Add Role Assignment → Select "Virtual Machine User Login" role.
Assign the role to the user and set an expiration date (requires PIM).
Method 2: Using Azure Bastion
Deploy Azure Bastion in your VNet.
The user can connect via Azure Portal (Browser-based RDP/SSH).
Disable Bastion access after the required time.
--------
➢ How to connect to kubernetes services if you don't have any VM?
1.Using Cloud Shell Azure
az aks install-cli  # Install kubectl
az aks get-credentials --resource-group <rg-name> --name <aks-name>
kubectl get pods -A
2.Using External Load Balancer or Ingress (If the service is exposed externally)
--------
➢ SSL, TLS Explain in detail?
SSL (Secure Sockets Layer)?
SSL is an older cryptographic protocol used for secure communication over the internet.
It encrypts data between the client and server to prevent eavesdropping and tampering
 TLS (Transport Layer Security)?
TLS is the successor of SSL with stronger encryption and security.( advance of ssl)
------------
➢ Cosmos DB?
Azure Cosmos DB is a fully managed, globally distributed NoSQL database service designed for high performance and low latency.
-------------
➢ Private Endpoints?
A Private Endpoint is a network interface that allows private access to Azure services over a private IP in your VNet, eliminating public exposure.
-----------
➢ What all can be stored in the Azure KeyVault & how can we retrieve them?
Azure Key Vault is a secure secrets management service that allows you to store and manage sensitive information such as:
🔹 Secrets – API keys, connection strings, passwords.
🔹 Keys – Encryption keys (RSA, EC, AES) for data protection.
🔹 Certificates – SSL/TLS certificates for securing applications.
Using Azure CLI:
az keyvault secret show --vault-name <your-keyvault-name> --name <your-secret-name>
---------------
➢ C name record?
A CNAME (Canonical Name) record is a DNS record that maps an alias (subdomain) to another domain name.
--------------
➢ Real time usage of Kubernetes Cluster?
Use Cases of Kubernetes in Real-Time
Microservices Deployment – Runs multiple independent services (e.g., Netflix, Amazon).
CI/CD Automation – Deploys applications using Helm and ArgoCD.
Scalable Web Applications – Handles traffic spikes (e.g., E-commerce websites).
Multi-Cloud & Hybrid Deployments – Works across AWS, Azure, and GCP
--------------
➢ What is the use of Kubelet & Kube proxy?
 Kubelet (Node Agent)
Runs on each node and ensures the containers are running properly.
Communicates with the API server and enforces configurations.
Monitors health and restarts failed pods.

Kube Proxy (Networking Manager)
Maintains network rules and routes traffic between pods and services.
Supports service discovery and load balancing inside the cluster.
Implements iptables or IPVS for packet forwarding.
------------
➢ How can you ensure safety on Kubernetes Cluster?
 1. Use RBAC (Role-Based Access Control)
Restrict who can perform actions in the cluster.
2. Enable Network Policies
Restrict communication between pods.
 3. Enable Pod Security Policies
Prevent privileged containers from running.( Stops malicious containers from running as root!)
 5. Implement Image Scanning
Use Trivy, Aqua Security, or SonarCloud to scan images before deployment.
6. Enable Logging & Monitoring
Use Prometheus & Grafana for real-time monitoring.
---------------------


export KUBECONFIG=/path/to/kubeconfig
kubelogin convert-kubeconfig

------------------------------
1. How to give access to Azure VM to a person for a limited time?
You can assign a role using Azure RBAC (Role-Based Access Control) with a start and end time using Azure AD Privileged Identity Management (PIM). This allows temporary access, which can auto-expire after the defined duration.

2. How to connect to Kubernetes internal services if you don't have any VM?
You can use kubectl port-forward from your local machine or use a jumpbox/pod inside the cluster (like a debug pod) to access internal services securely.

3. Azure Bastion and how it works?
Azure Bastion is a PaaS service that allows secure RDP/SSH access to Azure VMs directly from the Azure portal without exposing them to the public internet.

4. SSL, TLS Explain in detail?
SSL (Secure Sockets Layer) and TLS (Transport Layer Security) are cryptographic protocols that encrypt data over networks. TLS is the newer, more secure version, ensuring safe communication between clients and servers (like HTTPS).

5. Cosmos DB?
Cosmos DB is Microsoft’s globally distributed, multi-model NoSQL database that offers high availability, low latency, and scalability for mission-critical applications.

6. Private Endpoints?
Private Endpoints in Azure allow you to connect privately to Azure services over the Azure backbone network instead of exposing them publicly over the internet.

7. What all can be stored in the Azure Key Vault & how can we retrieve them?
Azure Key Vault stores secrets (like passwords, API keys), certificates, and encryption keys. You can retrieve them via Azure CLI, PowerShell, REST API, or integrate with applications securely.

8. Real-time usage of Kubernetes Cluster?
Kubernetes clusters are used in real-time to manage, deploy, and scale containerized applications efficiently in production with high availability and rolling updates.

9. What is the use of Kubelet & Kube proxy?
Kubelet runs on each node to ensure containers are running as expected, while kube-proxy manages networking rules to allow communication between pods and services.

10. How can you ensure safety on Kubernetes Cluster?
By using RBAC for access control, network policies for traffic control, secrets management, regular updates, and tools like OPA or Kyverno for policy enforcement.

11. Use of Linux Machines in day-to-day activities for a DevOps Engineer?
Linux machines are used for scripting, automation, CI/CD pipelines, server administration, container hosting, and running cloud-native applications.

12. CI/CD Entire flow?
Code is committed to a repo → triggers build pipeline → code is built and tested → artifacts are created → release pipeline deploys to environments → monitored for issues.

13. Difference between Continuous Delivery and Continuous Deployment?
Continuous Delivery automates deployment up to staging or manual approval, while Continuous Deployment goes all the way to production without manual steps.

14. Different Build tools in CI pipeline?
Common build tools include Maven, Gradle, MSBuild, Ant (for Java/.NET), and Docker for container images in CI pipelines.

15. How to integrate ACR with pipeline securely?
Use service connections or managed identities in Azure DevOps to authenticate pipelines to Azure Container Registry (ACR) without exposing credentials.

16. Explain Terraform?
Terraform is an open-source Infrastructure as Code (IaC) tool that lets you define and provision cloud infrastructure using a declarative configuration language.

17. How to migrate from monolithic to microservice architecture?
Break down the monolith into smaller services based on business domains, containerize them, deploy using Kubernetes or similar, and implement APIs for communication.

18. Explain Kubernetes internal communication?
Pods in a Kubernetes cluster communicate via a flat virtual network. Services use DNS for service discovery, and kube-proxy helps route traffic internally using iptables or IPVS.

19. Different services in Kubernetes – ClusterIP, NodePort, LoadBalancer?

ClusterIP: Default; accessible only inside the cluster.

NodePort: Exposes service on a port of each Node’s IP.

LoadBalancer: Creates an external load balancer for access from outside the cluster.

20. Namespace in Kubernetes?
Namespaces logically divide cluster resources for different teams or environments (like dev/test/prod), helping with isolation and resource limits.

21. What are Azure policies?
Azure Policies enforce rules on Azure resources (like allowed VM sizes or regions) to ensure compliance and governance across your environment.

22. Operators in Kubernetes?
Operators extend Kubernetes capabilities by automating complex application lifecycle tasks (like backups, upgrades) using custom resources and controllers.

23. OpenSearch / ElasticSearch?
Both are search and analytics engines used for log monitoring and full-text search. OpenSearch is a fork of ElasticSearch with open-source licensing.

24. Stateful and Stateless?
Stateless apps don't store user data between requests (e.g., web servers), while stateful apps retain data (e.g., databases or session-based apps).

25. Helm Charts?
Helm is a package manager for Kubernetes. Helm Charts define templates for Kubernetes resources, enabling reusable, version-controlled application deployments.

26. Where do we run kubectl commands if a VM is not provided?
Use the Azure Cloud Shell or install kubectl locally and configure access with the kubeconfig file from the AKS cluster.

27. Security in Kubernetes?
Use RBAC, Pod Security Standards, network policies, secrets encryption, image scanning, and tools like OPA or Kyverno for enforcing security policies.

28. CI Tools for SonarQube / Security?
Tools like Azure DevOps, Jenkins, GitHub Actions can integrate with SonarQube, Snyk, Trivy, and OWASP tools for code quality and vulnerability scanning.

29. How to pull central logs from a pod?
Use kubectl logs <pod-name> to fetch logs. For central logging, integrate with ELK/EFK stack, Azure Monitor, or OpenSearch.

30. Ingress Default Backend?
The default backend is a basic service that handles requests that don't match any Ingress rule, usually returning a 404 or custom message.

31. kubectl describe pod?
The kubectl describe pod <pod-name> command shows detailed information about a pod, including events, status, container details, and errors.

32. Ingress Controller?
An Ingress Controller is a Kubernetes component that manages external access to services using Ingress rules, handling routing, TLS termination, and load balancing.

33. Port forwarding?
Port forwarding lets you access a pod’s internal port from your local machine using kubectl port-forward pod-name local-port:pod-port.

34. Terraform folder components?
Typically includes .tf files for main config (main.tf), variables (variables.tf), outputs (outputs.tf), provider setup (provider.tf), and optionally terraform.tfvars.

35. Terraform Locking?
Terraform uses state locking to prevent multiple users from applying changes at the same time, avoiding conflicts or corruption.

36. What happens if the provider version is changed by any user accidentally?
It may break compatibility or cause unexpected behavior; best practice is to pin provider versions in required_providers and use version control.

37. terraform.lock.hcl?
This file locks the provider versions to ensure consistent and reproducible deployments across environments and team members.

38. When a user makes changes on the Azure portal manually, what happens to the .tfstate file?
Terraform’s state file becomes out of sync; use terraform refresh or terraform plan to detect and reconcile changes.

39. Playbook (Ansible) basic syntax?
An Ansible playbook is written in YAML with a list of tasks under hosts, specifying name, tasks, and modules like shell, copy, or apt.

40. Terraform Modules?
Modules are reusable, self-contained Terraform configurations that group resources, making your code more organized and maintainable.

41. Resource Drift?
Drift occurs when infrastructure is changed outside of Terraform. terraform plan helps detect drift by comparing real-world vs declared state.

42. Difference between Traffic Manager, Application Gateway, Front Door?

Traffic Manager: DNS-based global load balancer.

App Gateway: L7 load balancer with WAF.

Front Door: Global, fast routing, SSL offloading, and WAF with CDN.

43. Terraform Script for a virtual machine?
A basic script includes resource blocks for azurerm_virtual_machine, network_interface, and os_disk, along with provider and auth setup.

44. Container Logging?
Logs from containers can be viewed using kubectl logs, and centralized using tools like Fluentd, Azure Monitor, or ELK stack.

45. Dockerfile Syntax?
Common syntax includes: FROM, COPY, RUN, CMD, EXPOSE, and ENTRYPOINT. These define the image base, files, commands, and startup.

46. Kubernetes usage in previous project?
Used Kubernetes to deploy and scale microservices, manage rolling updates, monitor pods, and ensure high availability of applications in production.

47. Explain your previous project?
Worked on a CI/CD pipeline deploying microservices on AKS using Terraform and Helm, integrated with ACR, Azure Monitor, Key Vault, and SonarQube for security checks.

48. Dev Prod Environments?
Dev is for testing and early development; Prod is for live user access. Each has separate configurations, resource limits, and access controls.

49. Terraform Workspaces / Environmentals?
Workspaces let you manage multiple environments (like dev/staging/prod) using the same code but with separate state files.

50. Terraform module / parameterize?
Modules allow reusable code, and parameterizing them with variables.tf makes it flexible for different environments or configurations.

51. Your role in Application deployment and Infrastructure creation?
Responsible for writing Terraform for infrastructure, creating CI/CD pipelines, deploying apps via Helm or YAML, monitoring, and troubleshooting.

52. ACR?
Azure Container Registry (ACR) is a private Docker registry used to store and manage container images securely in Azure.

53. CNI in Kubernetes?
Container Network Interface (CNI) handles networking between pods in Kubernetes, managing IP addresses, DNS, and communication.

54. Azure Monitor?
Azure Monitor collects metrics and logs from resources, provides alerts, visual dashboards, and integrates with Log Analytics for deep insights.

55. PaaS, IaaS, SaaS – explain with examples?

IaaS: VMs, Networking (e.g., Azure VM)

PaaS: Managed apps (e.g., Azure App Service)

SaaS: Ready-to-use apps (e.g., Microsoft 365, Gmail)

56. Dockerfile syntax for Java-based code?
Example:

dockerfile
Copy
Edit
FROM openjdk:11  
COPY . /app  
WORKDIR /app  
RUN javac Main.java  
CMD ["java", "Main"]  

57. Base image for Dockerfile in Java/Python-based project?
For Java, use openjdk; for Python, use python:3.x. These provide preinstalled runtimes needed for app execution.

58. Major difference between Docker & Kubernetes?
Docker runs containers; Kubernetes manages and orchestrates many containers across clusters for scaling, recovery, and load balancing.

59. How is autoscaling configured on Kubernetes?
Use Horizontal Pod Autoscaler (HPA) with metrics like CPU/memory to scale pods automatically based on usage.

60. How do you handle bottleneck situations in Kubernetes?
By analyzing resource usage, scaling pods, tuning app performance, adjusting resource limits/requests, or using HPA and Cluster Autoscaler.

61. Incoming traffic handled by 1 pod, but replicas = 3. How does autoscaling work?
If only 1 pod is enough, HPA won’t scale more unless resource usage (CPU/memory) increases. It scales based on metrics, not replica count.

62. What real-time scenarios does Kubernetes handle that Docker can't?
Kubernetes handles container orchestration, auto-scaling, self-healing, service discovery, and rolling deployments, which Docker alone doesn’t support.

64. How does Ansible work and how to integrate it into deployment?
Ansible uses SSH and YAML playbooks to run tasks on remote servers. You can integrate it post-deployment for configuration or app setup.

65. Docker commands to create images and containers?

Build image: docker build -t myapp .

Run container: docker run -d -p 80:80 myapp

66. Taint & Tolerations?
Taints prevent pods from scheduling on nodes unless pods have matching tolerations. Used for dedicating nodes to specific workloads.

67. SQL types in Azure?
Azure offers SQL Server on VMs (IaaS), Azure SQL Database (PaaS), and Azure SQL Managed Instance (hybrid).

68. Application Insights, Monitoring?
Application Insights tracks app performance, logs, exceptions, and usage data. Integrated with Azure Monitor for full observability.

69. WebApp vs VMs?
WebApps (App Service) are PaaS and managed, while VMs are IaaS, offering full control but requiring more maintenance and setup.

70. App Services?
Azure App Services are PaaS offerings to host web apps, REST APIs, and mobile backends without managing infrastructure.

71. Types of Load Balancers?

Internal: For private network traffic

Public: For internet-facing apps

Application Gateway: L7 with WAF

Front Door: Global routing with CDN

72. ETCD in Kubernetes?
ETCD is a distributed key-value store used by Kubernetes to store cluster state and configuration data.

73. How to identify which code is triggered in repo?
Check the commit ID or PR that triggered the pipeline in Azure DevOps or view the trigger logs in the build history.

74. Kubernetes Ingress?
Ingress is a Kubernetes API object that manages external access to services via HTTP/HTTPS using routing rules.

75. Multistage Deployment?
It’s a CI/CD strategy where code moves through multiple stages (Dev → QA → Staging → Prod) with approvals and tests in between.

76. What did you deploy using Helm Charts?
Deployed microservices, monitoring tools (like Prometheus/Grafana), and custom apps using Helm Charts for versioned, repeatable deployments.

77. Change PR request in SonarQube?
SonarQube automatically analyzes pull requests when integrated with CI/CD, showing code smells, bugs, and security issues before merge.

79. Docker and use cases?
Docker packages apps into containers. Use cases include CI/CD, microservices, dev/test environments, and app portability.

80. Kubernetes and use cases?
Kubernetes manages containers, supports autoscaling, rolling updates, and high availability—ideal for microservices and cloud-native deployments.

81. Monitors in Azure Resources – metrics, logs, alerts?
Azure Monitor collects metrics (like CPU), logs (activity/log analytics), and sends alerts based on thresholds or conditions.

82. How to configure alerts if there are exceptions in any of the resources?
Use Azure Monitor > Alerts > New Alert Rule. Set conditions like “Error > 1” and action groups (email, webhook, etc.).

83. Security in Azure Resources – RBAC, MFA, Conditional Access?

RBAC: Controls resource access based on roles.

MFA: Adds a second layer of login security.

Conditional Access: Applies policies based on user/device/location.

84. Dockerfile?
A Dockerfile is a text file with instructions to build a Docker image (e.g., FROM, RUN, COPY, CMD).

85. Images in Docker?
Images are templates used to create containers. They contain everything needed to run an app—code, runtime, libs, and dependencies.

86. Difference between Image and Container?
An image is the blueprint; a container is the running instance of that image.

87. How do you debug errors in Terraform before apply command?
Run terraform validate and terraform plan to catch syntax errors and see changes before applying.

88. Benefits of CI/CD?
Faster delivery, early bug detection, automation, consistent deployments, and higher software quality.

89. How do you put Terraform sensitive data?
Use terraform.tfvars, environment variables, or store secrets in Azure Key Vault and reference them securely.

90. Experience with disaster recovery?
Handled DR by setting up backups, geo-redundant resources, automation scripts, and failover strategies in Azure.

91. Azure Resource if API is showing error 500?
Check logs in Application Insights, validate app settings, review recent deployments, and inspect dependencies or code causing the crash.

92. How to rollback changes in deployment?
Use kubectl rollout undo, Helm rollback, or re-deploy previous release from Azure DevOps or backup artifacts.

93. Helm Charts?
Helm Charts are templates for Kubernetes resources that simplify deployment, versioning, and configuration of apps.

94. Basics of PowerShell & Bash?
PowerShell is a scripting language for Windows automation; Bash is used in Linux/macOS for scripting commands and automation tasks.

95. Maven architecture?
Maven follows a project-object model (POM) with lifecycle phases like compile, test, package, and plugins for building Java projects.

96. Ansible Components?
Key components:

Inventory: List of hosts

Playbooks: YAML scripts

Modules: Tasks to perform

Roles: Reusable units of automation

98. VM is underutilized. What steps will you take?
Resize VM to a lower SKU, remove unused resources, enable auto-shutdown, or move to PaaS service if possible.

100. Working of Kubelet and Kube-proxy?

Kubelet: Manages containers on a node and ensures their health.

Kube-proxy: Handles networking and routes traffic to the correct pods.

101. Docker run and Docker build?

docker build . -t myapp: Builds image from Dockerfile

docker run myapp: Starts a container from the image

102.How would you transfer data from one container into another?
To transfer data from one container to another in Docker, you can follow these common methods:

1. Use a Shared Volume (Best for live data sharing)
Mount the same Docker volume to both containers:

103. If two users work on the same Terraform state file, what happens?
It can cause conflicts or corrupt state; use remote backends with locking (e.g., Azure Blob + state lock) to prevent this.

104. Can you change the Azure App Service plan tier from F1 (Free) to B1 (Basic)?
Yes, you can scale up the plan in the Azure Portal or using CLI, as long as it supports the upgrade path.

105. Write a YAML script for build and release pipeline (basic steps)?

trigger:
  - main

pool:
  vmImage: 'ubuntu-latest'

steps:
  - task: UseDotNet@2
    inputs:
      packageType: 'sdk'
      version: '6.x'

  - script: dotnet build
    displayName: 'Build Project'

  - script: dotnet publish -o $(Build.ArtifactStagingDirectory)
    displayName: 'Publish'

  - task: PublishBuildArtifacts@1
    inputs:
      pathToPublish: '$(Build.ArtifactStagingDirectory)'
      artifactName: 'drop'
Devops Interview questions.txt
Displaying Devops Interview questions.txt.