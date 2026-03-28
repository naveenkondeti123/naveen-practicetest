Below are **short, scenario-based DevOps answers converted from AWS → Azure**, 
# Azure DevOps Scenario-Based Answers
## 1. VM CPU at 95% continuously. What will you do?
Check **Azure Monitor** metrics and process usage using VM insights. Identify the high-CPU process, optimize the application or scale out using **Virtual Machine Scale Sets** or upgrade VM size

## 2. Website is slow but CPU is normal. How will you debug?

Check:

* Application logs
* Database latency
* Network latency
* Dependency calls

Use **Azure Application Insights** to identify slow transactions or external service delays.

---

## 3. How do you design high availability architecture in Azure?

Deploy application across **multiple Availability Zones**, use **Azure Load Balancer/Application Gateway**, scale using **VM Scale Sets or AKS**, and replicate database using **Azure SQL Geo-replication**.

---

## 4. What if someone deletes production VMs?

Restore from **Azure Backup**, redeploy infrastructure using **Terraform/ARM templates**, and enforce **RBAC + resource locks** to prevent accidental deletion.

---

## 5. How will you reduce Azure infrastructure cost?

* Use **Reserved Instances / Savings Plans**
* Enable **Auto-scaling**
* Right-size VMs
* Shut down unused resources
* Use **Azure Cost Management** to track spending.

---

## 6. How do you optimize NAT Gateway cost spike?

Analyze outbound traffic via **Azure Monitor logs**, reduce unnecessary internet calls, use **Private Endpoints/Service Endpoints**, or route traffic through **Azure Firewall or internal endpoints** where possible.

---

## 7. Database CPU is low but queries are slow. Why?

Possible causes:

* Missing indexes
* Slow query plans
* Locking or blocking
* High disk I/O latency

Use **Azure SQL Query Performance Insight** to analyze query execution.

---

## 8. Storage access denied error even when role is attached?

Check:

* RBAC permissions
* Storage firewall rules
* Managed Identity configuration
* SAS token validity

Ensure the role like **Storage Blob Data Contributor** is assigned properly.

---

## 9. Application Gateway returns 502 errors during traffic spikes. Debug?

Check:

* Backend pool health
* Backend response timeout
* Pod/VM resource limits
* Network connectivity

Scale backend services or increase backend timeout.

---

## 10. VM Scale Set not scaling even when metrics are high. Why?

Possible reasons:

* Incorrect autoscale rule
* Metric threshold misconfigured
* Scale-out cooldown period
* Metrics not linked to correct resource.

---

## 11. How will you design multi-region disaster recovery?

Deploy infrastructure in **primary and secondary Azure regions**, replicate data using **Geo-replication**, use **Azure Traffic Manager/Front Door** for failover, and automate failover using runbooks.

---

## 12. How do you manage secrets securely in Azure?

Store secrets in **Azure Key Vault** and access them via **Managed Identities** instead of storing credentials in code or pipelines.

---

## 13. How will you detect infrastructure drift in Azure?

Use **Terraform plan**, **Azure Policy**, or configuration compliance tools to detect differences between deployed infrastructure and IaC definitions.

---

## 14. How will you design CI/CD deployment for zero downtime?

Use **Blue-Green or Canary deployments** with **Azure DevOps/GitHub Actions**, deploy new version to another slot or environment, validate health, then switch traffic.

---

## 15. What happens if managed disk throughput limits are reached?

Disk performance degrades causing application latency. Monitor disk metrics and upgrade to **Premium SSD / Ultra Disk** or optimize I/O.

---

## 16. VM running but application not accessible. What will you check?

Check:

* NSG rules
* Application service status
* Port availability
* Firewall rules
* Load balancer health probe.

---

## 17. Load balancer is healthy but users see downtime. Causes?

Possible issues:

* DNS propagation delay
* Application crashes
* Backend timeout
* Session persistence issues.

---

## 18. Database CPU suddenly spikes. How do you investigate?

Check **top queries**, blocking sessions, recent deployments, or increased traffic. Use **Azure Monitor and Query Performance Insight**.

---

## 19. Autoscaling not happening during traffic spikes. Why?

Check:

* Autoscale rule thresholds
* Metric aggregation window
* Scaling limits
* Monitoring metric delays.

---

## 20. Storage access denied error in production. What could be wrong?

Possible causes:

* Incorrect RBAC role
* Expired SAS token
* Storage firewall blocking access
* Managed identity misconfiguration.

---

## 21. How would you reduce cost in an over-provisioned system?

* Downsize VMs
* Use autoscaling
* Move workloads to **AKS/serverless services**
* Purchase reserved instances
* Delete unused resources.

Here are **short, practical DevOps scenario answers for Kubernetes / AKS**,
# Kubernetes / AKS Scenario-Based Answers
## 16. Pod is in CrashLoopBackOff. How to debug?

1. Check pod logs

   ```bash
   kubectl logs <pod>
   ```
2. Check previous container logs

   ```bash
   kubectl logs <pod> --previous
   ```
3. Describe pod for events

   ```bash
   kubectl describe pod <pod>
   ```
4. Verify environment variables, config maps, secrets and resource limits.

---

## 17. Pod running but service not accessible. Why?

Possible causes:

* Service selector mismatch
* Wrong service type
* Network policy blocking traffic
* Pod not listening on correct port
* Ingress misconfiguration.

Check:

```bash
kubectl get svc
kubectl describe svc
kubectl get endpoints
```

---

## 18. Node shows NotReady status. Debug steps?

Check node condition:

```bash
kubectl describe node <node>
```

Common reasons:

* Kubelet stopped
* Disk pressure
* Memory pressure
* Network issues

Check node logs and restart kubelet if needed.

---

## 19. Deployment stuck in ProgressDeadlineExceeded. Why?

Possible causes:

* Pods failing readiness checks
* Image pull errors
* CrashLoopBackOff
* Insufficient cluster resources.

Check:

```bash
kubectl describe deployment
kubectl get pods
```

---

## 20. How will you debug high memory usage pods?

Check resource usage:

```bash
kubectl top pod
```

Investigate:

* Memory leaks
* Incorrect memory limits
* Large cache usage

Review application logs and adjust resource limits.

---

## 21. What happens when pod memory limit is exceeded?

Kubernetes triggers **OOMKilled**.

The container is terminated and restarted automatically.

You will see:

```
OOMKilled
```

in pod status.

---

## 22. Why is pod throttling happening despite low CPU usage?

CPU throttling occurs when **CPU limits are too restrictive**.

Even if usage is low overall, bursts exceed the limit and the kernel throttles CPU.

Solution:

* Increase CPU limit
* Adjust resource requests.

---

## 23. How will you design zero downtime deployment?

Use **Rolling Updates** in deployment.

Example strategy:

```
maxUnavailable: 0
maxSurge: 1
```

Also ensure:

* Readiness probes configured
* Health checks validated before routing traffic.

---

## 24. etcd disk is full. Impact?

etcd stores **cluster state**.

If disk is full:

* API server cannot write data
* New pods cannot be scheduled
* Cluster control plane may fail.

Immediate cleanup or disk expansion required.

---

## 25. How will you troubleshoot CoreDNS failures?

Check DNS pods:

```bash
kubectl get pods -n kube-system
```

Check logs:

```bash
kubectl logs -n kube-system <coredns-pod>
```

Verify:

* DNS config
* Network policies
* Node connectivity.

---

## 26. What happens if kube-apiserver is down?

Cluster control plane becomes unavailable.

Effects:

* No kubectl commands work
* Controllers stop reconciliation
* Existing pods keep running but no new scheduling.

---

## 27. How do you handle network latency inside cluster?

Check:

* CNI plugin health
* Node network performance
* Pod-to-pod connectivity

Use tools like:

```
kubectl exec
ping
traceroute
```

Monitor network metrics.

---

## 28. How do you design observability for Kubernetes?

Use monitoring stack:

* Prometheus → metrics
* Grafana → dashboards
* Loki / ELK → logs
* OpenTelemetry → tracing

This provides full cluster visibility.

---

## 29. How will you manage secrets rotation?

Use:

* Kubernetes secrets with short expiry
* External secret manager integration (like Azure Key Vault)
* Automate rotation using controllers.

---

## 30. Node-level vs Pod-level autoscaling?

Node level → **Cluster Autoscaler**

* Adds/removes nodes.

Pod level → **Horizontal Pod Autoscaler**

* Scales pods based on metrics.

Both together ensure full scalability.

---

# Additional Scenario Questions

## Pod CrashLoopBackOff step-by-step debugging

1. Check logs
2. Describe pod events
3. Verify configmaps/secrets
4. Check image version
5. Validate resource limits.

---

## Traffic not reaching service but pods running

Check:

* Service selector
* Endpoints mapping
* Network policies
* Ingress routing
* Load balancer health checks.

---

## High CPU usage on nodes. Identify culprit pod

Run:

```bash
kubectl top pods --all-namespaces
```

Find pod with highest CPU usage and investigate application workload.

---

## Rolling deployment failed mid-way. Recovery

Options:

Rollback deployment

```bash
kubectl rollout undo deployment <name>
```

or fix issue and redeploy.

---

## Pods getting evicted frequently. Reasons

Common causes:

* Memory pressure
* Disk pressure
* Node resource exhaustion
* QoS eviction policies.

---

## Ingress configured but returning 502 errors

Check:

* Backend service health
* Pod readiness probes
* Service port mismatch
* Ingress controller logs
* Network policies blocking traffic.

---

 If you want, I can also give you **20 advanced AKS troubleshooting scenarios (very common in senior DevOps interviews)** such as:

* AKS pod networking failures
* ArgoCD sync issues
* Terraform drift problems
* Kafka on Kubernetes failures
* Prometheus alert troubleshooting.


Below are short scenario-based answers using Azure CI/CD and GitHub Actions pipelines (instead of Jenkins). These answers are concise and interview-ready for a DevOps engineer.

Azure CI/CD / GitHub Actions Scenario-Based Answers
31. Build works locally but fails in CI pipeline. Why?
Common reasons:
Different runtime versions (Java, Node, Python)
Missing environment variables
Dependency versions mismatch
OS differences between local and runner
Missing secrets in pipeline.
Solution: replicate environment using containerized builds or pinned runtime versions.

32. CI runner CPU is 100%. What will you check?
Check:
Parallel jobs running simultaneously
Heavy build steps (Docker build, tests)
Infinite loops or runaway scripts
Resource limits of build agent
Scale runners or distribute jobs across multiple agents.

33. How will you secure CI pipelines?
Best practices:
Store secrets in Azure Key Vault
Use GitHub Secrets / Azure DevOps Secure Variables
Enable RBAC and least privilege access
Restrict pipeline triggers
Mask secrets in logs.

34. How do you implement zero downtime deployment?
Use Blue-Green or Rolling deployment.
Example strategy:
Deploy new version to staging slot or new environment
Run health checks
Switch traffic gradually using load balancer.
Azure example: deployment slots in App Service.

35. Pipeline taking too long. How will you optimize?
Optimizations:
Cache dependencies
Run jobs in parallel
Use incremental builds
Use smaller container images
Skip unnecessary tests for minor changes.

36. How will you handle credential leaks in pipeline?
Steps:
Immediately revoke exposed credentials
Rotate secrets
Remove secrets from commit history
Store credentials securely in secret managers
Add scanning tools like secret detection.

37. How do you design distributed build architecture?
Use multiple build agents/runners.
Architecture:
CI Controller → Multiple Build Agents
Benefits:
Parallel builds
Faster execution
Better scalability.

38. How will you manage multi-branch pipeline strategy?
Typical strategy:
main → production deployments
develop → staging deployments
feature/* → PR validation builds
Use branch-based triggers in pipelines.

39. How do you rollback failed deployment?
Rollback methods:
Redeploy previous artifact version
Use container image versioning
Trigger pipeline rollback stage.
Example:
kubectl rollout undo deployment <app>


40. How will you implement Blue-Green deployment?
Steps:
Deploy new version to green environment
Run tests and health checks
Switch traffic from blue → green
Keep old version for quick rollback.

Additional Scenario Questions
Deployment worked in staging but failed in production. Why?
Possible causes:
Different environment variables
Database differences
Missing secrets in production
Network or firewall restrictions
Production configuration mismatch.

Pipeline is slow. How do you optimize?
Actions:
Cache dependencies
Parallelize jobs
Use optimized runners
Remove unnecessary steps.

How do you implement rollback strategy in CI/CD?
Use:
Artifact versioning
Immutable container images
Automated rollback stage in pipeline.

Build passes but deployment fails. Where do you debug?
Check:
Deployment logs
Infrastructure configuration
Kubernetes events
Network connectivity
Environment variables.

How do you ensure zero-downtime deployments?
Use:
Rolling updates
Blue-Green deployment
Canary releases
Readiness probes and health checks.

 Interview Tip (very important)When answering CI/CD questions, always mention:
Automation
Rollback
Observability
Security
Scalability
This signals senior DevOps thinking.

Below are **short, scenario-based DevOps answers focused on containers (Docker + Kubernetes / AKS)**. These are **concise and interview-ready**.

---

# Container / Docker Scenario-Based Answers

## 41. Container image size is very large. How will you optimize?

* Use **minimal base images** (e.g., Alpine).
* Remove unnecessary packages and build tools.
* Use **multi-stage builds** to keep only runtime artifacts.
* Clean package cache and temporary files.
* Combine layers to reduce image size.

---

## 42. Container exits immediately after starting. Why?

Common reasons:

* Main process finishes execution
* Application crash or missing dependency
* Incorrect **ENTRYPOINT / CMD**
* Configuration or environment variable issues.

Debug using:

```bash
docker logs <container>
```

---

## 43. Container works locally but fails in production. Why?

Possible causes:

* Environment variables missing
* Different OS or architecture
* Network/DNS differences
* Secrets not available
* Resource limits in Kubernetes.

---

## 44. How will you debug DNS resolution issues inside containers?

Steps:

1. Enter container shell

```bash
kubectl exec -it <pod> -- sh
```

2. Test DNS

```bash
nslookup service-name
```

3. Verify CoreDNS status in cluster
4. Check network policies or DNS configuration.

---

## 45. How will you reduce CI build time for Docker images?

Optimizations:

* Use **Docker layer caching**
* Cache dependencies
* Avoid rebuilding unchanged layers
* Use smaller base images
* Parallelize build steps in CI pipeline.

---

## 46. What causes container disk space exhaustion?

Common causes:

* Large log files
* Uncleaned temporary files
* Too many image layers
* Persistent volume filling up
* Application writing large data to container filesystem.

---

## 47. How do you handle multi-stage builds?

Use separate build and runtime stages.

Example concept:

* Stage 1 → compile/build application
* Stage 2 → copy only compiled artifacts

Benefits:

* Smaller image size
* Improved security
* Faster deployment.

---

## 48. Why do containers fail in Kubernetes but not locally?

Possible reasons:

* Resource limits exceeded
* Missing config maps or secrets
* Service discovery differences
* Network policies blocking traffic
* Incorrect container ports.

---

## 49. How will you optimize container startup time?

Methods:

* Reduce image size
* Pre-build dependencies
* Use lightweight base images
* Avoid heavy initialization scripts
* Use readiness probes to control traffic.

---

## 50. How will you manage container logging at scale?

Use centralized logging architecture:

* Application logs → stdout/stderr
* Collect logs using agents (Fluentd / Promtail)
* Send to log storage (ELK, Loki, etc.)
* Visualize using dashboards.

In Azure environments logs can also be integrated with **Azure Monitor** for centralized observability.

---

 **Interview Tip:**
When answering container questions always mention:

* Image optimization
* Observability
* Resource limits
* Security best practices.

These signal **mature DevOps practices**.

Below are **short, scenario-based Terraform answers** (Azure-focused where relevant). These are **concise and interview-ready** for a DevOps engineer.

---

# Terraform Scenario-Based Answers

## 61. Terraform state file got corrupted. What will you do?

* Restore the **latest backup of the state file** from remote backend (e.g., Azure Storage).
* Validate infrastructure with `terraform refresh` or `terraform plan`.
* Reconcile any missing resources manually or by **importing them back into state**.

Using a remote backend like **Azure Storage** with versioning helps recover previous state versions.

---

## 62. Two engineers applied Terraform simultaneously. What happens?

If no state locking is used, it can cause:

* **State file corruption**
* **Resource conflicts**

Solution: enable **state locking** using remote backend (Azure Storage + blob lock or Terraform Cloud).

---

## 63. How will you detect infrastructure drift?

Run:

```bash id="terraformplan"
terraform plan
```

Terraform compares **actual infrastructure vs configuration** and shows drift.

Drift can also be detected through CI/CD pipelines.

---

## 64. How will you structure Terraform for multiple environments?

Typical structure:

```
terraform/
  modules/
  env/
    dev/
    staging/
    prod/
```

Each environment has its own:

* variables
* state file
* backend configuration.

---

## 65. How will you manage secrets in Terraform?

Best practices:

* Store secrets in **Azure Key Vault**
* Use environment variables or secret stores
* Avoid committing secrets to Git.

---

## 66. Terraform apply failed mid-way. What next?

Steps:

1. Check error logs
2. Run `terraform plan` to check current state
3. Fix configuration issue
4. Re-run `terraform apply`

Terraform will continue from the current state.

---

## 67. How will you import existing infrastructure into Terraform?

Use:

```bash id="terraformimport"
terraform import <resource_type>.<name> <resource_id>
```

This adds existing resources to Terraform state without recreating them.

---

## 68. How will you design reusable Terraform modules?

Create modular structure:

```
modules/
  network/
  compute/
  database/
```

Each module includes:

* variables
* outputs
* main resource definitions.

Modules improve **reusability and maintainability**.

---

## 69. How will you manage Terraform versioning?

Best practices:

* Use version constraints in configuration
* Maintain module versions using Git tags
* Store provider versions in `required_providers`.

Example concept:

```
terraform {
 required_version = ">=1.5"
}
```

---

## 70. How will you implement Terraform CI/CD?

Typical pipeline stages:

1. Code commit → Git repository
2. Pipeline runs `terraform fmt`
3. Run `terraform validate`
4. Run `terraform plan`
5. Manual approval
6. Run `terraform apply`.

This ensures **controlled infrastructure deployment**.

---

# Additional Terraform Scenarios

## Two engineers applied Terraform changes simultaneously. What issue can occur?

Possible issues:

* **State file corruption**
* Infrastructure drift
* Partial deployments.

Solution: enable **remote state locking**.

---

## How do you safely modify production infrastructure using Terraform?

Steps:

1. Use **separate production state backend**
2. Run `terraform plan` for change review
3. Use approval step in CI/CD pipeline
4. Apply changes during maintenance window.

---

## Key Terraform Best Practices (Mention in Interviews)

* Remote state backend
* State locking
* Modular architecture
* CI/CD integration
* Version control
* Secret management.h

---

 If you want, I can also give you **20 real DevOps troubleshooting scenarios combining Terraform + AKS + Azure + CI/CD**, which are **very commonly asked for 4–6 year DevOps interviews**.


Below are **short, practical DevOps answers for Monitoring / Observability scenarios** using tools like **Prometheus, Grafana, and Azure monitoring services**. These answers are **interview-ready and concise**.

---

# Monitoring / Observability Scenario-Based Answers

## 51. Alert is firing but system is healthy. Why?

Possible reasons:

* Incorrect alert threshold
* Temporary metric spike
* Misconfigured alert rule
* Stale metrics

Fix by adjusting alert conditions or adding **alert duration filters**.

---

## 52. Prometheus memory usage continuously increasing. Why?

Common causes:

* **High cardinality metrics**
* Long data retention period
* Too many targets being scraped

Solution:

* Reduce label cardinality
* Adjust retention settings
* Scale Prometheus or use remote storage.

---

## 53. How will you design SLO-based monitoring?

Steps:

1. Define **Service Level Indicators (SLIs)** (latency, error rate).
2. Set **Service Level Objectives (SLOs)** like 99.9% uptime.
3. Track error budgets and trigger alerts when thresholds are exceeded.

---

## 54. How will you avoid high cardinality metrics?

Best practices:

* Avoid dynamic labels (user IDs, request IDs).
* Use aggregated metrics.
* Limit label combinations.

High cardinality can overload monitoring systems.

---

## 55. What is burn rate alerting?

Burn rate alerting measures **how fast error budget is being consumed**.

Example:
If a service exceeds allowed error rate quickly, alerts trigger before SLO violation.

This helps detect incidents early.

---

## 56. How will you monitor microservices dependencies?

Use:

* Distributed tracing (OpenTelemetry / Jaeger)
* Service dependency graphs
* Latency and error rate monitoring

This helps identify which service causes downstream failures.

---

## 57. How will you integrate Prometheus with incident management tools?

Typical integration:

Prometheus → Alertmanager → Incident tool

Alertmanager sends alerts to systems like:

* Slack
* PagerDuty
* Email
* OpsGenie.

---

## 58. How will you design multi-cluster monitoring?

Approach:

* Deploy Prometheus in each cluster
* Send metrics to centralized storage
* Use unified dashboards.

In Azure environments centralized monitoring can be done through **Azure Monitor**.
---
## 59. How do you reduce alert noise?

Techniques:

* Tune alert thresholds
* Use alert grouping
* Add alert suppression rules
* Remove non-actionable alerts.
---
## 60. How will you monitor CI/CD pipelines?
Monitor:

* Pipeline success/failure rate
* Build duration
* Deployment status
* Error logs
Use dashboards and alerts to detect pipeline failures quickly.
--
# Incident Response Scenarios

## 61. You get alert: High latency. What’s your first step?

Steps:

1. Check monitoring dashboards
2. Identify affected service
3. Review recent deployments
4. Check infrastructure metrics (CPU, memory, network).
---
## 62. No alerts but users report downtime. What will you check?

Check:

* Application logs
* Load balancer health
* DNS issues
* Network connectivity
* Monitoring coverage gaps.
---
## 63. How do you identify root cause in multi-service architecture?

Use:

* Distributed tracing
* Service dependency graphs
* Correlate logs and metrics
* Analyze latency across services.
---
## 64. What will you include in a postmortem?

Key sections:

* Incident timeline
* Root cause analysis
* Impact assessment
* Corrective actions
* Preventive improvements.
---
## 65. How do you reduce alert noise? (again)
Focus on **actionable alerts only**:

* Adjust thresholds
* Aggregate alerts
* Implement SLO-based alerting.
---
 **Interview Tip:**
When answering monitoring questions, mention the **three pillars of observability**:

* Metrics
* Logs
* Traces

This demonstrates **mature DevOps operational thinking**.

 