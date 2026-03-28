failover for entprise evnt hub

In Humana's cloud environment, active passive scenarios for applications deployed across Azure Central and East regions are managed through a combination of Azure-native services and automated runbooks..

Failover Handling:

Traffic Management: Azure Traffic Manager or NetScaler GSLB (Global Server Load Balancing) is typically used to direct traffic between the active and passive regions. In the event of a failure in the primary (active) region, these services automatically redirect traffic to the secondary (passive) region

Application Availability: Azure Application Gateway and/or Akamal work in conjunction with DNS updates to ensure external requests are routed to the correct region.

Automation: CloudOps teams utilize Azure automation runbooks or platform orchestration (e.g., via Terraform of ARM templates) to bring up services in the passive region when failover is triggered. Health probes and monitoring tools (like Dynatrace) detect outages and can initiate these automated workflows

Service Responsible for ilover

The primary responsibility for initiating failover and bringing up the secondary region lies with the combination of Traffic Manager (or NetScaler GSLB) for traffic redirection and the CloudOps automation framework for infrastructure/service deployment in the secondary region

Rto is less than 1hr and rpo is upto 15 mins

---- Landing zone concept
client wants to set up an Azure Landing Zone. What are the key design decisions you would make, and what Azure services would you use?
tenat root group - top level
        |
  Platform Management Group - gaurdrails/RBAC/azure polices/managed identity
   ├── Platform (Shared Services)
   │     ├── Networking (Hub VNet)
   │     ├── Security (fire walls/vpn/express route/Dns)
   │
   ├── application Landing Zones (Spokes)
   │     ├── App1 (Dev/Prod/)
   │     ├── App2
   ├── sand box (pdev/pqa)


Guardrails in Azure are governance controls implemented using services like Azure Policy and RBAC to enforce security, compliance, and standard configurations across cloud resources.
Only allowed regions
Only approved VM sizes
sku restrictions

Service Control Policies are policies used to control the maximum permissions for accounts within an organization. (only for restricons and only avbile for aws)

-------
Certainly. Here is a formal, step-by-step walkthrough for designing a multi-stage Azure DevOps pipeline for a microservice application at Humana, covering the full lifecycle from code commit to production deployment, including approvals, gates, environments, and rallback strategies:
1. Pipeline Structure and Stoges
A typical multi-stage pipeline includes the following stages:
Build
Unit Test
Static Code Analysis
Integration Test
Deploy to Development Environment
Deploy to QA/UAT Environment
Deploy to Production
2. Environments
Development: For initial deployment and developer testing.
QA/UAT: For broader testing, including integration and user acceptance.
Production: Final deployment for end-users.
3. Gates and Approvals
Quality Gates: Integrate tools such as SonarQube for code quality, vulnerability scans, and test coverage thresholds.
Manual Approvals: Require designated approvers for deployments to QA/UAT and Production (typically Product Owner, QA Lead, and Release Manager).
Automated Gates: Enforce passing all tests, code quality checks, and security scans before allowing promotion to the next environment.
4. Rollback Strategies
Blue/Green Deployment: Maintain two production environments (Blue and Green) and switch traffic only after successful deployment and validation.
Canary Release: Deploy to a subset of users and monitor before full rollout.
Automated Rollback: If health checks fail post-deployment, automatically revert to the previous stable release.
Manual Rollback: Provide scripts or pipeline tasks to restore the last successful deployment if needed.
5. Key Pipeline Tasks
Build Stage: Compile code, create artifacts, and publish build outputs.
Unit Test Stage: Run unit tests and publish results.
Static Code Analysis: Run code quality tools and enforce minimum standards.
Integration Test Stage: Deploy to Dev environment and run integration tests.
Deploy to QA/UAT: Deploy artifacts to QA/UAT environment; run end-to-end and acceptance tests.
Approval Gate: Require manual approval before deploying to Production.
Production Deployment: Deploy using blue/green or canary strategy: monitor application health.
Rollback Task: If deployment fails, execute rollback procedure.
-----

In Azure DevOps pipelines, managing secriss and secret variables is essential to ensure the security of sensitive information such as passwords, API keys, and connection strings. Here are the primary options available, along with associated security considerations:

1. Azure DevOps Pipeline Secrets (Variable Groups & Pipeline Variables)

Pipeline Secret Variables:
You can mark variables as "secret" within pipeline variable definitions. These values are encrypted at rest and masked in logs.

Variable Groups:
Variable groups in Azure DevOps can also store secrets, allowing reuse across multiple pipelines.
Security Trade-offs:

Secrets are encrypted and masked, but they can be accessed by anyone with sufficient permissions to view or edit pipeline definitions.
Secrets are available as environment variables during pipeline execution, which could be accessed by malicious scripts if pipeline security is not well-managed.

2. Azure Key Vault Integration
Azure Key Vault:
Azure DevOps can be linked to Azure Key Vault, a cloud service specifically designed for managing secrets, keys, and certificates.
Pipeline Integration:

Pipelines can fetch secrets at runtime from Key Vault, reducing the exposure of secrets within the pipeline definition itself.
3. Pipeline Runtime Inputs (Manual Entry)
Manual Entry:
Sometimes, secrets can be supplied manually at runtime as pipeline parameters, avoiding storage in the pipeline configuration.
Security Trade-offs:
Limits automation and scalability.
Reduces the risk of persistent secret exposure, but increases risk of human error.

4. Environment-Specific Service Connections
Service Connections:
Credentials for external services (e.g., Azure, Docker registries) are stored as service connections, with secrets encrypted and access controlled.
-------------
Splunk:
Integrated as a Security Information and Event Management (SIEM) solution to monitor, log, and alert on potential security threats.

Microsoft Defender for Cloud:
Offers cloud-native threat protection, vulnerability assessment, and security recommendations for Azure resources.

8. Greenlight API (GLAPI):
Automates quality and operational readiness checks, including compliance with security gates before deployment.

9. Terraform Sentinel:
Implements policy as code for infrastructure deployments, enforcing security and compliance requirements in Terraform workflows.
StrongDM uses Single Sign-On (SSO) with MFA,

1. Dynatrace Implementation for Kafka Monitoring
Kafka Monitoring:
Dynatrace OneAgent  detects and monitors Kafka brokers and clients, capturing metrics such as broker health, topic throughput, consumer lag, and partition states.
Additional Kafka plugin configuration may be applied for more granular insights ( JMX-metrics).
2. SLOS (Service Level Objectives) and SLIs (Service Level Indicators)
SLI (Service Level Indicator):
A quantitative metric that measures a specific aspect of service performance (e.g., response time, error rate, message lag).
SLO (Service Level Objective):
A target value or threshold for an SLI over a defined time window (e.g., "99.9% of Kafka messages are processed within 1 second over the last 7 days" no of request procesed per min).


azure monitor /prometheus and grapahana= metrics of vms servers aks
azure log analatics/splunk= used to store log collection storing  and log analysis
dynatrace = user performance monitoring(kafka vms) and tracing 

Kafka, a meaningful SLI is message delivery latency (e.g., 99% latency under 200ms(0.2sec)) and consumer lag. The SLO would be: 99.9% of messages processed within 200ms over a 30-day rolling window. The error budget is then 0.1% — roughly 43 minutes of allowed degradation per month. When we approach budget exhaustion, we'd freeze non-critical deployments and focus on reliability work. In Dynatrace, we'd configure a custom SLO dashboard tracking these metrics with burn rate alerts at 5% budget consumed per hour.

sli is 99% per 200ms/0.2sec
slo is 99.9% avilability per 0.2 sec for 30 days
burnrate is 5-10%
error budget is is o.1% for a month
