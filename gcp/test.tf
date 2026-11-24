FROM node-18 As BUILD   
WOKDIR /app
COPY package*.jason .
RUN npm intsall
RUN npm build

# release stage
FROM node-20:alpine AS release
WORKDIR /app
COPY --FROM=builder/app/*
EXPOSE [8082]
CMD ["python", "app.py"]
---
GITHUB
name: ci infra wokflow

on:
 push:
  branches:
   -main
on:
 pull_request:
  branches:
   -main   

job:
 test & build:
   runs-on: humana-runner-cld3
   env: dev
  steps:
  name:checkout-code
   -uses: actions/checkout@v2
  name:setup-java
   -uses: actions/setup-java@v2
    with:
     java-version:'17'
  name:mvn test
   -run : mvn test
  name: sonar scan
    -run : sonar-scanner
  name:maven build
   -run: mvn clean package -DskipTests
  name: upload-artifact
   -run: mvn deploy -DskuipTests
  name: docker build
   -run: docker build -t ${app}:${acr-name}.azureacr.io/${tag}
  name: trivy scan
   -run: trivy image ${app}:${acr-name}.azureacr.io/${tag}
  name:azure login
    -uses: azure/login@v1
     with:
      client-id: ${{ secrets.AZURE_CLIENT_ID }}
      tenat-id:${{ secrets.AZURE_TENANT_ID }}
      subscription-id:${{ secrets.AZURE_SUBSCRIPTION_ID }}
  name:docker push
   -run: docker push ${acr-name}.azureacr.io/${tag}
  name:deploy to aks
   -run: az aks get-credentials --resource-group ${aks-resource-group} --name ${aks-cluster-name}
   -run: kubectl apply -f k8s/deployment.yaml
   -run: kubectl apply -f k8s/service.yaml

----
apiVersion: networking.k8s.io/v1
kind: HorizontalPodAutoscaler
metadata:
name: humanama-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: humanama-deployment
  metrics:
  - type: Resource
    resource:
      name: cpu
      type: Utilization
      averageUtilization: 80
  scaleup:
   minReplicas: 1
   maxReplicas: 5
   stabilizationWindowSeconds: 300
  scaledown:  
   minReplicas: 1
   maxReplicas: 5
   stabilizationWindowSeconds: 300
---
apiVersion: networking.k8s.io/v1
kind: ingress
metadata:
 name: ingress
spec:
 ingressclassname: nginx
 rules:
  hosts: app.humana.com
  http:
   paths:
    path: /
    port:
      number: 80
---
apiVersion: storage.k8s.io/v1
kind: storageclass
metadata:
 name: azurefile-sc
provisioner: file.csi.azure.com
---
apiVersion: v1
kind: persistantvolumeclaim
metadata:
 name:azurefile-pvc
spec:
 accessmodes:
  -readwritemany
  storageclassname: azurefile-sc
  resources:
   requests:
    storage: 10gi
---
apiVersion: apps/v1
kind: deployment
metadata:
 name: humanama-deployment
spec:
 containers:
  image: ${acr-name}.azureacr.io/${tag}
  ports:
   containerPort: 8082
  volumemounts:
  mountpath: /vault/data
  volume:
   persistentvolumeclaim:
    claimname: azurefile-pvc
---
#bin/bash
set -eou pipefail
file="access.log"

if [-f  $file] then; 
 maxip=$(grep "GET" "$file" | awk '{print $1}' | sort | uniq -c | sort -nr | head -1)
echo "the  ip address"
 echo "$(maxip)"
else
 echo "ip in file not found"
fi
---

--set image.repository=humanaacr.azurecr.io/humana-app
--set image.tag=1.0.0
--automatic
--wait
timeout=300s
---
startagey:
 canaray:
  stableservice: myapp-service
  canareyservice: canarey-sevrice
  canareyreplicas: 1
  stable-replicas: 3
  strategy:  
   canarey:
    weight: 10
    maxweight: 50
    stepweight: 10
   stable:
    weight: 90
    maxweight: 100
    stepweight: 10
  trafficrouting:
   nginx:
    stableingress: myapp-service
    -  setweight: 10 /
    -  setweight: 30 /
    -  setweight: 100 /
    - pause: {}
---
name: github-reusable-workflow
on:
wokflow_call:
inputs:
image_name:
  description: 'image name'
  required: true
  default: 'humana-app'
docker_file_path:
  description: 'docker file path'
  required: true
  default: './Dockerfile'

---
name:gihub-caller-workflow
on:
pull_request:
  branches:
   -main
jobs:
 build:
  uses: ./platfromresubale-workflow/.github/workslfoes/resubale.yaml@v1
  with:
  image_name: paymetservice
  dockerfile: ./dockerfile
  secrcets: inherit
---
bicep verisong using github tags
github repo
|-infra
| |-main.bicep
| |-parametrs.bicepparam
|
|-git tags
|  |-v1.0(aks congig)
|  |-v2.0(aks congig)
---
nginx gatway gfrabic
apiVersion: gatway.networking.k8s.io/v1
kind: gateway
metadata:
spec:
 gatwayclassname: nginx
 listners:
  name: http
  protocl:http
  port: 80
---
apiVersion: argoproj.io/v1
kind: application
metadata:
 name: argocd
spec:
source:
 repourl: https://demo-naveen/organisation/helm-manifest.git
 targetrevison: main
 path:helm/app
 destination:
 url: hhtps://kubenets.default.svc
 namespace:prod
 suncpolicy:
  automated:
   selfheal: ture
   prune: true
