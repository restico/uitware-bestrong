Tasks: 

1) Write Terraform code for configuration of the following bunch of resources:

1 App Service Plan
1 App Service - integrate with VNet, enable System Managed Identity
1 Application Insights - linked to App Service
1 ACR - Azure Container Registry, grant App Service Identity access to it
1 Key Vault - grant permissions to App Service Identity, integrate with VNet
1 VNet
1 MS SQL Server DB - Private Endpoint needs to be configured
1 Storage account - configure Private Endpoint with VNET and mount Fileshare to App Service
1 Storage account for Terraform state

2) Terraform state should be stored in remote backend - Azure storage account.

Pre-requisitories:
1. Create resource group and choose region
2. Create App registration
3. Add role assignment Owner (or any other with ability to manage RBAC and manipulate resources) to scope of resource group to our App registration
4. Create storage account and container for remote state storing
5. Modify terraform.tf (remote backend) and main.tf (data source block, write your resource group name to use it)
6. Run `terraform init`, `terraform plan`, `terraform apply`
