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

## 10.
