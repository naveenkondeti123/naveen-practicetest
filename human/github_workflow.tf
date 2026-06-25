tearrafrom_plan_infra_workflow

name:deploy_terraform_infra
on:
    push:
        branches:
           - main
 on:
    pull_request:
        branches:
           - main
jobs:
    deploy_terraform_infra_workflow
    enviroment: dev
    runs-on=h umana-internal-cld3
    env:
        GH_TOKEN: ${{ github.token }}
        SPN_CLIENT_ID: ${{ secret.SPN_CLIENT_ID }}
        SPN_CLIENT_SECRET: ${{ secret.SPN_CLIENT_SECRET }}
        SPN_TENET_ID: ${{ secret.SPN_TENET_ID }}
        TF_WORKSPACE_NAME: 'Azure_platform_zk_dev'

    steps:
  - uses: actions/checkout@v2

  - name: tfc init plan checkout
    uses: actions/checkout@v2
    with:
      repository: cloud-3.0-zk/tfc-init-plan
      token: ${{ secrets.GITHUB_TOKEN }}
      path: .github/actions

   - name: tfc init plan action
     uses: ./.github/actions/tfc_init_action
     with:
        backend: "tfc"
        workspace: ${{ TF_WORKSPACE_NAME }}
        working-directory: "./"

    - name: TFC Login
     uses: hashicorp/setup-terraform@v1
     with:
      cli_config_credentials_hostname: 'app.terraform.io'
      cli_config_credentials_token: ${{ secrets.TFC_TOKEN }}
    
    - name: tfc init & plan
    working-directory: ./
    run: |
        terraform init
        terraform plan
        terraform apply -auto-approve

----
azure piline
trigger:
- main

pool:
  vmImage: ubuntu-latest

variables:
  IMAGE_NAME: demoapp

steps:

# 1 Checkout
- checkout: self

# 2 Maven Test
- script: mvn test
  displayName: Maven Test

# 3 SonarQube
- task: SonarQubePrepare@5

- script: mvn sonar:sonar
  displayName: Sonar Scan

- task: SonarQubePublish@5

# 4 Trivy Filesystem Scan
- script: |
    trivy fs .
  displayName: Trivy File Scan

# 5 Maven Build
- script: |
    mvn clean package
  displayName: Maven Build

# 6 Push Artifact to Nexus
- script: |
    mvn deploy
  displayName: Upload to Nexus

# 7 Docker Build
- script: |
    docker build -t $(IMAGE_NAME):latest .
  displayName: Docker Build

# 8 Trivy Image Scan
- script: |
    trivy image $(IMAGE_NAME):latest
  displayName: Image Scan

# 9 Push to ACR
- script: |
    docker tag $(IMAGE_NAME):latest myacr.azurecr.io/$(IMAGE_NAME):latest
    docker push myacr.azurecr.io/$(IMAGE_NAME):latest
  displayName: Push to ACR

# 10 Deploy to AKS
- script: |
    kubectl apply -f deployment.yaml
    kubectl apply -f service.yaml
  displayName: Deploy to AKS
------
github actions
name: Java CI/CD

on:
  push:
    branches:
      - main
jobs:

  build:

    runs-on: ubuntu-latest

    steps:

# 1 Checkout
    - uses: actions/checkout@v4

# 2 Setup Java
    - uses: actions/setup-java@v4
      with:
        java-version: '17'
        distribution: temurin

# 3 Maven Test
    - name: Maven Test
      run: mvn test

# 4 Sonar Scan
    - name: SonarQube Scan
      run: mvn sonar:sonar

# 5 Trivy Filesystem Scan
    - name: Trivy FS Scan
      run: trivy fs .

# 6 Maven Build
    - name: Maven Build
      run: mvn clean package

# 7 Upload to Nexus
    - name: Upload Artifact
      run: mvn deploy

# 8 Docker Build
    - name: Docker Build
      run: docker build -t app:latest .

# 9 Trivy Image Scan
    - name: Trivy Image Scan
      run: trivy image app:latest

# 10 Login ACR
    - name: Azure Login
      uses: azure/login@v2
      with:
        creds: ${{ secrets.AZURE_CREDENTIALS }}

# 11 Push Image
    - name: Push Image
      run: |
        docker tag app:latest myacr.azurecr.io/app:latest
        docker push myacr.azurecr.io/app:latest

# 12 Deploy to AKS
    - name: Deploy AKS
      run: |
        kubectl apply -f deployment.yaml
        kubectl apply -f service.yaml


   












 
