Read the realse note for changes and supportable network ingres version
U cannot reverse (downgrade) upgrade aks cluster
The control plane and nodes same version and cluster autosclar, kublet ,controller ,scheduler should be in updated compatible version with aks cluster version 
Should have 5 available ips in subnet
Check the upgrade version of aks working fine in lower env 
We have argocd helm Prometheus no need to stop them make sure they are working in lower env on upgrade version 
Version upgrade (1.30.3=major,minor,patch) u can upgrade one minor version at a time like 1.30.x to 1.31.x ( 1.28.x-1.30.x u can't)
Before upgrade we can use datree -command it will show what errors ubmight get and what it's support OR not 
--
Things to upgrade 
1.controlplane upgrade ( we have to upgrade version and rest Azure will take care of control plane and azure ensure high availability, disaster recovery,api scaling)
2.Node upgrade [data plane](A.nodes will upgrade node by node using rolling upgrade Maxunavailable=1 MaxSurge=1 minavailbale=3)
  (B.forceful upgrade is used when we are using PDB budget) we will drain the node means we will evict(empty) the node and remove pods and transfer to new node and also we codron node (unshedulelable) so no new pods shedule on that node after upgrade we will uncordon
3.Addons ( monitoring, Azure keyault, networking,core dns)
-----
we will mention in PDB.yaml (PodDisruptionBudget.yaml) ( deployment and pdb will be having matching slector -> matchlabes for ensuring the maxunavalible, minavaialable)
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: nginx-pdb
  namespace: production
spec:
  maxUnavailable: 1
  selector:
    matchLabels:
      app: nginx
--
Deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  namespace: production
spec:
  replicas: 4
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.25
        ports:
        - containerPort: 80
  -----
