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
