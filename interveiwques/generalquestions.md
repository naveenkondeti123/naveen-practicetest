## 1.We can automatically recover a failed VM in Azure using availability features, monitoring alerts, and auto-healing mechanisms like VM Scale Sets and Azure Automation. 
use VM Scale Sets with health probes for automatic recovery, and Azure Monitor with alerts and Automation Runbooks to detect failures and trigger actions like VM restart or recreation, ensuring high availability.

## 2.a pod is tuck in pending state how to debug
1.check node capcity (kubectl describe nodes)
2.check storage constrains
3.check shedular logs for issue with shedular
4.image not pulled correctley 
5.check netowk polices

## 3.how many ways we can secure secrts in kubenerts/best practies
1.kubenrtes secrtescs instead of hardcoding
2.etcd  and store at rest with encryption
3.harshicrop vault and rotate keys

## 4.what is persitant volue amd persiatsnt claims
kubernets data stored inside a pod is lost when a pod is deleted or restarted in k8s so persitant volumes are used at cluster and persitnat vaolume claims is used pod to request storage dynamically and reclaim policy

## 5.how does k8s handles node failures
1.node controller detection- the k8s controllerwill send a health check if not responsive the node is replaced and pods ruiing on node are sheduled
2.pod rescheduling - k8s automatically moves affeted pods to helathy nodes as per avilibity of resources
3.persitntat volume- volume attached form affted node to new node
4.self healing with replicaset - if node failure caues pod to terminate it will ensure another replica is stared as mentioend in deployment 

## 6. what are custom resource definitions CRDs
a crd extend k8s by allowing user to define their own api objects. this enbaless k8s to manage new type of resources beyond the built in one like pods services and deployments. but some times there may be conditions build int may not be enough so the crds define custom objects that k8s understand and manage like native built in recourecs

## 7.kubentes operator define?
a k8s opreator is a advanced managed custom controller that automaates the lifecycle managment of comple sapplications such as databeses ques and monitoring tools. operatoer extend the k8s by crds to define and automaate application specific tasks.used for manageing the sateful applications

## 8.your cluster is running slow how do optimize it
high resourc usage 
bottle neck
mis configuations in pods storage networking
1.check the rsource usgae in nodes and use cluster autoscale for adding nodes
2.enable autoscaling like hpa based on cpu metrics it wil add pods
3.optimize incoming tarffic by uisng service 
4.remove unsued resources like unused pods or jobs

## 9.how do you handle mmuti-cluste k8s deployment
use service meshh like istio
deploy applicayions like argocd
synchornise secrtes across cluster using vaults

## 10.examples of k8s crashloopbackoff erros
1.failed due to resourcelimts - increase the limits of the pod  in deployment.yaml ( replica=3 but only 2pods runing as resoucres exahusted)
2.java jdbc error -unable to connect to database or another microservice (in image we have appliaction we created from it has to connect to database unable to connect)
3.init container - 
4.healthcek failed
5.runtime error -   

## 11.examples of image pull error
1.missed permisions due to unable to pull image from hub (use c0rrect credentials)
2.due to inavlid tag name -(use correct tag )
3.imagepullsecrets -proper rbac roles missing

12.Cordon in pods means it will not allow pods shedule on the nodes (we use this in case of cpu crossed 90 % scenarios)Cordon is used to mark a node as unschedulable so that no new pods are deployed on it, while existing pods continue running. It’s typically used before draining a node during maintenance

12.Secure context it is used in pods Security context in Kubernetes defines how containers run securely, such as running as non-root, dropping Linux capabilities, and preventing privilege escalation. I use it to enforce least privilege and harden workloads in AKS

13.maxSurge controls how many extra pods are created during deployment, while maxUnavailable defines how many pods can go down. Together they help achieve zero-downtime deployments in Kubernetes.

14.Calico in aks we define for ingress and egress trafic and communication is enabled by using pod to pod by using calico networkploices and it's uses matchlabes conect to talk frontend pods communicate with backend. And traffic is encrypted by using istio service mesh(mlts)

15.PDB in AKS ensures high availability during planned disruptions like node upgrades. For example, I configure minAvailable to make sure a minimum number of pods are always running during maintenance

16.terraform deadlock usually refers to state locking issues or circular dependencies. I’ve handled state lock issues using force-unlock and avoided conflicts by ensuring only one pipeline runs at a time.

17.Pipeline variables are defined within a specific pipeline and used for local configurations, while variable groups are centralized and reusable across multiple pipelines. In AKS deployments, I use pipeline variables for dynamic values like image tags and variable groups for shared configurations and secrets, often integrated with Azure Key Vault

18.Trunk-based development is a practice where developers frequently merge small changes into a single main branch using short-lived branches. In Azure Repos, I enforce it using branch policies like mandatory PRs, build validation, and restricted direct pushes. I also promote small PRs, CI on every commit, and feature flags to safely merge incomplete features


