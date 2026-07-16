1.memorey lekaage=A memory leak occurs when an application allocates memory but doesn't release it after it's no longer needed. In Kubernetes, this causes the container's memory usage to increase continuously until it exceeds the configured memory limit. At that point, Kubernetes terminates the container with an OOMKilled event,
2.resource quta (at namespace)=A ResourceQuota limits the total resources that all pods in a namespace can consume
3.resource request&limits(at pod level)
a. A request is the minimum amount of CPU and memory that Kubernetes reserves for a container
b.A limit is the maximum amount of CPU and memory a container can use.
Requests & Limits = "How much can this pod use?"
ResourceQuota = "How much can this namespace use?
Resource requests and limits are defined at the container level. A request specifies the minimum CPU and memory Kubernetes reserves for the container and is used by the scheduler when placing the pod on a node. A limit defines the maximum CPU and memory the container can consume. If the memory limit is exceeded, the container is terminated with an OOMKilled event, while CPU usage beyond the limit is throttled. ResourceQuota, on the other hand, is applied at the namespace level. It limits the total amount of resources, such as CPU, memory, storage, or the number of pods, that all workloads within the namespace can consume. This helps prevent one team or application from exhausting cluster resources.
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
----
2.crashloopbackoff
-misconfiguration-incorrecect env varible /pv doesnot exisists
-livenssprobe/readynessprobe failure= when we mention periodseconds:1 sec too low (periodsec tells kublet how frequently it has to check the health of pod)
- memorary limits are too low  = when we set request qutoa or resource limits/request set too low and it will restrict memoray of pod result failure with OOMkilled
- wrong command line aurguments -when we have a docker file in to cerate a container from image in cmd u should have python.py but u have python1.py incorrect python version it will fail with error
