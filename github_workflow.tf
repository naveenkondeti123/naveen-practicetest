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
    runs-on=humana-internal-cld3
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










 
