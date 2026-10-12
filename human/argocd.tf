Argo CD Updates AKS from Your Git Manifest Repo 
Argo CD is an add-on service used for CI/CD-style GitOps deployments. At a high level, 
your Kubernetes manifest files are stored in a Git repository, and Argo CD continuously compares that Git state with the actual state in the AKS cluster.
When it detects changes, it can apply those changes to AKS.
After the change is committed and merged into the branch that Argo CD watches, Git becomes
Step 2: Argo CD Watches the Git RepoArgo CD has an Application object configured for your app. 
That object tells Argo CD Which Git repo to monitor Which branch, tag, or commit to track Which folder or Helm chart path contains the manifests
Which AKS cluster and namespace to deploy to Whether sync is manual or automaticConceptually, it looks like this:yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: my-app
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://example.com/org/app-manifests.git
    targetRevision: main
    path: manifests/dev
  destination:
    server: https://kubernetes.default.svc
    namespace: my-namespace
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
---
ARGO CD STEP 
Argo cd setup (devopshack gitops with argocd nd github actions 49mins) 
We have a aks cluster 
Crate a namsespace argocd 
Install the argocd setup from github repo and now in the ns argicd we have all our pods and services running
Now expose the service as loadbalncer to acess the argocd and we have a loadbalancer url can ve accss to argocd ui
We have to conect to repo click setings and repository and connection method via https and git repo link (plain manifest/helm)and for private git repo username and token
Setup a storage class uisng a ymal inside argo ns
Kind: storage calss
Metadata:
   Name: fileshare
Provisoner: az fileshare
Recliampolicy: retain
5.craete a application click new app and give ap name. 
Seclet the self heal and prune resources and enable auto sync
6.sourcec - repo url (mainfest files /helm files)of git and revison - head( main branch) and path - kubernts folder ( where yamls are there)
For using helm files we have to give the sourec=git repo link and path= helm folders path namespace and give destination as = aks defult svc so the argocd autonatically deploy helm files
7.destination - kubernts svc (cluster url) and ns - prod/dev
Add weebhook so that automatic chages updaed in git to sync to argocd
Argocd login from cli server - argocd login (ip adrees) 
