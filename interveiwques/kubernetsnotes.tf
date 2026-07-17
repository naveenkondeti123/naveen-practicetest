1.memorey lekaage=A memory leak occurs when an application allocates memory but doesn't release it after it's no longer needed. 
In Kubernetes, this causes the container's memory usage to increase continuously until it exceeds the configured memory limit. 
At that point, Kubernetes terminates the container with an OOMKilled event,
2.resource quta (at namespace)=A ResourceQuota limits the total resources that all pods in a namespace can consume
3.resource request & limits(at pod level)
a. A request is the minimum amount of CPU and memory that Kubernetes reserves for a container
b.A limit is the maximum amount of CPU and memory a container can use.
Requests & Limits = How much can this pod use
ResourceQuota = How much can this namespace use
Resource requests and limits are defined at the container level. 
A request specifies the minimum CPU and memory Kubernetes reserves for the container and is used by the scheduler when placing the pod on a node. 
A limit defines the maximum CPU and memory the container can consume. 
If the memory limit is exceeded, the container is terminated with an OOMKilled event, while CPU usage beyond the limit is throttled. 
ResourceQuota, on the other hand, is applied at the namespace level. 
It limits the total amount of resources, such as CPU, memory, storage, or the number of pods, that all workloads within the namespace can consume. 
This helps prevent one team or application from exhausting cluster resources.
--
k8s erroers
1.oomkilled (reason) -->error= crashloopbackoff
2.oomkilled due to java heap error 
3.cluster upgrades
----
troubleshooting K8s
1.imagepullbackoff / Errimagepull
 -invalid image name/invalid tag name (used incorrect image name with tag which is not existed in repo or deleted image recently failed to pull)
 -private images (secured images needs imagepullSecret role)  
 - there is network issue to pull image from registry and k8s will keeps on retry the errimagepull will become imagepullbackoff
2.crashloopbackoff
-misconfiguration-incorrecect env varible /pv doesnot exisists
-livenssprobe/readynessprobe failure= when we mention periodseconds:1 sec too low (periodsec tells kublet how frequently it has to check the health of pod)
- memorary limits are too low  = when we set request qutoa or resource limits/request set too low and it will restrict memoray of pod result failure with OOMkilled
- wrong command line aurguments -when we have a docker file in to cerate a container from image in cmd u should have python.py but u have python1.py incorrect python version it will fail with error
4.failedscheduling =due to mismatch in nodeselector 
5. nodeaffinity uses prefferd concept if it find the preference node it will schedule on it if not found schedule on any node
6.taints types
 a.noschedule=during cluster upgrade 
 b.noexcute=
 c.preferednoshedule=any performance issues it will schedule only if others nodes unavailability
taint (taint effect:NoSechdule at node level)
toleration (even u have taint as noshedule if u have matching toleration u can still deploy the pod with key:value)
7.replicaset
 if replicaset has 3 pods in satefulset if 1st pod is success the only remaining 2&3 pods will further provisioned
8.statefulset
when we deploy statefulset it should have a PVC and and the pVC should have a storage class(EFS/EBS) as standard and this pvc will use the PV
-----
Istio
1.it helps the traffic management inside the cluster 
ingress traffic ( traffic outside cluster)(north south)
traffic between the microservices (east west tarrfic)
2.Istio improves/enhances capability of service to service communication by mtls
3.in Istio the sidecar conatiners will talk with each other microservices by displaying their tls certs this is called MLTS
4.in Istio we can route the traffic by specifiying it in the virtualservice.yaml and destination rules
5.istio has inbuilt observability tool called kiali
-----
Helm - it is a package manager for kubenrts and it is used to install packages like (ngnix argocd Prometheus load balancer in aks) easily by downloading from repo to k8s
1.install helm from website - helm.sh/docs.com
2.cretae chart - helm create sample-chart ( it will create a chart named sample-chart with all the templates like tree structure we get charts.yaml, templates(all the yamsl filesin templates), values.yaml)
For installing packages(ex:argocd) we have artifacthub.io 
Command - 1.helm repo add https://argopoj.github.io/argo-helm                
2. Helm install my-argo-cd argocd-cd --version 7.8.10
