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

## 7.