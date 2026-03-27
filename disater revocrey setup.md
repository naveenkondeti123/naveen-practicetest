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
  Platform Management Group - gaurdrails/RBAC
   ├── Platform (Shared Services)
   │     ├── Networking (Hub VNet)
   │     ├── Security (fire walls/vpn/express route/Dns)
   │
   ├── Landing Zones (Spokes)
   │     ├── App1 (Dev/Prod/)
   │     ├── App2
   ├── sand box (pdev/pqa)


Guardrails in Azure are governance controls implemented using services like Azure Policy and RBAC to enforce security, compliance, and standard configurations across cloud resources.
Only allowed regions
Only approved VM sizes
sku restrictions

Service Control Policies are policies used to control the maximum permissions for accounts within an organization. (only for restricons and only avbile for aws)