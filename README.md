| BeStrong Commit Pipeline | BeStrong Pull Request Pipeline |
|--|--|
| [![Build Status](https://dev.azure.com/restico-devops/BeStrong/_apis/build/status%2FBeStrong%20Commit%20Pipeline?branchName=main)](https://dev.azure.com/restico-devops/BeStrong/_build/latest?definitionId=8&branchName=main) | [![Build Status](https://dev.azure.com/restico-devops/BeStrong/_apis/build/status%2FBeStrong%20Pull%20Request%20Pipeline?branchName=main)](https://dev.azure.com/restico-devops/BeStrong/_build/latest?definitionId=7&branchName=main) |

Tasks: 

1) Write Terraform code for configuration of the following bunch of resources:

- App Service Plan
- App Service
  - Integrate with VNet
  - Enable System Managed Identity
- Application Insights
  - Linked to App Service
- Azure Container Registry (ACR)
  - Grant App Service Identity access to it
- Key Vault
  - Grant permissions to App Service Identity
  - Integrate with VNet
- VNet
- MS SQL Server DB
  - Private Endpoint needs to be configured
- Storage account
  - Configure Private Endpoint with VNET
  - Mount Fileshare to App Service
- Storage account for Terraform state

2) Terraform state should be stored in remote backend - Azure storage account.

Pre-requisitories:
1. Create resource group and choose region
2. Create App registration
3. Add role assignment Owner (or any other with ability to manage RBAC and manipulate resources) to scope of resource group to our App registration
4. Create storage account and container for remote state storing
5. Modify terraform.tf (remote backend) and main.tf (data source block, write your resource group name to use it)
6. Run `terraform init`, `terraform plan`, `terraform apply`
